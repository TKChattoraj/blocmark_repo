

FactoryGirl.define do
  random = rand(1000)
  factory :topic do
    title "MyTopic_#{random}"
  end
end
