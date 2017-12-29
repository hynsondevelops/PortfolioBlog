# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#User
user = User.create!(:name => 'Adam Hynson', :github => "https://github.com/hynsondevelops/", :description => "I'm a junior Ruby on Rails developer. It's important to me to build long term relationships with clients I look forward to hearing from you!", :email => 'hynsondevelops@gmail.com', :password => ENV["user_password"], :password_confirmation => ENV["user_password"])



#Tags
Tag.create!(name: "Rails")
Tag.create!(name: "Ruby")
Tag.create!(name: "HTML/CSS")
Tag.create!(name: "Javascript")

post1_JSON = "{\"id\":1,\"content\":\"This tutorial will show how to make a Markdown editor within a Ruby on Rails application. The tutorial assumes knowledge of basic Ruby on Rails and Javascript.\\n\\n###Languages\\nRails 5.0.6\\nRuby 2.3.0\\nJavascript\\n\\n###Setup\\nStart by making a new Rails app,\\n\\n```\\n$ rails new AppName\\n```\\nwhere AppName is your choice of name for your Rails application.\\n\\n###Gems\\nGemfile\\n\\n```ruby\\n#for styling\\ngem 'bootstrap-sass', '3.3.6'\\n#for navbar\\ngem 'rails_bootstrap_navbar'\\n#for markdown to html\\ngem 'redcarpet', '~\\u003e 3.0.0'\\n#for images\\ngem 'paperclip', '~\\u003e 5.0.0'\\n```\\n```\\nbundle install\\n```\\n###Creating a Post Model\\n```\\n$ rails g model Post content:text title:text\\n```\\nThe post model has a text field, content, that saves our Markdown that we generate from our editor. For now, the only other field is a title.\\n\\n###Creating a Post Controller\\n```\\n$ rails g controller Posts\\n```\\n**app/controllers/posts_controller.rb**\\n\\n```ruby\\nclass PostsController \\u003c ApplicationController\\n    def new\\n        Post.new\\n        @plain_text = 'Type your markdown plain text here.'\\n    end\\nend\\n```\\nThe variable, @plain_text, will be used as default text for the plain-text input text field.\\n\\n###Routing\\n**config/routes.rb**\\n\\n```ruby\\nRails.application.routes.draw do\\n  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html\\n  resources :posts\\nend\\n```\\n###Creating a New Post View\\n**app/views/posts/new.html.erb**\\n\\n```erb\\n\\u003cdiv class='container-fluid'\\u003e\\n    \\u003cdiv class='row'\\u003e\\n        \\u003c%= form_tag('/posts', id: 'plain-text-form') do%\\u003e\\n         \\u003c%= text_area_tag('content', @plain_text, class: 'col-xs-4 col-sm-4 col-md-4 col-lg-4 plain-text') %\\u003e\\n                 \\u003c% end %\\u003e\\n        \\u003cdiv class='col-xs-8 col-sm-8 col-md-8 col-lg-8 markdown-html'\\u003e\\n        \\u003c/div\\u003e\\n    \\u003c/div\\u003e\\n\\u003c/div\\u003e\\n```\\n**app/assets/stylesheets/application.scss**\\n\\n```scss\\n/*\\n * This is a manifest file that'll be compiled into application.css, which will include all the files\\n * listed below.\\n *\\n * Any CSS and SCSS file within this directory, lib/assets/stylesheets, vendor/assets/stylesheets,\\n * or any plugin's vendor/assets/stylesheets directory can be referenced here using a relative path.\\n *\\n * You're free to add application-wide styles to this file and they'll appear at the bottom of the\\n * compiled file so the styles you add here take precedence over styles defined in any other CSS/SCSS\\n * files in this directory. Styles in this file should be added after the last require_* statement.\\n * It is generally better to create a new file per style scope.\\n *\\n *= require_tree .\\n *= require_self\\n */\\n\\n$icon-font-path: 'bootstrap/';\\n\\n@import 'bootstrap';\\n$markdown-editor-height: 800px;\\n\\n.plain-text\\n{\\n    border: 1px solid black;\\n    min-height: $markdown-editor-height;\\n    height: auto;\\n}\\n\\n.markdown-html\\n{\\n    border: 1px solid black;\\n    min-height: $markdown-editor-height;\\n    height: auto;\\n}\\n```\\n\\n![](/system/images/imgs/000/000/001/large/test.png?1513566640)\\n\\nThis view will serve as the front end of our Markdown editor. The left side text box is for entering plain text that will be converted to Markdown while the right side will show the converted Markdown HTML view.\\n\\n###Redcarpet\\n[Redcarpet on Github](https://github.com/vmg/redcarpet/tree/master/lib/redcarpet)\\nRedcarpet is a gem that allows Markdown parsing. Our editor will use the Redcarpet to make a markdown helper function that takes text and returns the rendered Markdown.\\n\\n**app/helpers/application_helper.rb**\\n\\n```ruby\\nmodule ApplicationHelper\\n\\n    def markdown(text)\\n        options = {\\n          filter_html:     true,\\n          hard_wrap:       true,\\n          link_attributes: { rel: 'nofollow', target: '_blank' },\\n          space_after_headers: true,\\n          fenced_code_blocks: true\\n        }\\n\\n        extensions = {\\n          autolink:           true,\\n          superscript:        true,\\n          disable_indented_code_blocks: true,\\n          fenced_code_blocks: true,\\n          tables: true\\n        }\\n\\n        renderer = Redcarpet::Render::HTML.new(options)\\n\\n        markdown = Redcarpet::Markdown.new(renderer, extensions)\\n\\n        markdown.render(text).html_safe\\n    end\\nend\\n```\\nOur function is written in the application helper so it can be used across the whole application. The options and extensions are a set of flags that can be enabled or disabled and are further detailed on the Redcarpet Github page. Now we can call helpers.markdown(text) to convert text to Markdown throughout our application.\\n\\n###Post Controller Method for Parsing\\n**app/controllers/posts_controller.rb**\\n\\n```ruby\\nclass PostsController \\u003c ApplicationController\\n    def new\\n        Post.new\\n        @plain_text = 'Type your markdown plain text here.'\\n    end\\n\\n    def markdown_helper\\n        @content = helpers.markdown(params[:content])\\n        render json: {content: @content}\\n    end\\nend\\n```\\nThe markdown_helper method will used by a JSON AJAX call.\\n\\n###Real Time Updating\\nIn order to allow the user to type in text and see Markdown update we will need Javascript.\\n\\n```javascript\\n// This is a manifest file that'll be compiled into application.js, which will include all the files\\n// listed below.\\n//\\n// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,\\n// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.\\n//\\n// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the\\n// compiled file. JavaScript code in this file should be added after the last require_* statement.\\n//\\n// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details\\n// about supported directives.\\n//\\n//= require jquery\\n//= require jquery_ujs\\n//= require turbolinks\\n//= require_tree .\\n\\n\\nfunction updateMarkdown()\\n{\\n    var plain_text = document.getElementById('content').value;\\n    var markdown_box = document.getElementsByClassName('markdown-html')[0];//there is only ever one element with this classname\\n    var markdown = '';\\n    $.ajax({\\n        type: 'GET',\\n        url: '/markdown',\\n        data: { \\n            content: plain_text\\n        },\\n        dataType: 'json',\\n        success: function(data){\\n            markdown_box.innerHTML = data.content\\n        }        \\n    });\\n};\\n```\\nNow we have a function that when called will update the right side with a rendered Markdown view. To make the Markdown update with each new character typed we can onkeyup of our plain text box call the function.\\n\\n**app/views/posts/new.html.erb**\\n\\n```erb\\n\\u003cdiv class='container-fluid'\\u003e\\n    \\u003cdiv class='row'\\u003e\\n        \\u003c%= form_tag('/posts', id: 'plain-text-form') do%\\u003e\\n         \\u003c%= text_area_tag('content', @plain_text, class: 'col-xs-4 col-sm-4 col-md-4 col-lg-4 plain-text', onkeyup: 'updateMarkdown();') %\\u003e\\n                 \\u003c% end %\\u003e\\n        \\u003cdiv class='col-xs-8 col-sm-8 col-md-8 col-lg-8 markdown-html'\\u003e\\n        \\u003c/div\\u003e\\n    \\u003c/div\\u003e\\n\\u003c/div\\u003e\\n```\\n\\n![](/system/images/imgs/000/000/002/large/editor_2.png?1513566651)\\n\\nAt this point we have achieved a basic Markdown editor. To improve the editor we will add file uploading and a tagging system in the next post.\",\"title\":\"Markdown Editor\",\"author_id\":1,\"created_at\":\"2017-12-26T01:30:14.951Z\",\"updated_at\":\"2017-12-29T02:33:49.389Z\",\"img_file_name\":null,\"img_content_type\":null,\"img_file_size\":null,\"img_updated_at\":null}"

