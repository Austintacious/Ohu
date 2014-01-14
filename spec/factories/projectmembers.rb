# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :projectmember do
    user
    project
  end
end
