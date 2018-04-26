class ProjectsController < ApplicationController
	before_action :authenticate, except: [:index, :show, :portfolio]

	def authenticate
		if (user_signed_in?)
			if (current_user.email != "hynsondevelops@gmail.com")
				redirect_to action: "index"
			end
		else
			redirect_to action: "index"
		end
	end

	def portfolio
		@user = User.find_by(name: "Adam Hynson")
		@posts = Post.order('created_at DESC')[0..2]
		@snacker_tracker = Project.find_by(name: "Snacker Tracker")
		@real_estate = Project.find_by(name: "Real Estate App")
		@tutoring = Project.find_by(name: "Tutoring Business")
		@contact = Contact.new
	end

	def index
		@projects = Project.all
	end

	def show
	   @project = Project.find(params[:id])
	end

	def new
	   @project = Project.new 
	end

	def edit
	   @project
	end

	def create
	   @project = Project.new(project_params)
   	   respond_to do |format|
   	        if @project.save
   	          params[:project_images]['image'].each do |a|
   	             @project_attachment = @project.project_images.create!(:image => a)
   	          end
   	          format.html { redirect_to @project, notice: 'Post was successfully created.' }
   	        else
   	          format.html { render action: 'new' }
   	        end
   	      end
	end

	def update
	  @project.update(project_params)

	   @project
	end

	def destroy
	  # Destroy returns the object (i.e. self); though I believe Mongoid returns a boolean - need to double check this
	  @project.destroy
	  
	   @project.destroy
	end


	private

	def project_params
	  params[:project].permit(:name, :description, :github, :live_link, :personal_or_work, :author_id, :image)
	end

end
