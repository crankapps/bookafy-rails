require 'test_helper'

class Bookafy::Model::AppointmentTest < ActiveSupport::TestCase
  def test_that_new_appointment_is_created
    appointment = Bookafy::Model::Appointment.new(title: 'Dentist', description: 'Go to dentist', appointment_start_time: '2016-08-10T12:30:00.000+05:00')
    assert_not_equal nil, appointment
    assert_equal 'Dentist', appointment.title
    assert_equal 'Go to dentist', appointment.description
    assert_equal Time.parse('2016-08-10T12:30:00.000+05:00'), appointment.appointment_start_time
  end
end
