FactoryGirl.define do
  sequence :organiser_email do |n|
    "organiser#{n}@gmail.com.au"
  end

  factory :event do
    link1 "http://www.superawsomerestraunt.com.au"
    date1 "2014-05-05 12:00:00"
    organiser_email
    
    factory :event_with_votes do
      # Number of votes for this event. It is is declared as an ignored
      # attribute and available in attributes on the factory, as well as the
      # callback via the evaluator
      ignore do
        votes_count 5
      end

      # the after(:create) yields two values; the user instance itself and the
      # evaluator, which stores all values from the factory, including ignored
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the vote is associated properly to the event
      after :create  do |event, evaluator|
        create_list(:vote, evaluator.votes_count, event: event)
      end
    end

  end
end

