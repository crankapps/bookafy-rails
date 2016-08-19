require 'test_helper'
module Bookafy
  class BaseServiceTest < ActiveSupport::TestCase

    setup do
      Bookafy.client_token = '12345678'
      Bookafy.access_token = '12345678'
    end

    test 'should setup token and base url' do

      service = Bookafy::BaseService.new

      assert_equal '12345678', service.access_token
      assert_equal 'http://bookafydev.com/api/v1/', service.bookafy_api_url
    end

    test 'should return unauthorized access if token is not passed' do
      Bookafy.client_token = ''
      service = Bookafy::BaseService.new

      stub_request(:get, "#{service.bookafy_api_url}customers").with(query: {token: '', page: 1}, headers: {'Authorization' => "Bearer #{Bookafy.access_token}"}).
          to_return(status: 401, body: '', headers: {})

      response = service.get('customers')

      assert_equal 401, response.code
    end

    test 'should get list of customers' do
      service = Bookafy::BaseService.new

      stub_request(:get, "#{service.bookafy_api_url}customers").with(query: {token: Bookafy.client_token, page: 1}, headers: {'Authorization' => "Bearer #{Bookafy.access_token}"}).
          to_return(status: 200, body: '{"response":{"message":"Success","remaining":0,"customers":[{"id":365,"created_at":"2015-10-08T12:41:56.036+05:00","updated_at":"2015-10-08T12:42:47.348+05:00","name":"Akmal","email":"akmal@clustox.com","customer_detail_hstore":{"city":"lahore","name":"Akmal","email":"akmal@clustox.com","state":"punjab","mobile":"03238784647","address":"johar town","zip code":"54000"},"notes":null,"image":{"url":null,"thumb":{"url":null},"small_thumb":{"url":null}},"soft_delete":false}]}}', headers: {})

      response = service.get('customers', {})

      json_response = JSON.parse(response.body)['response']

      assert_equal 'Success', json_response['message']
      assert_equal 0, json_response['remaining']

      customers = json_response['customers']
      assert_equal 1, customers.length
      customer = customers.first
      assert_equal 365, customer['id']
      assert_equal 'Akmal', customer['name']
      assert_equal 'akmal@clustox.com', customer['email']
    end

  end
end