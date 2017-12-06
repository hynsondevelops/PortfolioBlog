class PostsController < ApplicationController
	def portfolio
	end

	def new
		Post.new
		@plain_text = "Type your markdown plain text here."
	end

	def create
		#ADMIN ONLY LOGIC GOES HERE
		@post = Post.create!(content: params[:content])
		redirect_to action: "show", id: @post.id
	end

	def show
		@post = Post.find(params[:id])
		@content = helpers.markdown(@post.content)
	end

	def markdown_helper
		@content = helpers.markdown(params[:content])
		render json: {content: @content}
	end
end
