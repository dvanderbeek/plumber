class AddStatusUpdatedAtToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :status_updated_at, :datetime
  end
end
