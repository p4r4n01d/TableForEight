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
    end
    
    it "retreives and empty list of votes for a valid event" do
      DatabaseCleaner.start
      event = FactoryGirl.create(:event)
      get :index, :event_id => event.id

      # Check for 200 status code
      expect(response).to be_success

      # Check that we didn't receive any data back
      expect(JSON.parse(response.body)[:votes]).to be_nil
      DatabaseCleaner.clean
    end
  end

end
