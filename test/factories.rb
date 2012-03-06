
FactoryGirl.define do
  require 'hash'

  factory :course do |f|
    f.association :user
    f.association :category
    sequence(:title){|n| "Photography tut #{n}" }
    sequence(:description){|n| "Landscape photography tutorial with somebody else than me... #{n}" }
  end

  factory :course_request do |f|
    sequence(:title){|n| "Kurs Nr. #{n}" }
    sequence(:description){|n| "Beschreibung Nr. #{n}" }
  end

  factory :user do |f|
    sequence(:email){|n| "Josef#{n}@haunsberg.at" }
    sequence(:first_name){|n| "Josef#{n}" }
    sequence(:last_name){|n| "Haunsberger#{n}" }
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
