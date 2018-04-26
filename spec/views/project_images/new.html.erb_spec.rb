require 'rails_helper'

RSpec.describe "project_images/new", type: :view do
  before(:each) do
    assign(:project_image, ProjectImage.new(
      :project_id => 1,
      :image => "MyString"
    ))
  end

  it "renders new project_image form" do
    render

    assert_select "form[action=?][method=?]", project_images_path, "post" do

      assert_select "input#project_image_project_id[name=?]", "project_image[project_id]"

      assert_select "input#project_image_image[name=?]", "project_image[image]"
    end
  end
end
