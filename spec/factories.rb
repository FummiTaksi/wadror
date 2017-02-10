FactoryGirl.define do
  factory :user do
    username "Pekka"
    password "Foobar1"
    password_confirmation "Foobar1"
  end

  factory :user2, class: User do
    username "Jorma"
    password "Jorma1"
    password_confirmation "Jorma1"
  end

  factory :rating do
    score 10
  end

  factory :rating2, class: Rating do
    score 20
  end

  factory :brewery do
    name "anonymous"
    year 1900
  end

  factory :brewery2, class: Brewery do
    name "Brewery2"
    year 2000
  end

  factory :brewery3, class: Brewery do
    name "Brewery3"
    year 2000
  end

  factory :beer do
    name "anonymous"
    brewery
    style "Lager"
  end

  factory :beer2 ,class: Beer do
    name "ok"
    brewery
    style "Weizen"
  end

  factory :beer3, class: Beer do
    name "jees"
    brewery
    style "Pale Ale"
  end

  factory :beer4, class: Beer do
    name "ipa"
    brewery
    style "IPA"
  end
end