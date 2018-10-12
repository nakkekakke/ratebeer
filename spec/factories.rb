FactoryBot.define do
  factory :user do
    username { "Pekka" }
    password { "Foobar1" }
    password_confirmation { "Foobar1" }
  end

  factory :brewery do
    name { "Anonymous" }
    year { 1900 }
  end

  factory :beer do
    name { "Anonymous" }
    style
    brewery
  end

  factory :rating do
    beer
  end

  factory :style do
    name { "Cool" }
    description { "It is cool" }
  end
end
