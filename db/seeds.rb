require "faker"

puts "Cleaning DB..."
Company.destroy_all
puts "Seeding DB!"
puts 'Creating companies...'

companies = []

2.times do
  company = Company.new(
    name: Faker::Company.name
  )
  company.save!
  companies << company
end

puts 'Creating students...'

students = []

5.times do
  student = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "seed123456"
  )
  company = companies.first
  student.company = company
  student.save!
  students << student
end

5.times do
  student = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "seed123456"
  )
  company = companies.second
  student.company = company
  student.save!
  students << student
end

puts 'Creating publishers...'

publishers = []

2.times do
  publisher = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "seed123456",
    publisher: true
    )
  company = companies.pop
  publisher.company = company
  publisher.save!
  publishers << publisher
end

puts 'Creating courses...'

courses = []

10.times do
  course = Course.new(
    name: Faker::Educator.course,
    description: Faker::Lorem.sentence(3)
  )
publisher = publishers.sample
course.publisher = publisher
course.company = publisher.company
course.save!
courses << course
end

# Assigning courses to each student.

students.each do |student|
  company = student.company
  company_courses = company.courses
  courses_student_is_not_assign = Course.where(company: company).shuffle
  rand(0..company_courses.count).times do
    student.courses << courses_student_is_not_assign.pop
  end
end

# Creating Parts and assigning them to each Course

courses.each do |course|
  rand(1..8).times do
  part = Part.new(
    video: "link",
    description: Faker::Lorem.sentence(3)
  )
  course.parts << part
  end
end

puts 'Finished!'








