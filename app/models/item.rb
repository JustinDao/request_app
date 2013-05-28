class Item < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user
  has_one :item_type
end
