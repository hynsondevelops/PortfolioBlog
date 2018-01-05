class TagsController < ApplicationController
	def create
		@tag = Tag.new(name: params[:tag_name])
		if (@tag.valid?)
			@tag.save
		else
			@tag = Tag.find_by(name: params[:tag_name])
		end
	end

	def show
		@tag = Tag.find_by(name: params[:name])
		if (@tag != nil)
			@posts = @tag.posts.where(draft: false)
		else
			redirect_to posts_path
		end
	end
end
