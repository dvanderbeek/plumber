class CreatePlumberSentMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :plumber_sent_messages do |t|
      t.belongs_to :entrance
      t.belongs_to :campaign_message

      t.timestamps
    end

    add_foreign_key :plumber_sent_messages, :plumber_entrances, column: :entrance_id, on_delete: :cascade
    add_foreign_key :plumber_sent_messages, :plumber_campaign_messages, column: :campaign_message_id, on_delete: :cascade
  end
end
