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
		@posts = Post.order('created_at DESC')[0..3]
		@chess = Project.find_by(name: "Chess")
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
	   @project = Project.create(project_params)
   	   if (@project.save)
  			if params[:images]
  			  #===== The magic is here ;)
  			  params[:images].each { |image|
  			    cur_image = Image.create(img: image, project_id: @project.id)
  			    if (cur_image.valid?)
	  			    @project.images.push(cur_image)
	  			    @project.save
	  			else
	  				prev_img = Image.find_by(img_file_name: image.original_filename)
	  				prev_img.project_id = @project.id
	  				if (prev_img.save)
	  					@project.images.push(prev_img)
	  				end
	  			end
  			  }
  			end
  			# Handle a successful save.
  			#@project.send_activation_email
  			flash[:info] = "project created!"
  			redirect_to action: "show", id: @project.id
  		else
  			render 'new'
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
	  params[:project].permit(:name, :description, :github, :live_link, :personal_or_work, :author_id)
	end

end
