require 'spec_helper'
require 'rake'

describe Event do
  it { should belong_to(:event) }

  it { should validate_presence_of(:email) }
end
