class PostsController < ApplicationController
	def portfolio
	end

	def new
		Post.new
		@plain_text = "Type your markdown plain text here."
		@content = "Markdown converted to HTML here."
	end

	def create
		#ADMIN ONLY LOGIC GOES HERE

	end

	def render_markdown
		@plain_text = params[:content]
		@content = helpers.markdown(params[:content])
		render 'new'
	end
end
