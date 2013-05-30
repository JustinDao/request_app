class HomeController < ApplicationController
  before_filter :authenticate_user!

  def index
    @user_id = current_user.id
    @user_items = Item.where(user_id: @user_id)
  end

end
