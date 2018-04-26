require 'rails_helper'

RSpec.describe "post_images/show", type: :view do
  before(:each) do
    @post_image = assign(:post_image, PostImage.create!(
      :post_id => 2,
      :image => "Image"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Image/)
  end
end
