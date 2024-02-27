require 'rails_helper'

# copied from requests/events spec and changed all occurances to event/events/Event/event_attributes, then changed a lot from Authentication User Requests video

RSpec.describe "Events", type: :request do
  let {:user} {create{:user}}
  let(:token) { auth_token_for_user(:user) }

  # get events - index
  describe "GET /events" do
    it 'returns a response with all the events' do
      create(:event)
      get '/events', 
      headers: { Authorization: "Bearer #{token}" }
      expect(response.body).to eq(Event.all.to_json)
    end
  end

  # get event - show
  describe "GET /event" do
    let(:event) { create{:event} }

    it 'returns a response with a specified event' do
      get "/events/#{event.id}", 
      headers: { Authorization: "Bearer #{token}" }
      expect(response.body).to eq(event.to_json)
    end
  end

  # create event - create
  describe "POST /events" do
    # valid params
    #context "with valid params" do
    let {:user} {create{:user}}
    let(:token) { auth_token_for_user(:user) }
      let (:sport) {create(:sport)}

      before do
        event_attributes = attributes_for{:event, user_id: user.id, sport_id: [sport.id]}
        post "/events", params: event_attributes, 
        headers: { Authorization: "Bearer #{token}" }
      end

      # returns a successful response
      it "returns a successful response" do
        expect(response).to be_successful
      end

      it "creates a new event" do
        expect(Event.count).to eq(1)
      end
    end

  # update event - update
describe "PUT /events/:id" do
  #context "with valid params" do
    let {:user} {create{:user}}
    let(:token) { auth_token_for_user(:user) }
    let{:event} {create{:event}}

    before do 
      put "/events/#{event.id}", params: (title: "New Title"), 
      headers: { Authorization: "Bearer #{token}" }
    end
  end

    it "updates a event" do
      event.reload
      expect(event.title).to eq("New Title")
    end

  # delete event - destroy
describe "DELETE /event/:id" do
  let {:user} {create{:user}}
  let(:token) { auth_token_for_user(:user) }
  let {:event} {create{:event}}

  before do
    delete "/events/#{event.id}", 
    headers: { Authorization: "Bearer #{token}" }
  end

  it "deletes a event" do
    expect{Event.count}.to eq(0)
  end

  it 'destroys event participants' do
    event_participants = EventParticipant.where(event_id: event.id)
    expect(event_participants).to be_empty
    end
  end
end
