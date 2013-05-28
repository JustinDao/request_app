class Building < ActiveRecord::Base
  attr_accessible :name, :room
  belongs_to :residence
  has_many :user
end
