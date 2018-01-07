include ActionDispatch::TestProcess

FactoryBot.define do

	sequence :img_file_name do |n|
	   "file_#{n}"
	end

	factory :image do
		img { fixture_file_upload(Rails.root.join('spec', 'photos', 'test.png'), 'image/png') }
		after :build do |factory|
	      factory.img_file_name = FactoryBot.generate(:img_file_name)
	    end

	end


	  factory :chess, class: "Project" do
	  	name "Chess"
	  	description "OOP approach to implementing Chess with Ruby on the command line. Allows for all rules of chess including castling and en passant."
	  	personal_or_work true
	  	github "https://github.com/hynsondevelops/Chess"
	  	live_link "https://github.com/hynsondevelops/Chess"
	  	after :build do |factory|
	  		test_image = FactoryBot.create(:image)
	  		factory.images = [test_image]
	  	end
	  end


	  factory :real_estate, class: "Project" do
	  	name "Real Estate App"
	  	description "A real estate listing application similar to Zillow.com or Realtor.com. Uses Ruby on Rails with a Postgresql database and Bootstrap styling. Database includes information on al fifty United States including over X zipcodes and Y cities. Allows for listing for rent or sale with a user profile that allows email communication."
	  	personal_or_work true
	  	github "https://github.com/hynsondevelops/RealEstateApp"
	  	live_link "https://stormy-bayou-53826.herokuapp.com"
	  	after :build do |factory|
	  		test_image = FactoryBot.create(:image)
	  		factory.images = [test_image]
	  	end
	  end

	  factory :tutoring, class: "Project" do
	  	name "Tutoring Business"
	  	description "A spanish tutoring business contact page. Fully responsive design."
	  	personal_or_work true
	  	github "https://github.com/hynsondevelops/TutoringPage"
	  	live_link "http://hynsontutoring.services"
	  	after :build do |factory|
	  		test_image = FactoryBot.create(:image)
	  		factory.images = [test_image]
	  	end
	  end

	factory :user do
		name "Adam Hynson"
		github "https://github.com/hynsondevelops"
		email "hynsondevelops@gmail.com"
		password "password"
		img { fixture_file_upload(Rails.root.join('app', 'assets', 'images', 'ProfessionalPortraitCrop.png'), 'image/png') }

	end
end
	