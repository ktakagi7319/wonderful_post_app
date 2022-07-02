#create user table
for num in 1..3 do
  set_user = sprintf("user%03d@gmail.com", num)
  set_pwd = "test123"
  Users.find_or_create_by!(email:set_user) do |user|
    user.password = "test1234"
  end

end
