class AddLeadSourceToApplications < ActiveRecord::Migration[5.2]
  def change
    add_column :applications, :lead_source, :string
  end
end
