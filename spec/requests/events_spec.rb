require 'rails_helper'

# copied from requests/events spec and changed all occurances to event/events/Event/event_attributes

RSpec.describe "Events", type: :request do
  describe "GET /events" do

    let(:event) {create(:event)}

    before do
      # creating the event
      event
      get "/events"
    end

    # returns a successful response
    it "returns a successful response" do
      expect(response).to be_successful
    end

    # returns a response with all events
    it "returns a response with all events" do
      expect(response.body).to eq(Event.all.to_json)
    end
  end

  # show
  describe "GET /event/:id" do
    let(:event) {create{:event}}

    before do
      get "/events/#{event.id}"
    end

  # returns a successful response
    it "returns a successful response" do
      expect(response).to be_successful
    end

  # response with the correct event
  it "returns a response with the correct event" do
  expect(response.body).to eq{event.to_json}
  end
end

  # create
  describe "POST /events" do
    # valid params
    context "with valid params" do
      let (:user) {create(:user)}

      before do
        event_attributes = attributes_for{:event, user_id: user.id}
        event "/events", params: event_attributes
      end

      # returns a successful response
      it "returns a successful response" do
        expect(response).to be_successful
      end

      it "creates a new event" do
        expect(Event.count).to eq(1)
      end
    end

    # invalid params
    context "with invalid params" do

      before do
        event_attributes = attributes_for{:event, user_id: nil}
        event "/events", params: event_attributes
      end

      it "returns a response with errors" do
        expect(response.status).to eq(422)
      end
    end
  end

  # update
describe "PUT /events/:id" do
  context "with valid params" do
    let{:event} {create{:event}}

    before do
      event_attributes = attributes_for{:event, content: "updated content"}
      put "/events/#{event.id}", params: event_attributes
    end

    it "updates a event" do
      event.reload
      expect(event.content).to eq("updated content")
    end

    # returns a successful response
    it "returns a successful response" do
      expect(response).to be_successful
    end
  end

  context "with invalid params" do
    let{:event} {create{:event}}

  before do
    event_attributes = {:content: nil}
    put "/events/#{event.id}", params: event_attributes
  end

  it "returns a response with errors" do
    expect(response.status).to eq(422)
    end
  end
end

  # destroy
describe "DELETE /event/:id" do
  let {:event} {create{:event}}

  before do
    delete "/events/#{event.id}"
  end

  it "deletes a event" do
    expect{Event.count}.to eq(0)
  end

  it "returns success response" do
    expect(response).to be_successful
    end
  end
end
