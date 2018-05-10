class CreatePlumberMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :plumber_messages do |t|
      t.string :subject
      t.text :body

      t.timestamps
    end
  end
end
