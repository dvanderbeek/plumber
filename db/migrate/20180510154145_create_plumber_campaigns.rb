class CreatePlumberCampaigns < ActiveRecord::Migration[5.2]
  def change
    create_table :plumber_campaigns do |t|
      t.string :title

      t.timestamps
    end
  end
end
