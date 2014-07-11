# Read about factories at https://github.com/thoughtbot/factory_girl

include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :frc_program, class: FirstProgram do
    name 'FIRST Robotics Competition'
    code 'frc'
    abbr 'FRC'
    icon { fixture_file_upload(Rails.root.join(*%w[app assets images FRCicon_RGB.jpg]), 'image/jpeg') }
    flag { fixture_file_upload(Rails.root.join(*%w[app assets images FRC_FlagColor_RGB.jpg]), 'image/jpeg') }
    initialize_with { FirstProgram.find_or_create_by code: code }

    factory :frc_program_with_roles do
      after(:create) do |program|
        FactoryGirl.create_list :volunteer_role, 3, program: program
      end
    end
  end

  factory :ftc_program, class: FirstProgram do
    name 'FIRST Tech Challenge'
    code 'ftc'
    abbr 'FTC'
    icon { fixture_file_upload(Rails.root.join(*%w[app assets images FTCicon_RGB.jpg]), 'image/jpeg') }
    flag { fixture_file_upload(Rails.root.join(*%w[app assets images FTC_FlagColor_RGB.jpg]), 'image/jpeg') }
    initialize_with { FirstProgram.find_or_create_by code: code }
  end
end
