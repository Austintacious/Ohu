# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    title "MyString"
    description "MyText"
    completion_status 1
    success_status "MyText"
  end
end
