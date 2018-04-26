require 'rails_helper'

RSpec.describe "post_images/new", type: :view do
  before(:each) do
    assign(:post_image, PostImage.new(
      :post_id => 1,
      :image => "MyString"
    ))
  end

  it "renders new post_image form" do
    render

    assert_select "form[action=?][method=?]", post_images_path, "post" do

      assert_select "input#post_image_post_id[name=?]", "post_image[post_id]"

      assert_select "input#post_image_image[name=?]", "post_image[image]"
    end
  end
end
