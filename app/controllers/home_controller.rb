class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user_id = current_user.id
    @user_items = Item.where(user_id: @user_id)
  end

  def browse
    @items = Item.all
    @item_types = ItemType.all.sort_by{|e| e[:name]}

    respond_to do |format|
      format.html
      format.json { render json: @items }
    end
  end
end
