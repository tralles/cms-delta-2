FactoryGirl.define do
  factory :user do
    name "John"
    surname  "Doe"
    email "jon@goe.de"
    password "123456789"
    password_confirmation "123456789"
  end
end