FactoryGirl.define do

  factory :course do |c|
    c.association :user
    sequence(:title){|n| "Photography tut #{n}" }
    sequence(:description){|n| "Landscape photography tutorial with somebody else than me... #{n}" }
  end

  factory :course_request do |cr|
   # c.association :user
    sequence(:title){|n| "Kurs Nr. #{n}" }
    sequence(:description){|n| "Beschreibung Nr. #{n}" }
  end

  factory :user do |u|
    sequence(:email){|n| "Josef#{n}@haunsberg.at" }
    sequence(:first_name){|n| "Josef#{n}" }
    sequence(:last_name){|n| "Haunsberger#{n}" }
    sequence(:gender){"male"}
    sequence(:password){"000000"}
    sequence(:password_confirmation){"000000"}
  end

end
