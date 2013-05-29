class HomeController < ApplicationController
  before_filter :authenticate_user!

  

  def show
    @user_id = current_user.id
    @items = Item.where(user_id: @user_id)
  end

end
