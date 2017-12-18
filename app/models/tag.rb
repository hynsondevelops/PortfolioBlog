class Tag < ApplicationRecord
	has_many :tags_to_post
	has_many :posts, through: :tags_to_post

	validates :name, uniqueness: { case_sensitive: false }
end
