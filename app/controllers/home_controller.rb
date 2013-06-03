class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    # @requests = Request.all
    # @new_requests = []
    # @unresponded = []
    # @requesters = []
    # @index = 0

    # if(current_user.last_sign_in_at < current_user.current_sign_in_at)
      
    #   @requests.each do |request|
    #     if(request.updated_at > current_user.last_sign_in_at)
    #       @new_requests.push(request)
    #     end
    #   end

    #   @new_requests.sort_by{|e| e[:updated_at]}      

    #   @new_requests.each do |req|
    #     @requesters.push(User.find(req.requester_id))
    #   end

    #   current_user.last_sign_in_at = current_user.current_sign_in_at
    #   current_user.save
    # else
    #   @unresponded = Request.where(user_id: current_user.id, approved: nil).sort_by{|e| e[:created_at]}

    #   @unresponded.each do |req|
    #     @requesters.push(User.find(req.requester_id))
    #   end
    # end

  end

  def browse
    @items = Item.all
    @item_types = ItemType.all.sort_by{|e| e[:name]}

    respond_to do |format|
      format.html
      format.json { render json: @items }
    end
  end

  def find
    @item_name = params[:name]
    @items = Item.where("name ILIKE ?", "%#{@item_name}%")

    respond_to do |format|
      format.html
      format.json { render json: @items }
    end
  end
end
