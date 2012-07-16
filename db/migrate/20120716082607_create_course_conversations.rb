class CreateCourseConversations < ActiveRecord::Migration
  def change
    create_table :course_conversations do |t|
      t.belongs_to :user
      t.belongs_to :course
      t.text :body

      t.timestamps
    end
    add_index :course_conversations, :user_id
    add_index :course_conversations, :course_id
  end
end
