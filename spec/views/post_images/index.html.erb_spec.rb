require 'rails_helper'

RSpec.describe "post_images/index", type: :view do
  before(:each) do
    assign(:post_images, [
      PostImage.create!(
        :post_id => 2,
        :image => "Image"
      ),
      PostImage.create!(
        :post_id => 2,
        :image => "Image"
      )
    ])
  end

  it "renders a list of post_images" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
  end
end
