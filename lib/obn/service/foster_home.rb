require 'grpc'
require 'logging'
require 'obn/service/foster_home/version'
require 'obn/service/foster_home/models'
require 'obn/service/foster_home/foster_home_services_pb'

module Obn
  module Service
    module FosterHome
      class FosterHomeError < StandardError; end
      
      class Service < Obn::Service::FosterHome::FosterHomeService::Service
        def initialize
          @logger = Logging.logger[self]
        end

        def get(request, _unused_call)
          @logger.info "Request #{request}"
          entity = Obn::Service::FosterHome::Model::ForsterHomeModel.find_by_id(request.id)
          if entity == nil
            return nil
          end
          Obn::Service::FosterHome::FosterHome.new(
            id: entity.id, 
            name: entity.name,
            address: entity.address, 
            city: entity.city, 
            postalCode: entity.postalCode, 
            state: entity.state, 
            phoneNumber: entity.phoneNumber, 
            eMail: entity.eMail
          )
        end

        def save(request, _unused_call)
          @logger.info "Request #{request}"
          entity = Obn::Service::FosterHome::Model::ForsterHomeModel.create(
            name: request.name,
            address: request.address,
            city: request.city,
            postalCode: request.postalCode,
            state: request.state,
            phoneNumber: request.phoneNumber,
            eMail: request.eMail,
          )
          if entity == nil
            return nil
          end
          request.id = entity.id
          request
        end
      end
    end
  end
end
