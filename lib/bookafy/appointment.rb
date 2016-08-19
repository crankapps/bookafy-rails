module Bookafy
  class Appointment < BaseService

    def initialize
      super
      @page = 1
    end

    def uri
      'appointments'
    end

    def all(query_params = {})
      query_params[:page] = @page
      response = get(uri, query_params)
      unless response.code == 200
        return []
      end

      response_json = JSON.parse(response.body)['response']
      appointments_json = response_json['appointments']
      appointments = appointments_json.map do |data|
        Bookafy::Model::Appointment.new(data)
      end

      if response_json['remaining'] > 0
        @page = @page + 1
        appointments += all(query_params)
      end

      appointments
    rescue => e
      puts "Error at fetching appointments: #{e.message}"
      return []
    end

  end
end