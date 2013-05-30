class ItemsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user_id = params[:user_id].to_i

    if(@user_id != 0 && @user_id != current_user.id)
      redirect_to user_items_path(current_user)
    else

      @items = Item.where(user_id: current_user.id)

      respond_to do |format|
        format.html # index.html.erb
        format.json { render json: @items }
      end
    end
  end

  def search
    @user_id = current_user.id
    val = params[:search_box]
    type = params[:type].to_i

    if(val == "" || val == nil)
      @items = []    
    elsif(type == 0)
      @items = Item.where("name ILIKE ?", "%#{val}%").select{|e| e.user_id != @user_id}
    else
      @items = Item.where("name ILIKE ?", "%#{val}%").select{|e| e.item_type_id == type}.select{|e| e.user_id != @user_id}
    end

    respond_to do |format|
      format.html { render :search }
      format.json { render json: @items }
    end
  end

  def show
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
    @item_types = ItemType.all.sort_by{|e| e[:name]}
    @item = Item.find(params[:id])
    @user = current_user
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
    @item = Item.find(params[:id])

    respond_to do |format|
      if @item.update_attributes(params[:item])
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
end
