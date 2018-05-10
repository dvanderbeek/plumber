class CreatePlumberEntrances < ActiveRecord::Migration[5.2]
  def change
    create_table :plumber_entrances do |t|
      t.belongs_to :campaign
      t.references :record, polymorphic: true
      t.boolean :exited, default: false

      t.timestamps
    end

    add_foreign_key :plumber_entrances, :plumber_campaigns, column: :campaign_id, on_delete: :cascade
  end
end
