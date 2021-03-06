
FactoryGirl.define do
  require 'hash'

  factory :course do |f|
    f.association :user
    sequence(:date){"2020-05-24 10:38:36"}
    sequence(:city){"Salzburg"}
    sequence(:zip_code){5020}
    sequence(:time){"10:38:36"}
    sequence(:places){10}
    sequence(:country){"Austria"}
    sequence(:title){|n| "Photography tut #{n}" }
    sequence(:description){|n| "Landscape photography tutorial with somebody else than me... #{n}" }
  end

  factory :course_request do |f|
    sequence(:title){|n| "Kurs Nr. #{n}" }
    sequence(:description){|n| "Beschreibung Nr. #{n}" }
  end

  factory :user_key do |f|
    sequence(:key){|n| "userkey#{n}" }
  end

  factory :user do |f|
    key = Factory.create(:user_key).key
    f.user_key key
    sequence(:email){|n| "Josef#{n}@haunsberg.at" }
    sequence(:first_name){|n| "Josef#{n}" }
    sequence(:last_name){|n| "Haunsberger#{n}" }
    sequence(:country){"Austria"}
    sequence(:zip){5020}
    sequence(:password){"000000"}
    sequence(:password_confirmation){"000000"}
  end

  factory :course_member do |f|
    f.association :user
    f.association :course
  end

  factory :category do |f|
    sequence(:title){|n| "Category #{n}" }
  end

  factory :category_abonnement do |f|
    f.association :user
    f.association :category
  end

  factory :user_skill do |f|
    sequence(:title){|n| "Skill #{n}" }
    f.association :user
  end

  factory :newsletter do |f|
    sequence(:title){|n| "Newsletter#{n}" }
    sequence(:body){|n| "Newsletter content and so ...........#{n}" }
  end

  factory :newsletter_subscriber do |f|
    sequence(:email){|n| "email@bla.at#{n}" }
    f.signout_hash Hash.create_token("email@bla.at")
  end

end
