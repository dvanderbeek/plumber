class CreatePlumberSentMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :plumber_sent_messages do |t|
      t.references :record, polymorphic: true
      t.bigint :message_id, index: true

      t.timestamps
    end
  end
end
