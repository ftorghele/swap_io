every 1.day, :at => '1:25 am' do
  runner "CourseMember.course_member_notification_task", :output => {:error => 'error.log', :standard => 'cron.log'}
end

every :hour do
  command "echo 'testing' >> testfile.txt", :output => {:error => 'error.log', :standard => 'cron.log'}
end
