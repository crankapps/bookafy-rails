# Bookafy::Rails

This is a gem that enables you to get customer and appointment data from [Bookafy](http://www.bookafy.com/).

Bookafy is an automated scheduling for service appointments, calls, meetings, and much more.

[![Gem Version](https://badge.fury.io/rb/bookafy.svg)](https://badge.fury.io/rb/bookafy)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'bookafy'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install bookafy

## Usage

Once you obtain OAuth access token, you should set it up

```rails
    Bookafy.access_token = '6911d4a6b217bd637db0c81741482cdb497738cd52c1b3996528094c1e47c345'
```

#### Customers

To fetch all customers you can use:

```rails
    customer_service = Bookafy::Customer.new
    customers = customer_service.all # an array of Customer models
    
    # or if you want to get only customers that have been updated since some time
    customers = customer_service.all(updated: 7.days.ago.to_i)
```

#### Appointments

To fetch all appointments you can use:

```rails
    appointments_service = Bookafy::Appointment.new
    appointments = appointments_service.all # an array of Appointment models
    
    # or if you want to get only customers that have been updated since some time
    appointments = appointments_service.all(updated: 7.days.ago.to_i)
```


## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/bookafy-rails. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.


## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

