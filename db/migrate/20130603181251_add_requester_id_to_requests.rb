class AddRequesterIdToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :requester_id, :integer
  end
end
