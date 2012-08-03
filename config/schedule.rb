every 1.day, :at => '1:25 am' do
  runner "CourseMember.course_member_notification_task", :output => {:error => 'error.log', :standard => 'cron.log'}
end

every 1.minute do
  command "echo 'testing' >> testfile.txt"

end
