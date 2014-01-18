# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do

  factory :user do
    first_name "Dany"
    last_name "Targaryen"
    age 18
    state "MA"
    sequence(:email) {|n| "person#{n}@example.com"}
    password "password"
    password_confirmation "password"

    factory :admin do
      role "admin"
    end

  end

end
