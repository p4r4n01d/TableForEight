require 'spec_helper'
require 'rake'

describe Event do
  it { should have_many(:votes) }

  it { should validate_presence_of(:organiser_email) }
  it { should validate_presence_of(:link1) }
  it { should validate_presence_of(:date1) }
end
