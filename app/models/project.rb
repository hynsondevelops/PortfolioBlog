class Project < ApplicationRecord
	has_many :images
	has_one :author, class_name: "User"
	has_many :project_images
	accepts_nested_attributes_for :project_images
end
