json.course do
  json.extract! @course, :id, :name, :description
  json.parts @course.parts do |part|
    json.extract! part, :id, :description, :video
  end
end


