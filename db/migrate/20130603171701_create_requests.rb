class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.string :start_date
      t.string :return_date

      t.timestamps
    end
  end
end
