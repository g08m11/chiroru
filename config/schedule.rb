set :environment, :development
set :output, "log/cron_log.log"

every 1.day, :at => '4:30 am' do
  runner "Tasks::InsertContentsTask.execute_mery"
  runner "Tasks::InsertContentsTask.execute_style4"
  runner "Tasks::InsertContentsTask.execute_api"

end

# Learn more: http://github.com/javan/whenever
