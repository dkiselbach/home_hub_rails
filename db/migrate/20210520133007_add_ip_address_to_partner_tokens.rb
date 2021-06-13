class AddIpAddressToPartnerTokens < ActiveRecord::Migration[6.1]
  def change
    add_column :partner_tokens, :ip_address, :string, null: false
  end
end
