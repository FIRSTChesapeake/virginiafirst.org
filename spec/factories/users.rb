# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "jdoe#{n}@test.com" }
    password "p@ssw0rd"
    password_confirmation { password }

    factory :admin do
      roles { [Role[:admin]] }
    end

    factory :volunteer_coordinator do
      roles { [Role[:volunteer_coordinator]] }
    end
  end
end
