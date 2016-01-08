include RandomData

FactoryGirl.define do
  random = rand(1000)
  factory :bookmark do
    url "MyUrl_#{random}"
  end
end
