class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :fetch_item_types

  private

  def fetch_item_types
    if(user_signed_in?)
      @item_types ||= ItemType.all.sort_by{|e| e[:name]}
    end
  end
end
