require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    let(:user) {create(:user)}
    let(:token) { auth_token_for_user(:user) }

    before do
      # creating the user
      user
      get "/users/#{user.id}", 
      headers: { Authorization: "Bearer #{token}" }
    end

    # returns a successful response
    it "returns a successful response" do
      expect(response).to be_successful
    end

    # return a response with all the users
    it "returns a response with all the users" do
      expect(response.body).to eq(User.all.to_json)
    end
  end
end
