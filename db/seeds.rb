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

puts 'Creating users...'

users = []

10.times do
  user = User.new(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email,
    password: "seed123456"
  )
  company = companies.sample
  user.company = company
  user.save!
  users << user
end


puts 'Creating publishers...'

2.times do
  publisher = users.shuffle.pop.update(publisher: true)
end

puts 'Creating courses...'

courses = []

10.times do
  course = Course.new(
    name: Faker::Educator.course,
    description: Faker::Lorem.sentence(3)
  )
publisher = User.where(publisher: true).sample
course.publisher = publisher
course.company = publisher.company
course.save!
courses << course
end

# Assigning courses to each student. Publisher can also be a student (from other
# publishers courses or is own courses)

users.each do |student|
  courses_student_is_not_assign = courses
  rand(0..courses.count).times do
    student.courses << courses_student_is_not_assign.shuffle.pop
  end
end

# Creating Parts and assigning them to each Course

courses.each do |course|
  rand(1..8).times dosqui
  part = Part.new(
    video: "link",
    description: Faker::Lorem.sentence(3)
  )
  course.parts << part
  end
end

puts 'Finished!'







