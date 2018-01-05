class PostsController < ApplicationController

	before_action :set_s3_direct_post, only: [:new]

	def portfolio
	end

	def new
		if (user_signed_in?)
			@post = Post.new
			@plain_text = "Type your markdown plain text here."
		else
			redirect_to action: "index"
		end
	end

	def create
		#ADMIN ONLY LOGIC GOES HERE
		if (user_signed_in?)
			@post = Post.create!(author: current_user, content: params[:content], title: params[:title])
			if (params[:tags] != nil)
				tag_names = params[:tags].split(" ")
				tag_names.each do |tag_name|
					tag = Tag.find_by(name: tag_name)
					TagsToPost.create(post_id: @post.id, tag_id: tag.id)
				end
			end
			redirect_to action: "show", title: @post.title
		end
	end

	def edit
		@post = Post.find_by(title: params[:title])
		if (user_signed_in?)
			@plain_text = @post.content
			@update_url = "/posts/#{helpers.URLSpaces(@post.title)}"
			if (current_user.id != @post.author.id)
				flash[:alert] = 'Error while sending message!'
				redirect_to action: "show", title: @post.title
			end
		else
			flash[:alert] = 'Error while sending message!'
			redirect_to action: "show", title: @post.title
		end
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
		@post = Post.find_by(title: params[:title], draft: false)
		if (@post != nil)
			@content = helpers.markdown(@post.content)
			tag_ids = []
			@post.tags.each do |tag|
				tag_ids.push(tag.id)
			end
			@related_posts = Set.new
			tag_ids.size.downto(0) do |i|
				tags = tag_ids[0...i]
				posts = Post.includes(:tags).where(:id => tags)
				posts.each do |post|
					@related_posts.add(post)
				end
			end
		else
			redirect_to action: "index"
		end
	end

	def index
		@posts = Post.order('created_at DESC').where(draft: false)
	end

	def markdown_helper
		@content = helpers.markdown(params[:content])
		render json: {content: @content}
	end

	private

		def set_s3_direct_post
			@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
		end

end
