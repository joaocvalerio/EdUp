json.courses do
  json.array! @courses do |course|
    json.extract! course, :company_id, :id, :name, :description
    json.publisher course.publisher.full_name
  end
end
7
