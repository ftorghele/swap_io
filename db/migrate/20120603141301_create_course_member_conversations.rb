class CreateCourseMemberConversations < ActiveRecord::Migration
  def change
    create_table :course_member_conversations do |t|

      t.text :body
      t.integer :user_id
      t.integer :course_member_id
      t.timestamps
    end
  end
end
