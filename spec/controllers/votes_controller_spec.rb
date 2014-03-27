require 'spec_helper'
require 'rake'

describe VotesController do

  describe "Votes API" do
  
    before :each do
      request.accept = "application/json"
    end
  
    it "fails to process an non-existant event" do
      get :index, :event_id => 100
      
      # Check for 422 status code
      assert_response(422)
      DatabaseCleaner.clean
    end
  end

end
