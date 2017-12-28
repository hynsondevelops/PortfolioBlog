class ContactsController < ApplicationController
	def new

	end

	def create
		@contact = Contact.create(contact_params)
	end

	def show
		if (user_signed_in? == true && current_user.name == "Adam Hynson")
			@contact = Contact.find(params[:id])
		else	
			redirect_to portfolio_path
		end
	end

	def index
		if (user_signed_in? == true && current_user.name == "Adam Hynson")
			@contacts = Contact.all
		else	
			redirect_to portfolio_path
		end
	end

	private

		def contact_params
			params.require(:contact).permit(:name, :email, :description)
		end
end
