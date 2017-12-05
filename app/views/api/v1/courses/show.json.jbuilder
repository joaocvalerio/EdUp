json.course do
  json.extract! @course, :id, :name, :description
  json.parts @course.parts do |part|
    json.extract! part, :id, :description, :video
  end
  json.students @course.students do |student|
    json.extract! student, :id, :first_name, :last_name, :email
  end
  json.students @course.students do |student|
    json.first_name student.first_name
    json.last_name student.last_name
    json.email student.email
    json.state student.state(@course)
  end
end


