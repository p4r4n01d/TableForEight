require 'spec_helper'
require 'rake'

describe EventsController do

  describe "Events API" do
  
    before :each do
      request.accept = "application/json"
    end
  
    it "can send an empty list of events" do
      get :index
      expect(response).to be_success

      # Check that we didn't receive any data back
      expect(JSON.parse(response.body).length).to eq(0)
    end

    it "sends a list of events" do
      event = FactoryGirl.create_list(:event, 10)

      get :index
      expect(response).to be_success

      # check to make sure the right amount of events back
      expect(JSON.parse(response.body).length).to eq(10)
    end

    it "sends a single event" do
      event = FactoryGirl.create(:event)
      get :show, {:id => event.unique_id}
      assert_response(200)

      # check that the message attributes are the same.
      json = JSON.parse(response.body)

      fields = ['id', 'link1', 'organiser_email']
      fields.each do |field|
        expect(json[field]).to eq(event[field])
      end
    end

    it "sends null when event does not exist" do
      get :show, {:id => -1}
      expect(response).to be_success

      response.body.should == "null"
    end

    it "successfully creates a new event" do
      event = FactoryGirl.build(:event)
      post :create, {:event => event.attributes}

      expect(response).to be_success

      JSON.parse(response.body)[:id].should == event.id
    end

    it "does not create event with invalid fields" do
      event = FactoryGirl.build(:event, "link1" => nil)
      post :create, :event => event.attributes

      assert_response(422)
    end

    it "updates an existing event" do
      event = FactoryGirl.create(:event)

      patch :update, {:id => event.unique_id, "organiser_name" => "John"}
      expect(response).to be_success
    end

    it "does not update existing event with invalid fields" do
      event = FactoryGirl.create(:event)

      patch :update, {:id => event.unique_id, :event => {:link1 => nil}}
      assert_response(422)
    end

    it "destroys an existing event" do
      event = FactoryGirl.create(:event)
      delete :destroy, {:id => event.unique_id}
      expect(response).to be_success
    end

    it "does not destroy a non-existant event" do
      delete :destroy, {:id => 100}
      assert_response(422)
    end
  end

end
