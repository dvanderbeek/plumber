require_dependency "plumber/application_controller"

module Plumber
  class CampaignsController < ApplicationController
    # GET /campaigns
    def index
      @campaigns = Campaign.all
    end

    # GET /campaigns/1
    def show
      @campaign = Campaign.find(params[:id])
      @records = @campaign.records.page(params[:page])
    end
  end
end
