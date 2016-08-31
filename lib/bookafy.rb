require "bookafy/version"
require "bookafy/base_service"
require "bookafy/model/timestamps"
require "bookafy/model/customer"
require "bookafy/model/appointment"
require "bookafy/model/company"
require "bookafy/customer"
require "bookafy/appointment"
require "bookafy/company"

module Bookafy

  @base_url = 'http://bookafydev.com'
  @access_token = ''
  @client_token = ''

  class << self
    attr_accessor :base_url
    attr_accessor :access_token
    attr_accessor :client_token
  end

end
