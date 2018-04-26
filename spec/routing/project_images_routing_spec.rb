require "rails_helper"

RSpec.describe ProjectImagesController, type: :routing do
  describe "routing" do

    it "routes to #index" do
      expect(:get => "/project_images").to route_to("project_images#index")
    end

    it "routes to #new" do
      expect(:get => "/project_images/new").to route_to("project_images#new")
    end

    it "routes to #show" do
      expect(:get => "/project_images/1").to route_to("project_images#show", :id => "1")
    end

    it "routes to #edit" do
      expect(:get => "/project_images/1/edit").to route_to("project_images#edit", :id => "1")
    end

    it "routes to #create" do
      expect(:post => "/project_images").to route_to("project_images#create")
    end

    it "routes to #update via PUT" do
      expect(:put => "/project_images/1").to route_to("project_images#update", :id => "1")
    end

    it "routes to #update via PATCH" do
      expect(:patch => "/project_images/1").to route_to("project_images#update", :id => "1")
    end

    it "routes to #destroy" do
      expect(:delete => "/project_images/1").to route_to("project_images#destroy", :id => "1")
    end

  end
end
