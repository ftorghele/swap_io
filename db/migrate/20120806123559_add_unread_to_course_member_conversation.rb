class AddUnreadToCourseMemberConversation < ActiveRecord::Migration
  def change
    add_column :course_member_conversations, :unread, :bool, :default => true
  end
end
