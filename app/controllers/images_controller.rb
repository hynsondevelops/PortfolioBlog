class ImagesController < ApplicationController
	def new
		Image.new
	end

	def create
		print(params[:img])
		@image = Image.new(img: params[:img])
		print("Below")
		print(@image.img_file_name)
		print("Above")
		if (@image.valid?)
			@image.save
		else
			print(params[:img])
			@image = Image.find_by(img_file_name: params[:img].original_filename)
		end
		markdown_string = "![#{params[:alt_text]}](#{@image.img.url('large')})"
		@plain_text = params[:image_content] + markdown_string
		render 'posts/new'
	end

	def markdownURL
		@image = Image.find_by(img_file_name: params[:name])
		markdown_string = "![text](#{@image.img.url})"
		render json: {url: markdown_string}
	end


	def show
		@image = Image.find(params[:id])
	end

end
