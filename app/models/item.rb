class Item < ActiveRecord::Base
  attr_accessible :name
  belongs_to :user
  belongs_to :item_type
  validates_presence_of :name, :user, :item_type
end
