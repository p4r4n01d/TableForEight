require 'spec_helper'
require 'rake'

describe Event do
  context  'associations' do
    it { should have_many(:votes) }
  end

  context  'validations' do
    it { should validate_presence_of(:organiser_email) }
    it { should validate_presence_of(:link1) }
    it { should validate_presence_of(:date1) }

    it { should allow_value(10.minutes.from_now).for(:date) }
    it { should allow_value(10.minutes.from_now).for(:date1) }
    it { should allow_value(10.minutes.from_now).for(:date2) }
    it { should allow_value(10.minutes.from_now).for(:date3) }

    it { should_not allow_value(10.days.ago).for(:date) }
    it { should_not allow_value(10.days.ago).for(:date1) }
    it { should_not allow_value(10.days.ago).for(:date2) }
    it { should_not allow_value(10.days.ago).for(:date3) }

    it { should allow_value(10.days.from_now).for(:date) }
    it { should allow_value(10.days.from_now).for(:date1) }
    it { should allow_value(10.days.from_now).for(:date2) }
    it { should allow_value(10.days.from_now).for(:date3) }
    
    it { should allow_value("Bob").for(:organiser_name) }
    it { should_not allow_value("B0b1").for(:organiser_name) }
  end
end

