require 'active_support'
module Bookafy
  module Model
    module Timestamps
      extend ActiveSupport::Concern

      included do
        def attributes
          attrs = {
              created_at: @created_at,
              updated_at: @updated_at
          }
          if @appointment_start_time
            attrs[:appointment_start_time] = @appointment_start_time
          end
          if @appointment_end_time
            attrs[:appointment_end_time] = @appointment_end_time
          end

          attrs
        end

      end
    end
  end
end