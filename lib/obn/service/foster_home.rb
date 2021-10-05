require 'grpc'
require 'obn/service/foster_home/version'
require 'obn/service/foster_home/foster_home_services_pb'

module Obn
  module Service
    module FosterHome
      class FosterHomeError < StandardError; end
      
      class Service < Obn::Service::FosterHome::FosterHomeService::Service
        def get(empty, _unused_call)
          Obn::Service::FosterHome::FosterHome.new(
            name: 'Test'
            , address: 'Address 1'
            , city: 'City 1'
            , postalCode: '00000'
            , state: 'State 1'
            , phoneNumber: '000.00.00.00'
            , eMail: 'a@b.c'
          )
        end
      end
    end
  end
end
