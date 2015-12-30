include RandomData

FactoryGirl.define do
  random = rand(1000)
  factory :user do
    user_name "User_Name_#{random}"
    email {"#{user_name}@factory.com"}
    password "hello_world_#{random}"
    password_confirmation "hello_world_#{random}"
  end
end
