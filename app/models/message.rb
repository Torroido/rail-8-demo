class Message < ApplicationRecord
  belongs_to :conversation
  belongs_to :user

  after_create_commit do
    broadcast_to_participants
  end

  private

  def broadcast_to_participants
    [ conversation.sender, conversation.receiver ].each do |participant|
      broadcast_append_to(
        "user_#{participant.id}_conversation_#{conversation.id}_messages",
        partial: "messages/message",
        locals: { message: self },
        target: "messages"
      )
    end
  end
end
