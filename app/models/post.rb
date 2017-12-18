class Post < ApplicationRecord
	def to_param
		title
	end

	validates :title, uniqueness: true
	has_many :tags_to_post
	has_many :tags, through: :tags_to_post
end
