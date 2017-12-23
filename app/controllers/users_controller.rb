class UsersController < ApplicationController
	def posts
		@posts = current_user.posts
	end
end
