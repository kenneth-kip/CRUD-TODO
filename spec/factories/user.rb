FactoryGirl.define do
  factory :user do
    username { Faker::Name.name }
    email 'foo@bar.com'
    password 'secret123'
  end
end
