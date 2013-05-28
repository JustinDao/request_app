class RemoveRoomFromBuilding < ActiveRecord::Migration
  def up
    remove_column :buildings, :room
  end

  def down
    add_column :buildings, :room, :string
  end
end