Post.create!(JSON.parse(post1_JSON))

# Post.create!(content: "This tutorial will show how to make a Markdown editor within a Ruby on Rails application. The tutorial assumes knowledge of basic Ruby on Rails and Javascript.

# ###Languages
# Rails 5.0.6
# Ruby 2.3.0
# Javascript

# ###Setup
# Start by making a new Rails app,

# ```
# $ rails new AppName
# ```
# where AppName is your choice of name for your Rails application.

# ###Gems
# Gemfile

# ```ruby
# #for styling
# gem 'bootstrap-sass', '3.3.6'
# #for navbar
# gem 'rails_bootstrap_navbar'
# #for markdown to html
# gem 'redcarpet', '~> 3.0.0'
# #for images
# gem 'paperclip', '~> 5.0.0'
# ```
# ```
# bundle install
# ```
# ###Creating a Post Model
# ```
# $ rails g model Post content:text title:text
# ```
# The post model has a text field, content, that saves our Markdown that we generate from our editor. For now, the only other field is a title.

# ###Creating a Post Controller
# ```
# $ rails g controller Posts
# ```
# **app/controllers/posts_controller.rb**

# ```ruby
# class PostsController < ApplicationController
#     def new
#         Post.new
#         @plain_text = 'Type your markdown plain text here.'
#     end
# end
# ```
# The variable, @plain_text, will be used as default text for the plain-text input text field.

