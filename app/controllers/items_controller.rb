class ItemsController < ApplicationController
  before_filter :authenticate_user!
  helper_method :sort_column, :sort_direction

  def index
    @user_id = params[:user_id] ? params[:user_id].to_i : current_user.id

    @items = Item.order(sort_column + " " + sort_direction).select{|e| e.user_id == @user_id}

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @items }
    end
  end

  def search
    @user_id = current_user.id
    val = params[:search_box]
    type = params[:type].to_i

    if(val == "" || val == nil)
      @items = nil
      @your_items = nil 
    elsif(type == 0)
      @i = Item.where("name ILIKE ?", "%#{val}%")
      @your_items = @i.select{|e| e.user_id == @user_id}
      @items = @i.select{|e| e.user_id != @user_id}
    else
      @i = Item.where("name ILIKE ?", "%#{val}%").select{|e| e.item_type_id == type}
      @your_items = @i.select{|e| e.user_id == @user_id}
      @items = @i.select{|e| e.user_id != @user_id}
    end

    respond_to do |format|
      format.html { render :search }
      format.json { render json: @items }
    end
  end

  def req
    @user = User.find(params[:user_id])
    @item = Item.find(params[:id])

    @start = params[:start_date]

    start_year = @start.split("/").last

    @return = params[:return_date]

    return_year = @return.split("/").last

    if( (start_year != return_year && start_year < return_year) || @start <= @return )   
      @request = Request.new(start_date: @start, return_date: @return)
      @request.user_id = @user.id
      @request.item_id = @item.id
      @request.requester_id = current_user.id
      if @request.save
      else
        respond_to do |format|
          format.html { render action: "show" }
          format.json { render json: @item.errors, status: :unprocessable_entity }
        end
        return
      end
    else
      respond_to do |format|
        format.html { render action: "show" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end

    respond_to do |format|
      format.html { redirect_to user_item_path(@user,@item), notice: 'Item was successfully requested! ' + @user.first_name + ' will be notified.' }
      format.json { render json: @item}
    end

  end

  def show
    @user_id = params[:user_id].to_i
    @item = Item.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @item }
    end
  end

  def new
    @user = current_user
    @item = Item.new
    @item_types = ItemType.all.sort_by{|e| e[:name]}

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @item }
    end
  end

  def edit
    @item = Item.find(params[:id])
    @user_id = params[:user_id].to_i

    if(@user_id != 0 && ( @user_id != current_user.id || @item.user_id != current_user.id ))
      redirect_to user_items_path(current_user)
    else

      @user = current_user
      @item_types = ItemType.all.sort_by{|e| e[:name]}
      
    end
  end

  def create
    @item_types = ItemType.all.sort_by{|e| e[:name]}
    @item = Item.new(name: params[:item][:name])
    @user = current_user
    @item_type_id = params[:item][:item_type]

    @item.user_id = @user.id
    if(@item_type_id != nil)
      @item.item_type = ItemType.find(@item_type_id)
    end

    respond_to do |format|
      if @item.save
        format.html { redirect_to user_items_path, notice: 'Item was successfully created.' }
        format.json { render json: @item, status: :created, location: @item }
      else
        format.html { render action: "new" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    @user = current_user
    @item = Item.find(params[:id])

    @item_type = ItemType.find(params[:item][:item_type])
    @item.item_type_id = @item_type.id

    @item.name = params[:item][:name]

    if(params[:item][:remove_image] == "1")
      remove_img(@item)
      @item.remove_image = "1"
    elsif(params[:item][:image] != nil)
      @item.remote_image_url = nil
      @item.image = params[:item][:image]
    elsif(params[:item][:remote_image_url] != nil)
      @item.image = nil
      @item.remote_image_url = params[:item][:remote_image_url]
    else
    end

    respond_to do |format|
      if @item.save
        format.html { redirect_to user_items_path, notice: 'Item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @item.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy

    respond_to do |format|
      format.html { redirect_to user_items_path }
      format.json { head :no_content }
    end
  end

  private

  def sort_column
    Item.column_names.include?(params[:sort]) ? params[:sort] : "name"
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end

  def remove_img(item)
    if(item.image.file != nil)
      if(File.exist?("#{Rails.root}"+"/public"+item.image.thumb.url))
        File.delete("#{Rails.root}"+"/public"+item.image.thumb.url)
      end
      if(File.exist?("#{Rails.root}"+"/public"+item.image.url))
        File.delete("#{Rails.root}"+"/public"+item.image.url)
      end
    end
  end
end
