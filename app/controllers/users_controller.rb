class UsersController < ApplicationController
	before_action :set_s3_direct_post, only: [:edit, :update]


	def posts
		@posts = current_user.posts
	end

	def edit
		@user = User.find(params[:id])
	end

	def update
		@user = User.find(params[:id])
		@user.update_attributes(img: params[:img])
		@user.save
	end

	private

		def set_s3_direct_post
			@s3_direct_post = S3_BUCKET.presigned_post(key: "uploads/#{SecureRandom.uuid}/${filename}", success_action_status: '201', acl: 'public-read')
		end
end
