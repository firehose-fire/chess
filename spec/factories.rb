FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "dummyEmail#{n}@gmail.com"
    end
    password "secretPassword"
    password_confirmation "secretPassword"
  end
  
  factory :game do
    name "test"
    game_id "1"
    user_id_black 1

  end
end
