require 'test_helper'

module Bookafy
  class AppointmentTest < ActiveSupport::TestCase
    setup do
      Bookafy.access_token = '12345678'
    end

    test 'should return appointments model instance' do
      appointment_service = Bookafy::Appointment.new
      service = Bookafy::BaseService.new

      stub_request(:get, "#{service.bookafy_api_url}appointments").with(query: {token: Bookafy.access_token, page: 1}).
          to_return(status: 200, body: '{"response":{"message":"Success","remaining":0,"appointments":[{"id":1114015,"client_id":123,"customer_id":5951,"appointment_date":"2016-08-10","appointment_start_time":"2016-08-10T12:30:00.000+05:00","appointment_end_time":"2016-08-10T13:15:00.000+05:00","all_day":false,"title":"Dentist","description":"Fix bottom 2","price":"15","created_at":"2016-08-09T17:58:04.623+05:00","updated_at":"2016-08-09T18:23:48.044+05:00","duration":"45","recurring_date":"","recurring":false,"is_active":true,"is_blocker":false,"deleted_at":null,"soft_delete":false,"recurring_delete":null,"recurring_end_date":null,"all_day_blocker":false}]}}', headers: {})

      appointments = appointment_service.all

      assert_equal 1, appointments.length
      appointment = appointments.first

      assert_not_equal nil, appointment
      assert_equal 1114015, appointment.id
      assert_equal 123, appointment.client_id
      assert_equal 5951, appointment.customer_id
      assert_equal 'Dentist', appointment.title
      assert_equal 'Fix bottom 2', appointment.description
      assert_equal Time.parse('2016-08-09T17:58:04.623+05:00'), appointment.created_at
      assert_equal Time.parse('2016-08-10T12:30:00.000+05:00'), appointment.appointment_start_time
      assert_equal Time.parse('2016-08-10T13:15:00.000+05:00'), appointment.appointment_end_time

      assert_equal true, appointment.active?
      assert_equal false, appointment.blocker?
    end

    test 'should return all appointments when there are more pages' do
      appointment_service = Bookafy::Appointment.new
      service = Bookafy::BaseService.new

      stub_request(:get, "#{service.bookafy_api_url}appointments").with(query: {token: Bookafy.access_token, page: 1}).
          to_return(status: 200, body: '{"response":{"message":"Success","remaining":1,"appointments":[{"id":1114015,"client_id":123,"customer_id":5951,"appointment_date":"2016-08-10","appointment_start_time":"2016-08-10T12:30:00.000+05:00","appointment_end_time":"2016-08-10T13:15:00.000+05:00","all_day":false,"title":"Dentist","description":"Fix bottom 2","price":"15","created_at":"2016-08-09T17:58:04.623+05:00","updated_at":"2016-08-09T18:23:48.044+05:00","duration":"45","recurring_date":"","recurring":false,"is_active":true,"is_blocker":false,"deleted_at":null,"soft_delete":false,"recurring_delete":null,"recurring_end_date":null,"all_day_blocker":false}]}}', headers: {})
      stub_request(:get, "#{service.bookafy_api_url}appointments").with(query: {token: Bookafy.access_token, page: 2}).
          to_return(status: 200, body: '{"response":{"message":"Success","remaining":0,"appointments":[{"id":1114016,"client_id":123,"customer_id":5951,"appointment_date":"2016-08-10","appointment_start_time":"2016-08-10T12:30:00.000+05:00","appointment_end_time":"2016-08-10T13:15:00.000+05:00","all_day":false,"title":"Dentist","description":"Fix bottom 2","price":"15","created_at":"2016-08-09T17:58:04.623+05:00","updated_at":"2016-08-09T18:23:48.044+05:00","duration":"45","recurring_date":"","recurring":false,"is_active":false,"is_blocker":true,"deleted_at":null,"soft_delete":false,"recurring_delete":null,"recurring_end_date":null,"all_day_blocker":false}]}}', headers: {})

      appointments = appointment_service.all

      assert_equal 2, appointments.length
      appointment = appointments.first

      assert_not_equal nil, appointment
      assert_equal 1114015, appointment.id
      assert_equal 123, appointment.client_id
      assert_equal 5951, appointment.customer_id
      assert_equal 'Dentist', appointment.title
      assert_equal 'Fix bottom 2', appointment.description
      assert_equal Time.parse('2016-08-09T17:58:04.623+05:00'), appointment.created_at
      assert_equal Time.parse('2016-08-10T12:30:00.000+05:00'), appointment.appointment_start_time
      assert_equal Time.parse('2016-08-10T13:15:00.000+05:00'), appointment.appointment_end_time
      assert_equal true, appointment.active?
      assert_equal false, appointment.blocker?

      appointment = appointments.last
      assert_not_equal nil, appointment
      assert_equal 1114016, appointment.id
    end
  end
end