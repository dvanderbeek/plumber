require_dependency "plumber/application_controller"

module Plumber
  class CampaignsController < ApplicationController
    before_action :set_campaign, only: [:show, :edit, :update, :destroy]

    # GET /campaigns
    def index
      @campaigns = Campaign.all
    end

    # GET /campaigns/1
    def show
    end

    # GET /campaigns/new
    def new
      @campaign = Campaign.new
      @message = @campaign.messages.new
    end

    # GET /campaigns/1/edit
    def edit
    end

    # POST /campaigns
    def create
      @campaign = Campaign.new(campaign_params)

      if @campaign.save
        redirect_to @campaign, notice: 'Campaign was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /campaigns/1
    def update
      if @campaign.update(campaign_params)
        redirect_to @campaign, notice: 'Campaign was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /campaigns/1
    def destroy
      @campaign.destroy
      redirect_to campaigns_url, notice: 'Campaign was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_campaign
        @campaign = Campaign.includes(:messages).find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def campaign_params
        params.require(:campaign).permit(:title, :record_class, :delay_column)
      end
  end
end
