require 'rails_helper'

RSpec.describe "post_images/edit", type: :view do
  before(:each) do
    @post_image = assign(:post_image, PostImage.create!(
      :post_id => 1,
      :image => "MyString"
    ))
  end

  it "renders the edit post_image form" do
    render

    assert_select "form[action=?][method=?]", post_image_path(@post_image), "post" do

      assert_select "input#post_image_post_id[name=?]", "post_image[post_id]"

      assert_select "input#post_image_image[name=?]", "post_image[image]"
    end
  end
end
