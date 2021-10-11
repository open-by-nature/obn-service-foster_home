require "bundler/setup"
require "obn/service/foster_home"

require 'rubygems'
require 'grpc'
require 'pg'
require 'active_record'
require 'dotenv'
require 'yaml'
require 'erb'
require 'google/protobuf'
require 'google/protobuf/wrappers_pb'
require 'google/protobuf/well_known_types'

def db_configuration
  db_configuration_file_path = File.join(File.expand_path('..', __dir__), 'db', 'config.yml')
  db_configuration_result = ERB.new(File.read(db_configuration_file_path)).result
  YAML.safe_load(db_configuration_result, aliases: true)
end

def start_server
  ENV['ENVIRONMENT'] ||= 'development'
  Dotenv.load(".env.#{ENV.fetch('ENVIRONMENT')}.local", ".env.#{ENV.fetch('ENVIRONMENT')}", '.env')
  ActiveRecord::Base.establish_connection(db_configuration[ENV['ENVIRONMENT']])
  @server = GRPC::RpcServer.new
  @server.add_http2_port("0.0.0.0:50052", :this_port_is_insecure)
  @server.handle(Obn::Service::FosterHome::Service)

  Thread.abort_on_exception = true
  server_thread = Thread.new do
    begin
      @server.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
    rescue SystemExit, Interrupt
      @server.stop
      p 'Server stopped'
    end
  end  
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

start_server