# ###Routing
# **config/routes.rb**

# ```ruby
# Rails.application.routes.draw do
#   # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
#   resources :posts
# end
# ```
# ###Creating a New Post View
# **app/views/posts/new.html.erb**

# ```erb
# <div class='container-fluid'>
#     <div class='row'>
#         <%= form_tag('/posts', id: 'plain-text-form') do%>
#          <%= text_area_tag('content', @plain_text, class: 'col-xs-4 col-sm-4 col-md-4 col-lg-4 plain-text') %>
#                  <% end %>
#         <div class='col-xs-8 col-sm-8 col-md-8 col-lg-8 markdown-html'>
#         </div>
#     </div>
# </div>
# ```
# **app/assets/stylesheets/application.scss**

# ```scss
# /*
#  * This is a manifest file that'll be compiled into application.css, which will include all the files
#  * listed below.
#  *
#  * Any CSS and SCSS file within this directory, lib/assets/stylesheets, vendor/assets/stylesheets,
#  * or any plugin's vendor/assets/stylesheets directory can be referenced here using a relative path.
#  *
#  * You're free to add application-wide styles to this file and they'll appear at the bottom of the
#  * compiled file so the styles you add here take precedence over styles defined in any other CSS/SCSS
#  * files in this directory. Styles in this file should be added after the last require_* statement.
#  * It is generally better to create a new file per style scope.
#  *
#  *= require_tree .
#  *= require_self
#  */

# $icon-font-path: 'bootstrap/';

# @import 'bootstrap';
# $markdown-editor-height: 800px;

# .plain-text
# {
#     border: 1px solid black;
#     min-height: $markdown-editor-height;
#     height: auto;
# }

# .markdown-html
# {
#     border: 1px solid black;
#     min-height: $markdown-editor-height;
#     height: auto;
# }
# ```

# ![](/system/images/imgs/000/000/001/large/test.png?1513566640)

# This view will serve as the front end of our Markdown editor. The left side text box is for entering plain text that will be converted to Markdown while the right side will show the converted Markdown HTML view.

# ###Redcarpet
# [Redcarpet on Github](https://github.com/vmg/redcarpet/tree/master/lib/redcarpet)
# Redcarpet is a gem that allows Markdown parsing. Our editor will use the Redcarpet to make a markdown helper function that takes text and returns the rendered Markdown.

# **app/helpers/application_helper.rb**

# ```ruby
# module ApplicationHelper

#     def markdown(text)
#         options = {
#           filter_html:     true,
#           hard_wrap:       true,
#           link_attributes: { rel: 'nofollow', target: '_blank' },
#           space_after_headers: true,
#           fenced_code_blocks: true
#         }

