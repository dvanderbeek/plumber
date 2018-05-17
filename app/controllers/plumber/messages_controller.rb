require_dependency "plumber/application_controller"

module Plumber
  class MessagesController < ApplicationController
    # GET /messages/1
    def show
      @message = Message.find(params[:id])
      @campaign = Campaign.find(@message.campaign_id)
      @sent_messages = SentMessage.where(message_id: @message.id).page(params[:page])
    end
  end
end
