require "bookafy/version"

module Bookafy

  @base_url = 'http://bookafydev.com'
  @access_token = ''

  class << self
    attr_accessor :base_url
    attr_accessor :access_token
  end

end
