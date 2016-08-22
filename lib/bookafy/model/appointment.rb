module Bookafy
  module Model
    class Appointment
      include Timestamps

      attr_accessor :id, :client_id, :customer_id, :created_at, :updated_at, :appointment_start_time, :appointment_end_time, :all_day, :title, :description, :price, :duration, :recurring, :is_active, :is_blocker, :all_day_blocker, :soft_delete, :service, :category

      def initialize(attrs = {})
        attrs.each do |attr, val|
          if respond_to?("#{attr}=")
            send("#{attr}=", val)
          end

        end
      end

      def active?
        is_active
      end

      def blocker?
        is_blocker
      end

      def all_day?
        all_day
      end

      def recurring?
        recurring
      end

      def service_id
        service['service_id'] unless service.blank?
      end

      def service_name
        service['service_name'] unless service.blank?
      end

      def category_id
        category['category_id'] unless category.blank?
      end

      def category_name
        category['category_name'] unless category.blank?
      end

      def all_day_blocker?
        all_day_blocker
      end

      def created_at
        Time.parse(attributes[:created_at])
      end

      def updated_at
        Time.parse(attributes[:updated_at])
      end

      def appointment_start_time
        Time.parse(attributes[:appointment_start_time])
      end

      def appointment_end_time
        Time.parse(attributes[:appointment_end_time])
      end

    end
  end
end