class Post < ApplicationRecord
	has_many :tags_to_post
	has_many :tags, through: :tags_to_post
end