#         extensions = {
#           autolink:           true,
#           superscript:        true,
#           disable_indented_code_blocks: true,
#           fenced_code_blocks: true,
#           tables: true
#         }

#         renderer = Redcarpet::Render::HTML.new(options)

#         markdown = Redcarpet::Markdown.new(renderer, extensions)

#         markdown.render(text).html_safe
#     end
# end
# ```
# Our function is written in the application helper so it can be used across the whole application. The options and extensions are a set of flags that can be enabled or disabled and are further detailed on the Redcarpet Github page. Now we can call helpers.markdown(text) to convert text to Markdown throughout our application.

# ###Post Controller Method for Parsing
# **app/controllers/posts_controller.rb**

# ```ruby
# class PostsController < ApplicationController
#     def new
#         Post.new
#         @plain_text = 'Type your markdown plain text here.'
#     end

#     def markdown_helper
#         @content = helpers.markdown(params[:content])
#         render json: {content: @content}
#     end
# end
# ```
# The markdown_helper method will used by a JSON AJAX call.

# ###Real Time Updating
# In order to allow the user to type in text and see Markdown update we will need Javascript.

# ```javascript
# // This is a manifest file that'll be compiled into application.js, which will include all the files
# // listed below.
# //
# // Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
# // or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
# //
# // It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
# // compiled file. JavaScript code in this file should be added after the last require_* statement.
# //
# // Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
# // about supported directives.
# //
# //= require jquery
# //= require jquery_ujs
# //= require turbolinks
# //= require_tree .


# function updateMarkdown()
# {
#     var plain_text = document.getElementById('content').value;
#     var markdown_box = document.getElementsByClassName('markdown-html')[0];//there is only ever one element with this classname
#     var markdown = '';
#     $.ajax({
#         type: 'GET',
#         url: '/markdown',
#         data: { 
#             content: plain_text
#         },
#         dataType: 'json',
#         success: function(data){
#             markdown_box.innerHTML = data.content
#         }        
#     });
# };
# ```
# Now we have a function that when called will update the right side with a rendered Markdown view. To make the Markdown update with each new character typed we can onkeyup of our plain text box call the function.

# **app/views/posts/new.html.erb**

# ```erb
# <div class='container-fluid'>
#     <div class='row'>
#         <%= form_tag('/posts', id: 'plain-text-form') do%>
#          <%= text_area_tag('content', @plain_text, class: 'col-xs-4 col-sm-4 col-md-4 col-lg-4 plain-text', onkeyup: 'updateMarkdown();') %>
#                  <% end %>
#         <div class='col-xs-8 col-sm-8 col-md-8 col-lg-8 markdown-html'>
#         </div>
#     </div>
# </div>
# ```

# ![](/system/images/imgs/000/000/002/large/editor_2.png?1513566651)

# At this point we have achieved a basic Markdown editor. To improve the editor we will add file uploading and a tagging system in the next post.", title: 'Markdown Editor')


#Projects
chess = Project.new.from_json("{\"name\":\"Chess\",\"description\":\"OOP approach to implementing Chess with Ruby on the command line. Allows for all rules of chess including castling and en passant. \",\"personal_or_work\":true,\"github\":\"https://github.com/hynsondevelops/Chess\",\"live_link\":\"https://github.com/hynsondevelops/Chess\",\"author_id\":1}")
chess.save

real_estate = Project.create!.from_json("{\"name\":\"Real Estate App\",\"description\":\"A real estate listing application similar to Zillow.com or Realtor.com. Uses Ruby on Rails with a Postgresql database and Bootstrap styling. Database includes information on al fifty United States including over X zipcodes and Y cities. Allows for listing for rent or sale with a user profile that allows email communication. \",\"personal_or_work\":true,\"github\":\"https://github.com/hynsondevelops/RealEstateApp\",\"live_link\":\"https://stormy-bayou-53826.herokuapp.com/\",\"author_id\":1}")
real_estate.save

tutoring = Project.create!.from_json("{\"name\":\"Tutoring Business\",\"description\":\"A spanish tutoring business contact page. Fully responsive design. \",\"personal_or_work\":true,\"github\":\"https://github.com/hynsondevelops/TutoringPage\",\"live_link\":\"http://hynsontutoring.services/\",\"author_id\":1}")
tutoring.save
