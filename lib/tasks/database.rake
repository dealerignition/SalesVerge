require 'aws/s3'
require 'date'
require 'yaml'

namespace :db do
  desc "Drop development database and replace with latest copy of production"
  task :trash_development do
    aws = YAML.load_file('config/aws.yml')
    db = YAML.load_file('config/database.yml')
    AWS.config(:access_key_id => aws["development"]["access_key_id"],:secret_access_key => aws["development"]["secret_access_key"])
    s3 = AWS::S3.new
    backup = s3.buckets['dealeronthego_backups'].objects[Date.today.to_s + '.dump'].read
    File.open("#{Date.today.to_s}.dump", 'wb') do |file|
      file.write(backup)
    end
    puts `PGPASSWORD='#{db["development"]["password"]}' /Library/PostgreSQL/9.1/bin/pg_restore -h #{db["development"]["host"]} -U #{db["development"]["username"]} -d dotg_development --clean #{Date.today.to_s}.dump`
  end

  task :mirror_current_prod do
    APPLICATION_NAME = "dealeronthego"
    db = YAML.load_file('config/database.yml')
    `heroku pgbackups:capture --expire --app #{APPLICATION_NAME}`
    ids = `heroku pgbackups --app #{APPLICATION_NAME}`
    cur_id = ids.match(/b\d{3}/)[1]
    url = `heroku pgbackups:url #{cur_id} --app #{APPLICATION_NAME}`
    url = url.slice!(0,url.length-1)
    today = Date.today
    `curl "#{url}" > #{today.to_s}.dump`
    puts `PGPASSWORD='#{db["development"]["password"]}' /Library/PostgreSQL/9.1/bin/pg_restore -h #{db["development"]["host"]} -U #{db["development"]["username"]} -d dotg_development --clean #{Date.today.to_s}.dump`
    `rm #{today.to_s}.dump`
  end
end