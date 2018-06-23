class AddEmailToPlumberSentMessages < ActiveRecord::Migration[5.2]
  def change
    add_column :plumber_sent_messages, :email, :string
  end
end
