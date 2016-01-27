

FactoryGirl.define do
  random = rand(1000)
  factory :bookmark do
    url "http://MyUrl_#{random}.com"
  end
end
