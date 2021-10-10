require "active_record"

module Obn
    module Service
      module FosterHome
        module Model
          class ForsterHomeModel < ActiveRecord::Base
            self.table_name = 'foster_homes'
          end
        end
      end
    end
end