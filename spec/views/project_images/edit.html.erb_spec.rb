require 'rails_helper'

RSpec.describe "project_images/edit", type: :view do
  before(:each) do
    @project_image = assign(:project_image, ProjectImage.create!(
      :project_id => 1,
      :image => "MyString"
    ))
  end

  it "renders the edit project_image form" do
    render

    assert_select "form[action=?][method=?]", project_image_path(@project_image), "post" do

      assert_select "input#project_image_project_id[name=?]", "project_image[project_id]"

      assert_select "input#project_image_image[name=?]", "project_image[image]"
    end
  end
end
