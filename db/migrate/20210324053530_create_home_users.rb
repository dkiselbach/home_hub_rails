class CreateHomeUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :home_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :homes, null: false, foreign_key: true

      t.timestamps
    end
  end
end
