class PostsController < ApplicationController
	def portfolio
	end

	def new
		@post = Post.new
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
		redirect_to action: "show", title: @post.title
	end

	def edit
		@post = Post.find_by(title: params[:title])
		@plain_text = @post.content
		@update_url = "/posts/#{helpers.URLSpaces(@post.title)}"
	end

	def update
		@post = Post.find(params[:id])
		@post.update_attributes(title: params[:title], content:params[:content])
		tag_names = params[:tags].split(" ")
		tag_names.each do |tag_name|
			tag = Tag.find_by(name: tag_name)
			TagsToPost.create(post_id: @post.id, tag_id: tag.id)
		end
		redirect_to action: "show", title: @post.title
	end

	def show
		@post = Post.find_by(title: params[:title])
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
