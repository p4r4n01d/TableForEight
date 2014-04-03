require 'spec_helper'
require 'rake'

describe EventsController do

  describe "Events API" do
  
    before :each do
      request.accept = "application/json"
    end
  
    it "can send an empty list of events" do
      get :index

      assert_response(:ok)

      # Check that we didn't receive any data.
      expect(JSON.parse(response.body).length).to eq(0)
    end

    it "can send a list of events" do
      event = FactoryGirl.create_list(:event, 10)
      get :index

      expect(response).to be_success

      # Check if the correct number of events is returned.
      expect(JSON.parse(response.body).length).to eq(10)
    end

    it "can send a single event" do
      event = FactoryGirl.create(:event)
      get :show, {:id => event.unique_id}

      assert_response(:ok)

      # Check if the message attributes are the same.
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

    it "can successfully create a new event" do
      event = FactoryGirl.build(:event)
      post :create, {:event => event.attributes}

      expect(response).to be_success

      JSON.parse(response.body)[:id].should == event.id
    end

    it "cannot create event with invalid fields" do
      event = FactoryGirl.build(:event, "link1" => nil)
      post :create, :event => event.attributes

      assert_response(:unprocessable_entity)
    end

    it "can update an existing event" do
      event = FactoryGirl.create(:event)
      patch :update, {:id => event.unique_id, "organiser_name" => "John"}

      expect(response).to be_success
    end

    it "cannot update existing event with invalid fields" do
      event = FactoryGirl.create(:event)
      patch :update, {:id => event.unique_id, :event => {:link1 => nil}}

      assert_response(:unprocessable_entity)
    end

    it "can destroy an existing event" do
      event = FactoryGirl.create(:event)
      delete :destroy, {:id => event.unique_id}

      expect(response).to be_success
    end

    it "cannot destroy a non-existent event" do
      delete :destroy, {:id => 100}

      assert_response(:unprocessable_entity)
    end
  end
end