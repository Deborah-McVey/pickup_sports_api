require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  describe "POST /login" do
    let(:user) { create(:user) }

    it 'authenticate the user and returns a success response' do
      post "/login", params { user_name}
      expect(response).to have_http_status(:success)
    end
  end

end
