#!/usr/bin/env ruby

require 'rubygems'
require 'obn/service/foster_home/foster_home_services_pb'
require 'obn/service/foster_home'

class FosterHomeServer
    class << self
        def start
            start_grpc_server
        end

        private
        def start_grpc_server
            @server = GRPC::RpcServer.new
            @server.add_http2_port("0.0.0.0:50052", :this_port_is_insecure)
            @server.handle(Obn::Service::FosterHome::Service)
            @server.run_till_terminated
        end
    end
end

FosterHomeServer.start