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
    style { "Lager" }
    brewery # uses factory :brewery
  end

  factory :rating do
    score { 10 }
    beer
    user
  end
end
