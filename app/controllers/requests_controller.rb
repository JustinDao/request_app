class RequestsController < ApplicationController

  def index
    @requests = Request.where(user_id: current_user.id).sort_by{|e| e[:created_at]}

    @awaiting = []
    @responded = []

    @your_requests = Request.where(requester_id: current_user.id).sort_by{|e| e[:created_at]}

    @requesters = []

    @requests.each do |req|
      @requesters.push(User.find(req.requester_id))
      if(req.approved == nil)
        @awaiting.push(req)
      else
        @responded.push(req)
      end
    end

    @index = 0

    respond_to do |format|
      format.html
      format.json { render json: @requests }
    end
  end

  def approve
    @request = Request.find(params[:request_id])
    @request.approved = true
    @request.save

    @other_requests = Request.where(user_id: @request.user_id, item_id: @request.item_id)

    start_year = @request.start_date.split("/").last
    return_year = @request.return_date.split("/").last

    @other_requests.each do |o|
      o_start_year = o.start_date.split("/").last
      o_return_year = o.return_date.split("/").last
      if( (o.start_date < @request.return_date && o.start_date > @request.start_date) || 
        (o.return_date < @request.return_date && o.return_date > @request.start_date) ||
        (o_start_year >= start_year && o_start_year < return_year) ||
        (o_return_year <= return_year && o_return_year > start_year) )
        o.approved = false
        o.save
      end
    end

    respond_to do |format|
      format.html { redirect_to my_requests_path }
      format.json { render json: @request }
    end
  end

  def deny
    @request = Request.find(params[:request_id])
    @request.approved = false
    @request.save

    respond_to do |format|
      format.html { redirect_to my_requests_path }
      format.json { render json: @request }
    end
  end

  def destroy
    @request = Request.find(params[:id])
    @request.destroy

    respond_to do |format|
      format.html { redirect_to my_requests_path }
      format.json { head :no_content }
    end
  end

end
