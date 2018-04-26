require 'rails_helper'

RSpec.describe "project_images/show", type: :view do
  before(:each) do
    @project_image = assign(:project_image, ProjectImage.create!(
      :project_id => 2,
      :image => "Image"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/Image/)
  end
end
