class AddRecordClassToPlumberCampaigns < ActiveRecord::Migration[5.2]
  def change
    add_column :plumber_campaigns, :record_class, :string
  end
end
