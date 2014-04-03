require 'spec_helper'
require 'rake'

describe VotesController do

  describe "Votes API" do

    before :each do
      request.accept = "application/json"
    end

    it "cannot process a non-existent event" do
      get :index, :event_id => -1

      assert_response(:unprocessable_entity)
    end

    it "can retrieve an empty list of votes for a valid event" do
      event = FactoryGirl.create(:event)
      get :index, :event_id => event.unique_id

      expect(response).to be_success

      # Check that we received an empty list
      expect(JSON.parse(response.body).length).to eq(0)
    end

    it "can retrieve a list of votes for a valid event" do
      votes_list = FactoryGirl.create(:event_with_votes, votes_count: 10)
      get :index, :event_id => votes_list.unique_id

      expect(response).to be_success
    end

    it "can send a single vote" do
      votes_list = FactoryGirl.create(:event_with_votes, votes_count: 1)
      vote = votes_list.votes[0]
      get :show, :id => vote.unique_id

      expect(response).to be_success

      json = JSON.parse(response.body)
      expect(json['id']).to eq(vote.id)
    end

    it "sends null when vote does not exist" do
      get :show, :id => -1

      assert_response(:unprocessable_entity)
    end

    it "can create a new vote for an event" do
      event = FactoryGirl.create(:event)
      post :create, {:event_id => event.unique_id, :vote => {"email" => "voter11235@spamgoes.in"}}

      assert_response(:created)
    end

    it "cannot create vote with invalid fields" do
      event = FactoryGirl.create(:event)
      post :create, {:event_id => event.id, :vote => {"email" => "bob"}}

      assert_response(:unprocessable_entity)
    end

    it "can update an existing vote" do
      votes_list = FactoryGirl.create(:event_with_votes, votes_count: 1)
      vote = votes_list.votes[0]
      patch :update, {:event_id => votes_list.unique_id, :vote_id => vote.unique_id,
        :vote => {"link1" => -1, "link2" => 1}}

      expect(response).to be_success
    end

    it "cannot update existing vote with invalid fields" do
      votes_list = FactoryGirl.create(:event_with_votes, votes_count: 1)
      vote = votes_list.votes[0]

      patch :update, {:event_id => votes_list.unique_id, :vote_id => vote.unique_id,
        :vote => {"email" => nil}}

      assert_response(:unprocessable_entity)
    end

    it "destroys an existing vote" do
      votes_list = FactoryGirl.create(:event_with_votes, votes_count: 1)
      vote = votes_list.votes[0]
      delete :destroy, {:id => vote.unique_id}

      expect(response).to be_success
    end

    it "cannot destroy a non-existant vote" do
      delete :destroy, {:id => -1}

      assert_response(:unprocessable_entity)
    end
  end

end