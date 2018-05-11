class CreatePlumberMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :plumber_messages do |t|
      t.string :subject
      t.text :body
      t.integer :delay, index: true, default: 0
      t.belongs_to :campaign

      t.timestamps
    end

    add_foreign_key :plumber_messages, :plumber_campaigns, column: :campaign_id, on_delete: :cascade
  end
end
