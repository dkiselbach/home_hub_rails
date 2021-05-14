class CreatePartnerTokens < ActiveRecord::Migration[6.1]
  def change
    create_table :partner_tokens do |t|
      t.string :token
      t.references :home, null: false, foreign_key: true

      t.timestamps
    end
  end
end
