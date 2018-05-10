class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string :email
      t.string :status

      t.timestamps
    end
  end
end
