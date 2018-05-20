require_dependency "plumber/application_controller"

module Plumber
  class CampaignsController < ApplicationController
    # GET /campaigns
    def index
      @campaign = Campaign.all.first
      @records = @campaign.upcoming_records.page(params[:page]) if @campaign
      render @campaign ? :show : :index
    end

    # GET /campaigns/1
    def show
      @campaign = Campaign.find(params[:id])
      @records = @campaign.upcoming_records.page(params[:page])
    end
  end
end
