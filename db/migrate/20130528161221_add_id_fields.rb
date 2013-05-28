class AddIdFields < ActiveRecord::Migration
  def change
  	add_column :users, :residence_id, :integer
  	add_column :users, :building_id, :integer
  	add_column :buildings, :residence_id, :integer
  	add_column :items, :user_id, :integer
  	add_column :items, :item_type_id, :integer
  end
end
