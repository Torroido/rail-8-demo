class MessagesChannel < ApplicationCable::Channel
  def subscribed
    stream_from "user_#{current_user.id}_conversation_#{params[:conversation_id]}_messages"
  end
end
