require "faker"
require "byebug"

puts "Cleaning DB..."
Company.destroy_all
puts "Seeding DB!"

# Faker Seed

# puts 'Creating companies...'

# companies = []

# 2.times do
#   company = Company.new(
#     name: Faker::Company.name
#   )
#   company.save!
#   companies << company
# end

# puts 'Creating students...'

# students = []

# 5.times do
#   student = User.new(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     email: Faker::Internet.email,
#     password: "seed123456"
#   )
#   company = companies.first
#   student.company = company
#   student.save!
#   students << student
# end

# 5.times do
#   student = User.new(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     email: Faker::Internet.email,
#     password: "seed123456"
#   )
#   company = companies.second
#   student.company = company
#   student.save!
#   students << student
# end

# puts 'Creating publishers...'

# publishers = []

# 2.times do
#   publisher = User.new(
#     first_name: Faker::Name.first_name,
#     last_name: Faker::Name.last_name,
#     email: Faker::Internet.email,
#     password: "seed123456",
#     publisher: true
#     )
#   company = companies.pop
#   publisher.company = company
#   publisher.save!
#   publishers << publisher
# end

# puts 'Creating courses...'

# courses = []

# 10.times do
#   course = Course.new(
#     name: Faker::Educator.course,
#     description: Faker::Lorem.sentence(3)
#   )
# publisher = publishers.sample
# course.publisher = publisher
# course.company = publisher.company
# course.save!
# courses << course
# end

# # Assigning courses to each student.

# students.each do |student|
#   company = student.company
#   company_courses = company.courses
#   courses_student_is_not_assign = Course.where(company: company).shuffle
#   rand(0..company_courses.count).times do
#     student.courses << courses_student_is_not_assign.pop
#   end
# end

# # Creating Parts and assigning them to each Course

# courses.each do |course|
#   rand(1..8).times do
#   part = Part.new(
#     video: "link",
#     description: Faker::Lorem.sentence(3)
#   )
#   course.parts << part
#   end
# end

# puts 'Finished!'

# MAIN TEST PROJECT

le_wagon = Company.create!(name: "Le Wagon")

publisher = User.new(
  first_name: "João",
  last_name: "Valério",
  email: "joaocvalerio@gmail.com",
  password: "1234567",
  publisher: true
)

publisher.company = le_wagon

users = [
  {
    first_name: "Homer",
    last_name: "Simpson",
    email: "homersimspon@beer.com",
    password: "1234567"
  },
  {
    first_name: "Darth",
    last_name: "Vader",
    email: "luke@iam.yourfather",
    password: "1234567"
  },
  {
    first_name: "Elliot",
    last_name: "Anderson",
    email: "mrrobot@crazyhacker.com",
    password: "1234567"
  }
]

courses = [
  {
    name: "Ruby on Rails 5",
    description: "Learn Ruby on Rails in 2 months",
    parts: [
      {
        description: "What is Ruby on Rails?",
        video: "exEduZlJS7Q"
      },
      {
        description: "Installing RoR",
        video: "UT4W6jAyO_o"
      },
      {
        description: "Create a Sample App",
        video: "_Xh7H_fAn2c"
      },
      {
        description: "Git and Heroku",
        video: "y9n6NDPz28A"
      },

    ]
  },
  {
    name: "React",
    description: "React makes it painless to create interactive UIs. Design
      simple views for each state in your application, and React will efficiently
      update and render just the right components when your data changes.",
    parts: [
      {
        description: "Introdution and Workspace Setup",
        video: "MhkGQAoc7bc"
      },
      {
        description: "Composing Multiple React.js Components",
        video: "vu_rIMPROoQ"
      }
    ]
  },
  {
    name: "Basic HTML5",
    description: "HTML is the language used to create the websites you visit
      everyday. It provides a logical way to structure content for
      websites.Let's analyze the acronym HTML, as it contains a lot
      of useful information.
      HTML stands for HyperText Markup Language.",
    parts: [
      {
        description: "Introduction to HTML",
        video: "dD2EISBDjWM"
      },
      {
        description: "Creating the first web page",
        video: "-USAeFpVf_A"
      },
      {
        description: "Line breaks, spacing, and comments",
        video: "i3GE-toQg-o"
      },
      {
        description: "Ordered and Unordered lists",
        video: "09oErCBjVns"
      }
    ]
  }
]

le_wagon_courses = []

courses.each do |course|
  le_wagon_course = Course.new(
    name: course[:name],
    description: course[:description]
    )
  parts = []
  course[:parts].each do |part|
    part = Part.new(description: part[:description], video: part[:video])
    parts << part
  end
  le_wagon_course.parts = parts
  le_wagon_course.company = le_wagon
  le_wagon_course.publisher = publisher
  le_wagon_course.save!
  le_wagon_courses << le_wagon_course
end

users.each do |student|
  student = User.new(
    first_name: student[:first_name],
    last_name: student[:last_name],
    email: student[:email],
    password: student[:password]
    )
  student.company = le_wagon
  courses_student_is_not_assign = Course.where(company: le_wagon).shuffle
  rand(0..le_wagon_courses.count).times do
    student.courses << courses_student_is_not_assign.pop
    student.save!
  end
end

