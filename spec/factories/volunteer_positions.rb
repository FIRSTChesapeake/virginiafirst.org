# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :volunteer_position, :class => 'Volunteer::Position' do
    event nil
    role nil
    needed_count 1
  end
end
