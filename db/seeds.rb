# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

programs = [
    {
        name: "FIRST Robotics Competition",
        abbr: "FRC",
        code: "frc",
        icon: File.open(Rails.root.join("app/assets/images/FRCicon_RGB.jpg")),
        flag: File.open(Rails.root.join("app/assets/images/FRC_FlagColor_RGB.jpg"))
    },
    {
        name: "FIRST Tech Challenge",
        abbr: "FTC",
        code: "ftc",
        icon: File.open(Rails.root.join("app/assets/images/FTCicon_RGB.jpg")),
        flag: File.open(Rails.root.join("app/assets/images/FTC_FlagColor_RGB.jpg"))
    },
    {
        name: "FIRST Lego League",
        abbr: "FLL",
        code: "fll",
        icon: File.open(Rails.root.join("app/assets/images/FLLicon_RGB.jpg")),
        flag: File.open(Rails.root.join("app/assets/images/FLL_FlagColor_RGB.jpg"))
    },
    {
        name: "Jr. FIRST Lego League",
        abbr: "Jr. FLL",
        code: "jrfll",
        icon: File.open(Rails.root.join("app/assets/images/JrFLLicon_RGB.jpg")),
        flag: File.open(Rails.root.join("app/assets/images/JrFLL_FlagColor_RGB.jpg"))
    }
]

programs.each do |program|
  FirstProgram.create program
end
