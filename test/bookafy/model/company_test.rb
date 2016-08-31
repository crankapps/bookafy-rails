require 'test_helper'

class Bookafy::Model::CompanyTest < ActiveSupport::TestCase
  def test_that_new_company_is_created
    company = Bookafy::Model::Company.new(name: 'Smartlist')
    assert_not_equal nil, company
    assert_equal 'Smartlist', company.name
  end
end
