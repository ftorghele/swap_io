module UserConversationsHelper
  def other_participant conversation
    other_participant = conversation.participants.reject{|i| i == current_user}.first
    other_participant = conversation.participants.first if other_participant.nil?
    other_participant
  end
end
