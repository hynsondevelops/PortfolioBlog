require 'rails_helper'

RSpec.describe "project_images/index", type: :view do
  before(:each) do
    assign(:project_images, [
      ProjectImage.create!(
        :project_id => 2,
        :image => "Image"
      ),
      ProjectImage.create!(
        :project_id => 2,
        :image => "Image"
      )
    ])
  end

  it "renders a list of project_images" do
    render
    assert_select "tr>td", :text => 2.to_s, :count => 2
    assert_select "tr>td", :text => "Image".to_s, :count => 2
  end
end
