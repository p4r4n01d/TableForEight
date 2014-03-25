require 'spec_helper'

describe EventsController do

  # This should return the minimal set of attributes required to create a valid
  # Event. As you add validations to Event, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { {  } }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EventsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "Events API" do
    it "sends a list of events" do
      event = FactoryGirl.create_list(:event, 10)

      get "api/events"

      # Check for 200 status code
      expect(response).to be_success

      # check that the message attributes are the same.
      expect(json['events'].length).to eq(10) # check to make sure the right amount
    end

    it "can send an empty list of events" do
      get "api/events"

      # Check for 200 status code
      expect(response).to be_success

      # Check that we didn't receive any data back
      expect(json['events'].length).to eq(0)
    end

    it "sends a single event" do
      event = FactoryGirl.create(:event)
      get "api/events/#{event.id}"

      # Check for 200 status code
      expect(response).to be_success

      # check that the message attributes are the same.
      expect(json['link1']).to eq(event.link1)
    end

    it "sends null when event does not exist" do
      get "api/events/#{event.id}"

      # Check for 200 status code
      expect(response).to be_success

      response.body.should == "null"
    end

    it "successfully creates a new event" do
      # Add the event parameters here
      post "api/events", {"link1" => "http://www.google.com", "name1" => "The internets",
        "organiser_name" => "Fred", "organiser_email" => "fred@gmail.com"}

      # Check for 201 status code
      expect(response).to be_success

      # Check the data we got back is ok
      ['link1', 'name1', 'organiser_email', 'organiser_name'].each |x| do
        expect(json[x]).to eq(event.send x)
      end
    end

    it "does not create event with invalid fields" do
      post "api/events", {"link1" => nil, "name1" => "Bob's place",
        "organiser_name" => "Fred", "organiser_email" => "fred@gmail.com"}

      # Check for 422 status code
      assert_response(422)
    end

    it "updates an existing event" do
        event = FactoryGirl.create(:event)

        patch "api/events/#{event.id}", {"organiser_name" => "John"}

        expect(response).to be_success

        # Check field was sucessfully updated
        expect(json['organiser_name']).to eq(event.organiser_name)

        #expect {
        #  post :create, {:event => valid_attributes}, valid_session
        #}.to change(Event, :count).by(1)
    end

    it "does not update existing event with invalid fields" do
      event = FactoryGirl.create(:event)

      patch "api/events/#{event.id}", {"link1" => nil}

      # Check for 422 status code
      assert_response(422)
    end

    it "destroys an existing event" do
      event = FactoryGirl.create(:event)
      put "/api/events/#{event.id}"
      expect(response).to be_success
    end

    it "does not destroy an non-existant event" do
      put "/api/events/-1"
      # Check for 422 status code
      assert_response(422)
    end
  end

end
