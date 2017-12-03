  json.students @course.students do |student|
    json.extract! student, :id, :first_name, :last_name, :email
  end
