
FactoryGirl.define do
  factory :authentication, class: AuthProvider do
    provider "Google"
    sequence(:uid) { |n| n.to_s }
    user
  end
end