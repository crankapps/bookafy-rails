require 'test_helper'

module Bookafy
  class CustomerTest < ActiveSupport::TestCase
    setup do
      Bookafy.access_token = '12345678'
    end

    test 'should return customers model instance' do
      customer_service = Bookafy::Customer.new
      service = Bookafy::BaseService.new

      stub_request(:get, "#{service.bookafy_api_url}customers").with(query: {token: Bookafy.access_token, page: 1}).
          to_return(status: 200, body: '{"response":{"message":"Success","remaining":0,"customers":[{"id":365,"created_at":"2015-10-08T12:41:56.036+05:00","updated_at":"2015-10-08T12:42:47.348+05:00","name":"Akmal","email":"akmal@clustox.com","customer_detail_hstore":{"city":"lahore","name":"Akmal","email":"akmal@clustox.com","state":"punjab","mobile":"03238784647","address":"johar town","zip code":"54000"},"notes":null,"image":{"url":null,"thumb":{"url":null},"small_thumb":{"url":null}},"soft_delete":false}]}}', headers: {})

      customers = customer_service.all

      assert_equal 1, customers.length
      customer = customers.first

      assert_not_equal nil, customer
      assert_equal 365, customer.id
      assert_equal 'Akmal', customer.name
      assert_equal 'akmal@clustox.com', customer.email
    end

    test 'should return customers that were updated in the last week' do
      customer_service = Bookafy::Customer.new
      service = Bookafy::BaseService.new

      updated_since = 7.days.ago

      stub_request(:get, "#{service.bookafy_api_url}customers").with(query: {token: Bookafy.access_token, page: 1, updated: updated_since.to_i}).
          to_return(status: 200, body: '{"response":{"message":"Success","remaining":0,"customers":[{"id":365,"created_at":"2015-10-08T12:41:56.036+05:00","updated_at":"2015-10-08T12:42:47.348+05:00","name":"Akmal","email":"akmal@clustox.com","customer_detail_hstore":{"city":"lahore","name":"Akmal","email":"akmal@clustox.com","state":"punjab","mobile":"03238784647","address":"johar town","zip code":"54000"},"notes":null,"image":{"url":null,"thumb":{"url":null},"small_thumb":{"url":null}},"soft_delete":false}]}}', headers: {})

      customers = customer_service.all(updated: updated_since.to_i)

      assert_equal 1, customers.length
      customer = customers.first

      assert_not_equal nil, customer
      assert_equal 365, customer.id
      assert_equal 'Akmal', customer.name
      assert_equal 'akmal@clustox.com', customer.email
    end

    test 'should return customers that were updated in the last two days' do
      customer_service = Bookafy::Customer.new
      service = Bookafy::BaseService.new

      updated_since = 2.days.ago

      stub_request(:get, "#{service.bookafy_api_url}customers").with(query: {token: Bookafy.access_token, page: 1, updated: updated_since.to_i}).
          to_return(status: 200, body: '{"response":{"message":"Success","remaining":0,"customers":[]}}', headers: {})

      customers = customer_service.all(updated: updated_since.to_i)

      assert_equal 0, customers.length
      customer = customers.first

      assert_equal nil, customer
    end

    test 'should return all customers when there are more pages' do
      customer_service = Bookafy::Customer.new
      service = Bookafy::BaseService.new

      stub_request(:get, "#{service.bookafy_api_url}customers").with(query: {token: Bookafy.access_token, page: 1}).
          to_return(status: 200, body: '{"response":{"message":"Success","remaining":1,"customers":[{"id":365,"created_at":"2015-10-08T12:41:56.036+05:00","updated_at":"2015-10-08T12:42:47.348+05:00","name":"Akmal","email":"akmal@clustox.com","customer_detail_hstore":{"city":"lahore","name":"Akmal","email":"akmal@clustox.com","state":"punjab","mobile":"03238784647","address":"johar town","zip code":"54000"},"notes":null,"image":{"url":null,"thumb":{"url":null},"small_thumb":{"url":null}},"soft_delete":false}]}}', headers: {})
      stub_request(:get, "#{service.bookafy_api_url}customers").with(query: {token: Bookafy.access_token, page: 2}).
          to_return(status: 200, body: '{"response":{"message":"Success","remaining":0,"customers":[{"id":366,"created_at":"2015-11-08T12:41:56.036+05:00","updated_at":"2015-11-08T12:42:47.348+05:00","name":"Lamka","email":"lamka@clustox.com","customer_detail_hstore":{"city":"lahore","name":"Akmal","email":"akmal@clustox.com","state":"punjab","mobile":"03238784647","address":"johar town","zip code":"54000"},"notes":null,"image":{"url":null,"thumb":{"url":null},"small_thumb":{"url":null}},"soft_delete":false}]}}', headers: {})

      customers = customer_service.all

      assert_equal 2, customers.length
      customer = customers.first

      assert_not_equal nil, customer
      assert_equal 365, customer.id
      assert_equal 'Akmal', customer.name
      assert_equal 'akmal@clustox.com', customer.email
      assert_not_equal '', customer.created_at

      customer = customers.last
      assert_not_equal nil, customer
      assert_equal 366, customer.id
      assert_equal 'Lamka', customer.name
      assert_equal 'lamka@clustox.com', customer.email
      assert_not_equal '', customer.created_at
    end
  end
end