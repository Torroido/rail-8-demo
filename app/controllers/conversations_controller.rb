class ConversationsController < ApplicationController
  def index
    @conversations = Conversation.where("sender_id = ? OR receiver_id = ?", @current_user.id, @current_user.id)
  end

  def create
    @conversation = Conversation.find_by(sender: @current_user, receiver_id: params[:receiver_id]) ||
                    Conversation.find_by(sender_id: params[:receiver_id], receiver: @current_user)

    @conversation ||= Conversation.create(sender: @current_user, receiver_id: params[:receiver_id])

    redirect_to conversation_messages_path(@conversation)
  end
end
