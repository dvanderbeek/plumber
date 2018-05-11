require_dependency "plumber/application_controller"

module Plumber
  class MessagesController < ApplicationController
    before_action :set_message, only: [:show, :edit, :update, :destroy]

    # GET /messages/1
    def show
    end

    # GET /messages/new
    def new
      @campaign = Campaign.find(params[:campaign_id])
      @message = @campaign.messages.new
    end

    # GET /messages/1/edit
    def edit
    end

    # POST /messages
    def create
      @campaign = Campaign.find(params[:campaign_id])
      @message = @campaign.messages.new(message_params)

      if @message.save
        redirect_to @message.campaign, notice: 'Message was successfully created.'
      else
        render :new
      end
    end

    # PATCH/PUT /messages/1
    def update
      if @message.update(message_params)
        redirect_to @message.campaign, notice: 'Message was successfully updated.'
      else
        render :edit
      end
    end

    # DELETE /messages/1
    def destroy
      @message.destroy
      redirect_to @message.campaign, notice: 'Message was successfully destroyed.'
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_message
        @message = Message.includes(:sent_messages).find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def message_params
        params.require(:message).permit(:subject, :delay, :active, :body)
      end
  end
end
