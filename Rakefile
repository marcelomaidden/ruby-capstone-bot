task :environment do
  ENV['SLACK_API_TOKEN'] = File.read('config/.token').chomp
end
namespace :deploy do
  desc 'start mybot'
  task :run => :environment do
    require_relative 'bin/run'
  end
end