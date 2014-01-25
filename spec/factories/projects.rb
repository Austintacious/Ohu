# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :project do
    user
    title "My Project"
    description "Some words that describe"
    completion_status 10
    success_status "Needs work"
  end
end
