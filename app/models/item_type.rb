class ItemType < ActiveRecord::Base
  attr_accessible :name
  has_many :item
  validates_presence_of :name
  validates :name, :uniqueness => { :case_sensitive => false }
end
