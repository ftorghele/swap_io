every 1.day, :at => '00:05 am' do
  command "echo 'das ist ein test' >> /home/deployer/apps/swap_io/current/cron_test.txt"
  runner "CourseMember.course_member_notification_task", :output => {:error => 'error.log', :standard => 'cron.log'}
end
