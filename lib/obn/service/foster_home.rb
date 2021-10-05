require 'grpc'
require 'obn/service/foster_home/version'
require 'obn/service/foster_home/foster_home_services_pb'

module Obn
  module Service
    module FosterHome
      class FosterHomeError < StandardError; end
      
      class Service < Obn::Service::FosterHome::FosterHomeService::Service
        def get(empty, _unused_call)
          foster_home = Obn::Service::FosterHome::FosterHome.new
          foster_home.name = 'Test'
          foster_home.address = 'Address 1'
          foster_home.city = 'City 1'
          foster_home.postalCode = '00000'
          foster_home.state = 'State 1'
          foster_home.phoneNumber = '000.00.00.00'
          foster_home.eMail = 'a@b.c'
          foster_home
        end
      end
    end
  end
end
