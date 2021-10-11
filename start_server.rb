#!/usr/bin/env ruby

require 'rubygems'
require 'grpc'
require 'logging'
require 'pg'
require 'active_record'
require 'dotenv'
require 'yaml'
require 'erb'

require 'obn/service/foster_home'

module GRPC
    extend Logging.globally
end

ENV['ENVIRONMENT'] ||= 'development'
Dotenv.load(".env.#{ENV.fetch('ENVIRONMENT')}.local", ".env.#{ENV.fetch('ENVIRONMENT')}", '.env')

ActiveRecord::Base.logger = ActiveSupport::Logger.new(STDOUT)
# ActiveSupport::LogSubscriber.colorize_logging = false
Logging.logger.root.appenders = Logging.appenders.stdout
Logging.logger.root.level = :info

logger = Logging.logger(STDOUT)

class FosterHomeServer
    class << self
        def start
            connect_db
            start_grpc_server
        end

        def stop
            @server.stop
        end

        def connect_db
            ActiveRecord::Base.establish_connection(db_configuration[ENV['ENVIRONMENT']])
        end

        private

        def db_configuration
            db_configuration_file_path = File.join(File.expand_path('.', __dir__), 'db', 'config.yml')
            db_configuration_result = ERB.new(File.read(db_configuration_file_path)).result
            YAML.safe_load(db_configuration_result, aliases: true)
        end

        def start_grpc_server
            @server = GRPC::RpcServer.new
            @server.add_http2_port("0.0.0.0:50052", :this_port_is_insecure)
            @server.handle(Obn::Service::FosterHome::Service)
            # @server.run_till_terminated
            @server.run_till_terminated_or_interrupted([1, 'int', 'SIGQUIT'])
        end
    end
end

if $PROGRAM_NAME == __FILE__
    begin
        FosterHomeServer.start
    rescue SystemExit, Interrupt
        FosterHomeServer.stop
        logger.info 'Foster Homes gRPC service stopped.'
    rescue SignalException => e
        print_exception e, true
    rescue Exception => e
        print_exception e, true
    end
end