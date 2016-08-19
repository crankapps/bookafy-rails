require 'test_helper'

class Bookafy::Model::CustomerTest < ActiveSupport::TestCase
  def test_that_new_customer_created
    customer = Bookafy::Model::Customer.new(name: 'Ivan', email: 'ivan@esseworks.com')
    assert_not_equal nil, customer
    assert_equal 'Ivan', customer.name
    assert_equal 'ivan@esseworks.com', customer.email
  end
end
