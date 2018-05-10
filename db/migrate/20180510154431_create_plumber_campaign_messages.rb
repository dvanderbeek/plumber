class CreatePlumberCampaignMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :plumber_campaign_messages do |t|
      t.belongs_to :message
      t.belongs_to :campaign
      t.integer :delay, index: true, default: 0

      t.timestamps
    end

    add_foreign_key :plumber_campaign_messages, :plumber_messages, column: :message_id, on_delete: :cascade
    add_foreign_key :plumber_campaign_messages, :plumber_campaigns, column: :campaign_id, on_delete: :cascade
  end
end
