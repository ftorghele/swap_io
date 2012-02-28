FactoryGirl.define do

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

  factory :user_skills do |f|
    f.association :user
    sequence(:title){|n| "Skill #{n}" }
  end

end
