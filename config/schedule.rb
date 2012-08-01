every 1.day, :at => '2:00 am' do
  runner "CourseMember.course_member_notification_task", :output => {:error => 'error.log', :standard => 'cron.log'}
end
