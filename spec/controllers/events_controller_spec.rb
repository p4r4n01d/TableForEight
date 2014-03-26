require 'spec_helper'
require 'rake'

describe EventsController do

  describe "Events API" do
  
    before :each do
      request.accept = "application/json"
    end
  
    it "can send an empty list of events" do
      get :index

      # Check for 200 status code
      expect(response).to be_success

      # Check that we didn't receive any data back
      expect(JSON.parse(response.body).length).to eq(0)
    end

    it "sends a list of events" do
      DatabaseCleaner.start
      event = FactoryGirl.create_list(:event, 10)

      get :index

      # Check for 200 status code
      expect(response).to be_success

      # check that the message attributes are the same.
      expect(JSON.parse(response.body).length).to eq(10) # check to make sure the right amount
      DatabaseCleaner.clean
    end

    it "sends a single event" do
      DatabaseCleaner.start
      event = FactoryGirl.create(:event)
      get :show, {:id => event.id}

      # Check for 200 status code
      assert_response(200)

      # check that the message attributes are the same.
      expect(JSON.parse(response.body)['id']).to eq(event.id)
      DatabaseCleaner.clean
    end

    it "sends null when event does not exist" do
      DatabaseCleaner.start
      get :show, {:id => -1}

      # Check for 200 status code
      expect(response).to be_success

      response.body.should == "null"
      DatabaseCleaner.clean
    end

    it "successfully creates a new event" do
      DatabaseCleaner.start
      # Add the event parameters here
      event = FactoryGirl.build(:event)
      post :create, event

      # Check for 201 status code
      assert_response(201)

      # Check the data we got back is ok
      ['link1', 'organiser_email', 'date1'].each do |x|
        expect(JSON.parse(response.body)[x]).to eq(event.send x)
      end
      DatabaseCleaner.clean
    end

    it "does not create event with invalid fields" do
      DatabaseCleaner.start
      event = FactoryGirl.build(:event, "link1" => nil)
      post :create, event

      # Check for 422 status code
      assert_response(422)
      DatabaseCleaner.clean
    end

    it "updates an existing event" do
      DatabaseCleaner.start
      event = FactoryGirl.create(:event)

      patch :update, {:id => event.id, "organiser_name" => "John"}

      expect(response).to be_success
      DatabaseCleaner.clean
    end

    it "does not update existing event with invalid fields" do
      DatabaseCleaner.start
      event = FactoryGirl.create(:event)

      patch :update, {"id" => event.id, "link1" => nil}

      # Check for 422 status code
      assert_response(422)
      DatabaseCleaner.clean
    end

    it "destroys an existing event" do
      DatabaseCleaner.start
      event = FactoryGirl.create(:event)
      delete :destroy, {:id => event.id}
      expect(response).to be_success
      DatabaseCleaner.clean
    end

    it "does not destroy an non-existant event" do
      DatabaseCleaner.start
      delete :destroy, {:id => -1}
      # Check for 422 status code
      assert_response(422)
      DatabaseCleaner.clean
    end
  end

end
