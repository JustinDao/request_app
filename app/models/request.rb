class Request < ActiveRecord::Base
  attr_accessible :return_date, :start_date, :approved
  belongs_to :user
  belongs_to :item

  validates :start_date, :format => {:with => /\A\d{2}\/\d{2}\/\d{4}\z/ }
  validates :return_date, :format => {:with => /\A\d{2}\/\d{2}\/\d{4}\z/ }
  validates_presence_of :user_id, :item_id, :requester_id

  # validates_uniqueness_of :item_id, :scope => :requester_id

end
