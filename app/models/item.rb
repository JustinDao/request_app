class Item < ActiveRecord::Base
  attr_accessible :name, :image, :remote_image_url
  belongs_to :user
  belongs_to :item_type
  validates_presence_of :name, :user, :item_type
  mount_uploader :image, ImageUploader
end
