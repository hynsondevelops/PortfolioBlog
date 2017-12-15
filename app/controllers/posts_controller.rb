class PostsController < ApplicationController
	def portfolio
	end

	def new
		Post.new
		@plain_text = "Type your markdown plain text here."
	end

	def create
		#ADMIN ONLY LOGIC GOES HERE
		tag_names = params[:tags].split(" ")
		@post = Post.create!(content: params[:content], title: params[:title])
		tag_names.each do |tag_name|
			tag = Tag.find_by(name: tag_name)
			TagsToPost.create(post_id: @post.id, tag_id: tag.id)
		end
		redirect_to action: "show", id: @post.id
	end

	def show
		@post = Post.find(params[:id])
		@content = helpers.markdown(@post.content)
	end

	def index
		@posts = Post.order('created_at DESC')
	end

	def markdown_helper
		@content = helpers.markdown(params[:content])
		render json: {content: @content}
	end
end
