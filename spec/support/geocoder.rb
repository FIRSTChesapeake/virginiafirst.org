
RSpec.configure do |config|
  Geocoder.configure lookup: :test

  Geocoder::Lookup::Test.set_default_stub(
      [
          {
              'latitude' => 40.7143528,
              'longitude' => -74.0059731,
              'address' => '123 Main St, Metropolis, VA, 12345',
              'state' => 'Virginia',
              'state_code' => 'VA',
              'country' => 'United States',
              'country_code' => 'US'
          }
      ]
  )
end