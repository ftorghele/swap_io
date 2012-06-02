module UserConversationsHelper
  def other_participant conversation
    user = conversation.participants.reject{|i| i == current_user}.first
    user = conversation.participants.first if other_participant.nil?
    user
  end
end
