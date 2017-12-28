class ContactsController < ApplicationController
	def new

	end

	def create
		@contact = Contact.create(contact_params)
	end

	private

		def contact_params
			params.require(:contact).permit(:name, :email, :description)
		end
end
