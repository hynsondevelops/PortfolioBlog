require 'rails_helper'

RSpec.describe "PostImages", type: :request do
  describe "GET /post_images" do
    it "works! (now write some real specs)" do
      get post_images_path
      expect(response).to have_http_status(200)
    end
  end
end
