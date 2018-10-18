FactoryBot.define do
  factory :piece do
    type {"King"}

  end
  
  factory :king do
    
  end
  factory :queen do
    
  end
  factory :rook do
    
  end

  factory :bishop do
    
  end

  factory :knight do
    
  end
  factory :pawn do
    coordinate_x 0
    coordinate_y 0
    user_id 0
    game
  end

  factory :user do
    sequence :email do |n|
      "dummi#{n}Email#{n}@gmail.com"
    end

    password {"secretPassword"}
    password_confirmation {"secretPassword"}
    sequence :id do |i|
      "#{i}#{i}"
    end

  end
  
  factory :game do
    name {"test"}
    user_black_id {1}
    sequence :id do |i|
      "#{i}#{i}"
    end
  end


  


end
