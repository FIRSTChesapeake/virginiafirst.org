# Read about factories at https://github.com/thoughtbot/factory_girl

include ActionDispatch::TestProcess

FactoryGirl.define do
  factory :frc_program, class: FirstProgram do
    name "FIRST Robotics Competition"
    code "frc"
    icon { fixture_file_upload(Rails.root.join(*%w[app assets images FRCicon_RGB.jpg]), "image/jpeg") }
    flag { fixture_file_upload(Rails.root.join(*%w[app assets images FRC_FlagColor_RGB.jpg]), "image/jpeg") }
    initialize_with { FirstProgram.find_or_create_by_code code }
  end

  factory :ftc_program, class: FirstProgram do
    name "FIRST Tech Challenge"
    code "ftc"
    icon { fixture_file_upload(Rails.root.join(*%w[app assets images FTCicon_RGB.jpg]), "image/jpeg") }
    flag { fixture_file_upload(Rails.root.join(*%w[app assets images FTC_FlagColor_RGB.jpg]), "image/jpeg") }
    initialize_with { FirstProgram.find_or_create_by_code code }
  end
end
