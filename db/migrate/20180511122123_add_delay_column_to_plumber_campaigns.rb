class AddDelayColumnToPlumberCampaigns < ActiveRecord::Migration[5.2]
  def change
    add_column :plumber_campaigns, :delay_column, :string
  end
end
