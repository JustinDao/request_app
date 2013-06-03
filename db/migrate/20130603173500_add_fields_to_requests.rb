class AddFieldsToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :user_id, :integer
    add_column :requests, :item_id, :integer
  end
end
