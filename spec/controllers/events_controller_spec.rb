require 'spec_helper'
require 'rake'

describe EventsController do

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EventsController. Be sure to keep this updated too.
  let(:valid_session) { { 'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials("test", "test1234") } }

  describe "Events API" do
  
    before :each do
      request.accept = "application/json"
    end
  
    it "can send an empty list of events" do
      get events_path, nil, :valid_session

      # Check for 200 status code
      expect(response).to be_success

      # Check that we didn't receive any data back
      expect(json['events'].length).to eq(0)
    end

    it "sends a list of events" do
      event = FactoryGirl.create_list(:event, 10)

      get events_path, nil, :valid_session

      # Check for 200 status code
      expect(response).to be_success

      # check that the message attributes are the same.
      expect(json['events'].length).to eq(10) # check to make sure the right amount
    end

    it "sends a single event" do
      event = FactoryGirl.create(:event)
      get :show, {:id => event.id}, nil

      # Check for 200 status code
      assert_response(200)
      expect(response).to be_success

      # check that the message attributes are the same.
      expect(JSON.parse(response.body)['link1']).to eq(event.link1)
    end

    it "sends null when event does not exist" do
      get "/api/events/-1", nil, :valid_session

      # Check for 200 status code
      expect(response).to be_success

      response.body.should == "null"
    end

    it "successfully creates a new event" do
      # Add the event parameters here
      event = FactoryGirl.build(:event)
      post events_path, :event, :valid_session

      # Check for 201 status code
      expect(response).to be_success

      # Check the data we got back is ok
      ['link1', 'name1', 'organiser_email', 'organiser_name'].each do |x|
        expect(json[x]).to eq(event.send x)
      end
    end

    it "does not create event with invalid fields" do
      event = FactoryGirl.build(:event, "link1" => nil)
      post events_path, :event, :valid_session

      # Check for 422 status code
      assert_response(422)
    end

    it "updates an existing event" do
        event = FactoryGirl.create(:event)

        patch "api/events/#{event.id}", {"organiser_name" => "John"}, :valid_session

        expect(response).to be_success

        # Check field was sucessfully updated
        expect(json['organiser_name']).to eq(event.organiser_name)
    end

    it "does not update existing event with invalid fields" do
      event = FactoryGirl.create(:event)

      patch "/api/events/#{event.id}", {"link1" => nil}, :valid_session

      # Check for 422 status code
      assert_response(422)
    end

    it "destroys an existing event" do
      event = FactoryGirl.create(:event)
      delete "/api/events/#{event.id}", nil, :valid_session
      expect(response).to be_success
    end

    it "does not destroy an non-existant event" do
      delete "/api/events/-1", nil, :valid_session
      # Check for 422 status code
      assert_response(422)
    end
  end

end
