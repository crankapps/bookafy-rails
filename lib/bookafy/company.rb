module Bookafy
  class Company < BaseService

    def initialize
      super
    end

    def uri
      'company'
    end

    def info()
      response = get(uri)
      unless response.code == 200
        return nil
      end

      response_json = JSON.parse(response.body)['response']
      company_json = response_json['company']
      company = Bookafy::Model::Company.new(company_json)

      company
    rescue => e
      puts "Error at fetching customers: #{e.message}"
      return nil
    end

  end
end