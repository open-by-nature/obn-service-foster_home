require 'grpc'
require 'logging'
require 'obn/service/foster_home/version'
require 'obn/service/foster_home/models'
require 'obn/service/foster_home/foster_home_services_pb'
require 'google/protobuf'
require 'google/protobuf/wrappers_pb'
require 'google/protobuf/well_known_types'

module Obn
  module Service
    module FosterHome
      class FosterHomeError < StandardError; end
      
      class Service < Obn::Service::FosterHome::FosterHomeService::Service
        def initialize
          @logger = Logging.logger[self]
        end

        def get(request, _unused_call)
          @logger.info "Get request #{request}"
          model = Model::ForsterHomeModel.find_by_id(request.id)
          @logger.info "Model #{model}"
          to_grpc(model)
        end

        def search(request, _unused_call)
          @logger.info "Search request #{request}"
          filter = request.filter
          values = []
          request.values.each do |value|
            values << value.unpack
          end
          models = Model::ForsterHomeModel.where(filter, values)
          @logger.info "Models #{models}"
          results = []
          models.each do |model|
            results << to_grpc(model)
          end
          results
        end

        def save(request, _unused_call)
          @logger.info "Save request #{request}"
          model = to_model(request)
          @logger.info "Model #{model}"
          model.save! unless model.nil? and (!model.id.nil? or model.id > 0)
          model.update! unless model.nil? and !model.id.nil? and model.id > 0
          model.id unless model.nil?
          to_grpc(model)
        end

        def delete(request, _unused_call)
          @logger.info "Delete request #{request}"
          model = to_model(request)
          @logger.info "Model #{model}"
          model.save! unless model.nil?
          model.id unless model.nil?
          to_grpc(model)
        end

        private

        def to_grpc(model)
          Obn::Service::FosterHome::FosterHome.new(
            id: model.id, 
            name: model.name,
            address: model.address, 
            city: model.city, 
            postalCode: model.postalCode, 
            state: model.state, 
            phoneNumber: model.phoneNumber, 
            eMail: model.eMail
          ) unless model.nil?
        end

        def to_model(entity)
          model = Model::ForsterHomeModel.new(
            name: entity.name,
            address: entity.address, 
            city: entity.city, 
            postalCode: entity.postalCode, 
            state: entity.state, 
            phoneNumber: entity.phoneNumber, 
            eMail: entity.eMail
          ) unless entity.nil?
          model.id = entity.id unless entity.nil? or entity.id.nil? or entity.id == 0
          model
        end
      end
    end
  end
end
