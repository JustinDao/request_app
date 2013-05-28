class Building < ActiveRecord::Base
  attr_accessible :name
  belongs_to :residence
  has_many :user, :through => :residence
  validates_presence_of :residence, :name
  validates :name, :uniqueness => { :case_sensitive => false }
end
