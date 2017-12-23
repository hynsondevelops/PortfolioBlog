class Project < ApplicationRecord
	has_many :images
	has_one :author, class_name: "User"
end
