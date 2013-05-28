class Residence < ActiveRecord::Base
  attr_accessible :name
  has_many :user
  has_many :building
  validates_presence_of :name
  validates :name, :uniqueness => { :case_sensitive => false }
end
