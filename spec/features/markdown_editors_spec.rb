require 'rails_helper'

RSpec.feature "MarkdownEditors", type: :feature do

	context 'Logged out new' do
	  scenario "Requires being logged_in" do
	      visit "/posts"

	      expect(page).not_to have_text("New Post")

	  end

	end

	context 'Logged in new' do 

		before (:all) do
			
	    	@user = FactoryBot.create( :user )
		end

		before(:each) do
			visit "/users/sign_in"
			page.fill_in 'user_email', :with => @user.email
			page.fill_in 'user_password', :with => @user.password
			click_button 'Log in'
			visit "/posts/new"
			fill_in 'title', :with => "Title"
		end

		scenario "Updates on each character entered", js:true do
			fill_in 'content', :with => "##Hello\n"
			keypress = "var e = $.Event('keydown', { keyCode: 13 }); $('content').trigger(e);"
			page.driver.execute_script(keypress)
			expect(page).to have_selector('h2', text: "Hello")
		end

	  scenario "Supports Headers", js:true do
	  	fill_in 'content', :with => "#Header\n"
	  	keypress = "var e = $.Event('keydown', { keyCode: 13 }); $('content').trigger(e);"
	  	page.driver.execute_script(keypress)
	  	expect(page).to have_selector('h1', text: "Header")
	  end

	  scenario "Supports Emphasis", js:true do
	  	fill_in 'content', :with => "**Emphasis**\n"
		keypress = "var e = $.Event('keydown', { keyCode: 13 }); $('content').trigger(e);"
	  	page.driver.execute_script(keypress)
	  	expect(page).to have_selector('strong', text: "Emphasis")
	  end

	  scenario "Supports Lists", js:true do
	  	fill_in 'content', :with => "1. First\n2. Second\n"
	  	keypress = "var e = $.Event('keydown', { keyCode: 13 }); $('content').trigger(e);"
	  	page.driver.execute_script(keypress)
	  	expect(page).to have_selector('li', text: "First")
	  end

	  scenario "Supports Links", js:true do
	  	fill_in 'content', :with => "[Link](https://www.google.com)"
	  	keypress = "updateMarkdown();"
	  	page.driver.execute_script(keypress)
	  	expect(page).to have_link("Link", :href => "https://www.google.com")
	  end

	  scenario "Supports Images with Local Image Upload", js:true do
	  	attach_file("img", Rails.root + "app/assets/images/ChessStart.png")
	  	click_button "Add Image"
	  	keypress = "updateMarkdown();"
	  	page.driver.execute_script(keypress)
	  	expect(page).to have_selector('img')
	  end

	   scenario "Supports Code Blocks", js:true do
	  	fill_in 'content', :with => "\n```\nCode\n```"
	  	keypress = "updateMarkdown();"
	  	page.driver.execute_script(keypress)
	  	expect(page).to have_selector('pre')
	  end

	   scenario "Supports Syntax Highlighting", js:true do
	  	fill_in 'content', :with => "\n```js\nvar a = 1;\n```"
	  	keypress = "updateMarkdown();"
	  	page.driver.execute_script(keypress)
	  	expect(page).to have_selector("span", class: "kd")
	  end

	  scenario "Supports Tables", js:true do
	  	fill_in 'content', :with => "\n| I | am | a | Table |\n| --- | --- | --- | ---|\n| 1 | 2 | 3 | 4 |\n"
	  	keypress = "updateMarkdown();"
	  	page.driver.execute_script(keypress)
	  	expect(page).to have_selector("table")
	  end

	  scenario "Supports Blockquotes", js:true do
	  	fill_in 'content', :with => "\n>Quote\n"
	  	keypress = "updateMarkdown();"
	  	page.driver.execute_script(keypress)
	  	expect(page).to have_selector("blockquote")
	  end

	  scenario "Allows post creation", js:true do
	  	fill_in 'content', :with => "#Header\n"
	  	click_button 'Create Post'
	  	expect(page).to have_selector('h1', text: "Header")

	  end
	end

	context 'Logged out edit' do
	  scenario "Requires being logged_in" do
	      visit "/posts/Title/edit"
	      expect(current_path).to eq '/posts/Title'
	  end
	end

	context 'Logged in edit' do 

		before (:all) do
			
	    	@user = FactoryBot.build( :user )
		end

		before(:each) do
			visit "/users/sign_in"
			page.fill_in 'user_email', :with => @user.email
			page.fill_in 'user_password', :with => @user.password
			click_button 'Log in'
			visit "/posts/Title/edit"
		end

		scenario "Updates on each character entered", js:true do
			fill_in 'content', :with => "##Hello\n"
			keypress = "var e = $.Event('keydown', { keyCode: 13 }); $('content').trigger(e);"
			page.driver.execute_script(keypress)
			expect(page).to have_selector('h2', text: "Hello")
		end

	  scenario "Supports Headers", js:true do
	  	fill_in 'content', :with => "#Header\n"
	  	keypress = "updateMarkdown();"
	  	page.driver.execute_script(keypress)
	  	expect(page).to have_selector('h1', text: "Header")
	  end

	  scenario "Supports Emphasis", js:true do
	  	fill_in 'content', :with => "**Emphasis**\n"
		keypress = "var e = $.Event('keydown', { keyCode: 13 }); $('content').trigger(e);"
	  	page.driver.execute_script(keypress)
	  	expect(page).to have_selector('strong', text: "Emphasis")
	  end

	  scenario "Supports Lists", js:true do
	  	fill_in 'content', :with => "1. First\n2. Second\n"
	  	keypress = "var e = $.Event('keydown', { keyCode: 13 }); $('content').trigger(e);"
	  	page.driver.execute_script(keypress)
	  	expect(page).to have_selector('li', text: "First")
	  end

	  scenario "Supports Links", js:true do
	  	fill_in 'content', :with => "\n[Link](https://www.google.com)\n"
	  	keypress = "updateMarkdown();"
	  	page.driver.execute_script(keypress)
	  	expect(page).to have_link("Link", :href => "https://www.google.com")
	  end

	  scenario "Supports Images with Local Image Upload", js:true do
	  	attach_file("img", Rails.root + "app/assets/images/ChessStart.png")
	  	click_button "Add Image"
	  	keypress = "updateMarkdown();"
	  	page.driver.execute_script(keypress)
	  	expect(page).to have_selector('img')
	  end

	   scenario "Supports Code Blocks", js:true do
	  	fill_in 'content', :with => "\n```\nCode\n```"
	  	keypress = "updateMarkdown();"
	  	page.driver.execute_script(keypress)
	  	expect(page).to have_selector('pre')
	  end

	   scenario "Supports Syntax Highlighting", js:true do
	  	fill_in 'content', :with => "\n```js\nvar a = 1;\n```"
	  	keypress = "updateMarkdown();"
	  	page.driver.execute_script(keypress)
	  	expect(page).to have_selector("span", class: "kd")
	  end

	  scenario "Supports Tables", js:true do
	  	fill_in 'content', :with => "\n| I | am | a | Table |\n| --- | --- | --- | ---|\n| 1 | 2 | 3 | 4 |\n"
	  	keypress = "updateMarkdown();"
	  	page.driver.execute_script(keypress)
	  	expect(page).to have_selector("table")
	  end

	  scenario "Supports Blockquotes", js:true do
	  	fill_in 'content', :with => "\n>Quote\n"
	  	keypress = "updateMarkdown();"
	  	page.driver.execute_script(keypress)
	  	expect(page).to have_selector("blockquote")
	  end

	  scenario "Allows post updates", js:true do
	  	fill_in 'content', :with => "#Header\n"
	  	click_button 'Create Post'
	  	expect(page).to have_selector('h1', text: "Header")

	  end
	end
end

