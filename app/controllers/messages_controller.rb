# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  before_action :set_conversation

  def index
    @messages = @conversation.messages
  end

  def create
    @message = @conversation.messages.create(
      user: @current_user,
      content: params[:content]
    )
    redirect_to conversation_messages_path(@conversation)
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end
