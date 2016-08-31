module Bookafy
  module Model
    class Company
      include Timestamps
      attr_accessor :id, :name, :created_at, :updated_at

      def initialize(attrs = {})
        attrs.each do |attr, val|
          send("#{attr}=", val) if respond_to?("#{attr}=")
        end
      end


      def created_at
        Time.parse(attributes[:created_at])
      end

      def updated_at
        Time.parse(attributes[:updated_at])
      end
    end
  end
end