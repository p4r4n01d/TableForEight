FactoryGirl.define do
  sequence :organiser_email do |n|
    "organiser#{n}.gmail.com.au"
  end

  factory :event do
    link1 "http://www.superawsomerestraunt.com.au"
    date1 "2014-05-05 12:00:00"
    organiser_email
  end
end

