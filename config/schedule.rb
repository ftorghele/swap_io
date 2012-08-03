every 1.day, :at => '1:25 am' do
  runner "CourseMember.course_member_notification_task", :output => {:error => 'error.log', :standard => 'cron.log'}
end

every :hour do
  command "echo 'das ist ein test' >> /home/deployer/apps/swap_io/current/cron_test.txt"

end
