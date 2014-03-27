FactoryGirl.define do
  sequence :email do |n|
    "voter#{n}@gmail.com.au"
  end

  factory :vote do
    email
  end
end

