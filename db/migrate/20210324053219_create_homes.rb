class CreateHomes < ActiveRecord::Migration[6.1]
  def change
    create_table :homes do |t|
      t.string :name
      t.float :nw_lat
      t.float :nw_long
      t.float :se_lat
      t.float :se_long

      t.timestamps
    end
  end
end
