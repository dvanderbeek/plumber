class CreatePlumberSentMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :plumber_sent_messages do |t|
      t.references :record, polymorphic: true
      t.belongs_to :message

      t.timestamps
    end

    add_foreign_key :plumber_sent_messages, :plumber_messages, column: :message_id, on_delete: :cascade
  end
end
