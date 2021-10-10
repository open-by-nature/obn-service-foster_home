require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'dotenv'

Dotenv.load

require 'standalone_migrations'

StandaloneMigrations::Tasks.load_tasks
RSpec::Core::RakeTask.new(:spec)

task :default => :spec
