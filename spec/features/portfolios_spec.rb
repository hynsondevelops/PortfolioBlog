require 'rails_helper'

RSpec.feature "Portfolios", type: :feature do

	User.all.each do |u|
		u.delete
	end
	Project.all.each do |u|
		u.delete
	end
	Image.all.each do |u|
		u.delete
	end

	@user = FactoryBot.create(:user)
	@image= FactoryBot.create(:image)
	@chess = FactoryBot.create(:chess)
	@real_estate = FactoryBot.create(:real_estate)
	@tutoring = FactoryBot.create(:tutoring)
	context "Creating a Project" do
		scenario "Must be signed in as user with email hynsondevelops@gmail to make projects" do

		end

		scenario "No other users can make projects" do

		end

		scenario "Can add images to projects" do

		end
	end


	context "Editing a Project" do
		scenario "Must be signed in as user with email hynsondevelops@gmail to edit projects" do

		end

		scenario "No other users can edit projects" do

		end
	end

	context "Allows contacting me" do

		scenario "Anyone can open contact form modal", js:true do
			visit "/portfolio"

			print(html.include?("style='display: block;'"))
			modal = page.all(:css, '#myModal')
			page.all(:css, '#contact-button').each do |el|
			    el.click
			end

			puts html
			page.all(:css, '#myModal').each do |el|
			    puts el.innerHTML
			end
			#expect(modal.style).to eq("display: block;")

		end

		scenario "Anyone can submit contact" do

		end

	end
end
