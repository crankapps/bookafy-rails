module Bookafy
  class Customer < BaseService

    def initialize
      super
      @page = 1
    end

    def uri
      'customers'
    end

    def all(query_params = {})
      query_params[:page] = @page
      response = get(uri, query_params)
      unless response.code == 200
        return []
      end

      response_json = JSON.parse(response.body)['response']
      customers_json = response_json['customers']
      customers = customers_json.map do |data|
        Bookafy::Model::Customer.new(data)
      end

      if response_json['remaining'] > 0
        @page = @page + 1
        customers += all(query_params)
      end

      customers
    rescue => e
      puts "Error at fetching customers: #{e.message}"
      return []
    end

  end
end