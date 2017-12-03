json.@company_users do
  json.array! @company_users do |company_user|
    json.extract! company_user, :id, :first_name, :last_name, :email
  end
end


