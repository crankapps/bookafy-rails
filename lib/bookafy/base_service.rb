require 'httparty'

module Bookafy
  class BaseService
    include HTTParty

    API_VERSION = 'v1'

    def initialize
      url = Bookafy.base_url || 'http://bookafydev.com'
      @domain = "#{url}/api/#{API_VERSION}/"
      @token = Bookafy.access_token
    end

    def bookafy_api_url
      @domain
    end

    def access_token
      @token
    end

    def get(url, options={})
      default_options = {token: @token, page: 1}.merge(options)
      api_url = "#{@domain}#{url}"
      response = HTTParty.get(api_url, {query: default_options})
      response
    end

  end
end