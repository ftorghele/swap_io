every 1.day, :at => '1:25 am' do
  runner "CourseMember.course_member_notification_task"
end
