# Build and deploy script from Dave Konopka:
# http://www.davekonopka.com/2013/middleman-deploy.html

namespace :site do
  desc 'Middleman build'
  task :build do
    puts 'Building site...'
    puts `bundle exec middleman build --verbose`
  end

  desc 'Build, deploy, bust cache'
  task deploy: ['site:build', 's3:deploy']
end

namespace :s3 do
  require 'dotenv/tasks'

  desc 'Deploy build to S3'
  task deploy: :dotenv do
    require 'aws-sdk'

    Dotenv.load

    AWS.config(
      access_key_id: ENV['AWS_KEY'],
      secret_access_key: ENV['AWS_SECRET']
    )

    bucket_name = ENV['AWS_BUCKET']

    s3 = AWS::S3.new

    puts 'Deleting current site files...'
    s3.buckets[bucket_name].objects.delete_all

    puts 'Uploading site files...'
    Dir.glob('build/**/*.*').each do |file_name|
      key = file_name.sub('build/','')
      s3.buckets[bucket_name].objects[key].write(file: file_name)
      puts "Uploading file #{file_name} to bucket #{bucket_name}."
    end
  end
end
