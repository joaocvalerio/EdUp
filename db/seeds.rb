require "faker"

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
  company = companies.sample
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
  company = companies.sample
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
company = companies.sample
course.company = company
course.users << publishers.sample
course.save!
courses << course
end

# Assigning courses to each Student

students.each do |student|
  courses_student_not_assign = courses
  rand(0..courses.count).times do
    student.courses << courses_student_not_assign.shuffle.pop
  end
end

# Creating Parts and assigging them to each Course

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







