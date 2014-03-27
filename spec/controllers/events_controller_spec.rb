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

      # check to make sure the right amount
      expect(JSON.parse(response.body).length).to eq(10)
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
      event = FactoryGirl.build(:event)
      post :create, {:event => event.attributes}

      # Check for 201 status code
      expect(response).to be_success

      JSON.parse(response.body)["events"][:id].should == event.id
      DatabaseCleaner.clean
    end

    it "does not create event with invalid fields" do
      DatabaseCleaner.start
      event = FactoryGirl.build(:event, "link1" => nil)
      post :create, :event => event.attributes

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

      patch :update, {:id => event.id, :event => {:link1 => nil}}

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

    it "does not destroy a non-existant event" do
      delete :destroy, {:id => 100}
      # Check for 422 status code
      assert_response(422)
    end
  end

end
