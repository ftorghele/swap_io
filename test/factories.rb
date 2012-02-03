FactoryGirl.define do

  factory :course do
    title 'Photography tut'
    description  'Landscape photography tutorial with somebody else than me...'
  end

  factory :course_request do |cr|
    sequence(:title){|n| "Kurs Nr. #{n}" }
    sequence(:description){|n| "Beschreibung Nr. #{n}" }
  end

end
