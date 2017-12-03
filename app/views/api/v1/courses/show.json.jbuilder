json.course do
  json.extract! @course, :id, :name, :description
  json.parts @course.parts do |part|
    json.extract! part, :id, :description, :video
  end
  json.students @course.students do |student|
    json.extract! student, :id, :first_name, :last_name, :email
  end
end


