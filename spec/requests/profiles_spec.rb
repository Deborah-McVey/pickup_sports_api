require 'rails_helper'

# copied from requests/profiles spec and changed occurances to profile/profiles/Profile


RSpec.describe "Profiles", type: :request do
  describe "GET /profiles" do

    let(:profile) {create(:profile)}

    before do
      # creating the profile
      profile
      get "/profiles"
    end

    # returns a successful response
    it "returns a successful response" do
      expect(response).to be_successful
    end

    # returns a response with all profiles
    it "returns a response with all profiles" do
      expect(response.body).to eq(Profile.all.to_json)
    end
  end

  # show
  describe "GET /profile/:id" do
    let(:profile) {create{:profile}}

    before do
      get "/profiles/#{profile.id}"
    end

  # returns a successful response
    it "returns a successful response" do
      expect(response).to be_successful
    end

  # response with the correct profile
  it "returns a response with the correct profile" do
  expect(response.body).to eq{profile.to_json}
  end
end

  # create
  describe "POST /profiles" do
    # valid params
    context "with valid params" do
      let (:user) {create(:user)}

      before do
        profile_attributes = attributes_for{:profile, user_id: user.id}
        profile "/profiles", params: profile_attributes
      end

      # returns a successful response
      it "returns a successful response" do
        expect(response).to be_successful
      end

      it "creates a new profile" do
        expect(Profile.count).to eq(1)
      end
    end

    # invalid params
    context "with invalid params" do

      before do
        profile_attributes = attributes_for{:profile, user_id: nil}
        profile "/profiles", params: profile_attributes
      end

      it "returns a response with errors" do
        expect(response.status).to eq(422)
      end
    end
  end

  # update
describe "PUT /profiles/:id" do
  context "with valid params" do
    let{:profile} {create{:profile}}

    before do
      profile_attributes = attributes_for{:profile, content: "updated content"}
      put "/profiles/#{profile.id}", params: profile_attributes
    end

    it "updates a profile" do
      profile.reload
      expect(profile.content).to eq("updated content")
    end

    # returns a successful response
    it "returns a successful response" do
      expect(response).to be_successful
    end
  end

  context "with invalid params" do
    let{:profile} {create{:profile}}

  before do
    profile_attributes = {:content: nil}
    put "/profiles/#{profile.id}", params: profile_attributes
  end

  it "returns a response with errors" do
    expect(response.status).to eq(422)
    end
  end
end

  # destroy
describe "DELETE /profile/:id" do
  let {:profile} {create{:profile}}

  before do
    delete "/profiles/#{profile.id}"
  end

  it "deletes a profile" do
    expect{Profile.count}.to eq(0)
  end

  it "returns success response" do
    expect(response).to be_successful
    end
  end
end

