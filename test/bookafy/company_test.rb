require 'test_helper'

module Bookafy
  class CompanyTest < ActiveSupport::TestCase
    setup do
      Bookafy.access_token = '12345678'
      Bookafy.client_token = '12345678'
    end

    test 'should return company model instance' do
      company_service = Bookafy::Company.new
      service = Bookafy::BaseService.new

      stub_request(:get, "#{service.bookafy_api_url}company").with(query: {token: Bookafy.client_token, page: 1}, headers: {'Authorization' => "Bearer #{Bookafy.access_token}"}).
          to_return(status: 200, body: '{"response": {"message": "Success","company": {"id": 5,"name": "Smartlist","uid": "71ceaef08b4935cf316733dd82dd32dcf29b903ac41c48cd425307e76b3a87da","secret": "e33a7e323fa3cfdd00b3a4c8f73300f5bae304a15d415f8057ab62722e77dbd0","redirect_uri": "http://smartlisthq.com/oauth_callback/bookafy","scopes": [],"created_at": "2016-07-28T06:59:11.099-07:00","updated_at": "2016-08-29T00:28:20.155-07:00"}}}', headers: {})

      company = company_service.info

      assert_not_equal nil, company
      assert_equal 5, company.id
      assert_equal 'Smartlist', company.name
    end
  end
end