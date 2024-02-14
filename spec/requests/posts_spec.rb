require 'rails_helper'

RSpec.describe "Posts", type: :request do
  describe "GET /posts" do

    let(:post) {create(:post)}

    before do
      # creating the post
      post
      get "/posts"
    end

    # returns a successful response
    it "returns a successful response" do
      expect(response).to be_successful
    end
    # returns a response with all posts
    it "returns a response with all posts" do
      expect(response.body).to eq(Post.all.to_json)
    end
  end

  # show

  # create

  # update

  # destoy

end
