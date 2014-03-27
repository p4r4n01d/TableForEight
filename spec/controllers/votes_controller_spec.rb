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
    
    it "retreives an empty list of votes for a valid event" do
      DatabaseCleaner.start
      event = FactoryGirl.create(:event)
      get :index, :event_id => event.id

      # Check for 200 status code
      expect(response).to be_success

      # Check that we didn't receive any data back
      expect(JSON.parse(response.body)[:votes]).to be_nil
      DatabaseCleaner.clean
    end
    
    it "retreives a list of votes" do
      DatabaseCleaner.start
      votes_list = FactoryGirl.create(:event_with_votes, votes_count: 10)
      
      get :index, :event_id => votes_list.id

      # Check for 200 status code
      expect(response).to be_success

      expect(JSON.parse(response.body)["votes"].length).to eq(10)
      DatabaseCleaner.clean
    end
    
    it "sends a single vote" do
      DatabaseCleaner.start
      votes_list = FactoryGirl.create(:event_with_votes, votes_count: 1)
      vote = votes_list.votes[0]
      get :show, :id => vote.id
      
      # Check for 200 status code
      expect(response).to be_success

      json = JSON.parse(response.body)
      expect(json['id']).to eq(vote.id)
      DatabaseCleaner.clean
    end
    
    it "sends null when vote does not exist" do
      get :show, :id => 100

      # Check for 200 status code
      assert_response(422)
    end
  end

end
