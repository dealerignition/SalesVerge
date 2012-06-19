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
end