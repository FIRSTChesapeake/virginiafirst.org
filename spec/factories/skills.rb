# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :skill do
    name "Some generic skill"
    is_technical false
    is_mechanical false
    is_administrative false
  end
end
