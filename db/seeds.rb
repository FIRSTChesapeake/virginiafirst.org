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

skills = [
    { name: "Mechanical Engineering/Design", is_mechanical: true, is_technical: true },
    { name: "Electrical Engineering/Design", is_technical: true },
    { name: "CAD (Autodesk Inventor, PTC ProEngineer and Creo", is_mechanical: true, is_technical: true },
    { name: "Control Systems and Software (LabView, Java, C++)", is_technical: true },
    { name: "Machining/Milling/Welding", is_mechanical: true },
    { name: "Electrical Layout and Wiring", is_technical: true },
    { name: "Pneumatics Layout and Wiring", is_mechanical: true, is_technical: true },
    { name: "Assembly and Testing", is_mechanical: true, is_technical: true },
    { name: "Administration", is_administrative: true },
    { name: "Project Management", is_administrative: true },
    { name: "PR/Marketing", is_administrative: true },
    { name: "Long-Range Planning", is_administrative: true },
    { name: "Finance", is_administrative: true },
    { name: "Human Resources and Volunteer Management", is_administrative: true },
    { name: "Travel and Logistics Coordination", is_administrative: true },
    { name: "Documentation and Record-keeping", is_administrative: true },
    { name: "Web Site Development", is_technical: true },
    { name: "Programming", is_technical: true }
]

skills.each do |attributes|
  Skill.find_or_create_by name: attributes[:name] do |skill|
    skill.is_administrative = attributes[:is_administrative]
    skill.is_mechanical = attributes[:is_mechanical]
    skill.is_technical = attributes[:is_technical]
  end
end
