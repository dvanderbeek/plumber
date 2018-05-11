class AddActiveToPlumberMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :plumber_messages, :active, :boolean, default: true
  end
end
