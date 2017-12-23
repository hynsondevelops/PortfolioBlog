# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Post.create!(content: "This tutorial will show how to make a Markdown editor within a Ruby on Rails application. The tutorial assumes knowledge of basic Ruby on Rails and Javascript.

###Languages
Rails 5.0.6
Ruby 2.3.0
Javascript

###Setup
Start by making a new Rails app,

```
$ rails new AppName
```
where AppName is your choice of name for your Rails application.

###Gems
Gemfile

```ruby
#for styling
gem 'bootstrap-sass', '3.3.6'
#for navbar
gem 'rails_bootstrap_navbar'
#for markdown to html
gem 'redcarpet', '~> 3.0.0'
#for images
gem 'paperclip', '~> 5.0.0'
```
```
bundle install
```
###Creating a Post Model
```
$ rails g model Post content:text title:text
```
The post model has a text field, content, that saves our Markdown that we generate from our editor. For now, the only other field is a title.

###Creating a Post Controller
```
$ rails g controller Posts
```
**app/controllers/posts_controller.rb**

```ruby
class PostsController < ApplicationController
    def new
        Post.new
        @plain_text = 'Type your markdown plain text here.'
    end
end
```
The variable, @plain_text, will be used as default text for the plain-text input text field.

###Routing
**config/routes.rb**

```ruby
Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts
end
```
###Creating a New Post View
**app/views/posts/new.html.erb**

```erb
<div class='container-fluid'>
    <div class='row'>
        <%= form_tag('/posts', id: 'plain-text-form') do%>
         <%= text_area_tag('content', @plain_text, class: 'col-xs-4 col-sm-4 col-md-4 col-lg-4 plain-text') %>
                 <% end %>
        <div class='col-xs-8 col-sm-8 col-md-8 col-lg-8 markdown-html'>
        </div>
    </div>
</div>
```
**app/assets/stylesheets/application.scss**

```scss
/*
 * This is a manifest file that'll be compiled into application.css, which will include all the files
 * listed below.
 *
 * Any CSS and SCSS file within this directory, lib/assets/stylesheets, vendor/assets/stylesheets,
 * or any plugin's vendor/assets/stylesheets directory can be referenced here using a relative path.
 *
 * You're free to add application-wide styles to this file and they'll appear at the bottom of the
 * compiled file so the styles you add here take precedence over styles defined in any other CSS/SCSS
 * files in this directory. Styles in this file should be added after the last require_* statement.
 * It is generally better to create a new file per style scope.
 *
 *= require_tree .
 *= require_self
 */

$icon-font-path: 'bootstrap/';

@import 'bootstrap';
$markdown-editor-height: 800px;

.plain-text
{
    border: 1px solid black;
    min-height: $markdown-editor-height;
    height: auto;
}

.markdown-html
{
    border: 1px solid black;
    min-height: $markdown-editor-height;
    height: auto;
}
```

![](/system/images/imgs/000/000/001/large/test.png?1513566640)

This view will serve as the front end of our Markdown editor. The left side text box is for entering plain text that will be converted to Markdown while the right side will show the converted Markdown HTML view.

###Redcarpet
[Redcarpet on Github](https://github.com/vmg/redcarpet/tree/master/lib/redcarpet)
Redcarpet is a gem that allows Markdown parsing. Our editor will use the Redcarpet to make a markdown helper function that takes text and returns the rendered Markdown.

**app/helpers/application_helper.rb**

```ruby
module ApplicationHelper

    def markdown(text)
        options = {
          filter_html:     true,
          hard_wrap:       true,
          link_attributes: { rel: 'nofollow', target: '_blank' },
          space_after_headers: true,
          fenced_code_blocks: true
        }

        extensions = {
          autolink:           true,
          superscript:        true,
          disable_indented_code_blocks: true,
          fenced_code_blocks: true,
          tables: true
        }

        renderer = Redcarpet::Render::HTML.new(options)

        markdown = Redcarpet::Markdown.new(renderer, extensions)

        markdown.render(text).html_safe
    end
end
```
Our function is written in the application helper so it can be used across the whole application. The options and extensions are a set of flags that can be enabled or disabled and are further detailed on the Redcarpet Github page. Now we can call helpers.markdown(text) to convert text to Markdown throughout our application.

###Post Controller Method for Parsing
**app/controllers/posts_controller.rb**

```ruby
class PostsController < ApplicationController
    def new
        Post.new
        @plain_text = 'Type your markdown plain text here.'
    end

    def markdown_helper
        @content = helpers.markdown(params[:content])
        render json: {content: @content}
    end
end
```
The markdown_helper method will used by a JSON AJAX call.

###Real Time Updating
In order to allow the user to type in text and see Markdown update we will need Javascript.

```javascript
// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .


function updateMarkdown()
{
    var plain_text = document.getElementById('content').value;
    var markdown_box = document.getElementsByClassName('markdown-html')[0];//there is only ever one element with this classname
    var markdown = '';
    $.ajax({
        type: 'GET',
        url: '/markdown',
        data: { 
            content: plain_text
        },
        dataType: 'json',
        success: function(data){
            markdown_box.innerHTML = data.content
        }        
    });
};
```
Now we have a function that when called will update the right side with a rendered Markdown view. To make the Markdown update with each new character typed we can onkeyup of our plain text box call the function.

**app/views/posts/new.html.erb**

```erb
<div class='container-fluid'>
    <div class='row'>
        <%= form_tag('/posts', id: 'plain-text-form') do%>
         <%= text_area_tag('content', @plain_text, class: 'col-xs-4 col-sm-4 col-md-4 col-lg-4 plain-text', onkeyup: 'updateMarkdown();') %>
                 <% end %>
        <div class='col-xs-8 col-sm-8 col-md-8 col-lg-8 markdown-html'>
        </div>
    </div>
</div>
```

![](/system/images/imgs/000/000/002/large/editor_2.png?1513566651)

At this point we have achieved a basic Markdown editor. To improve the editor we will add file uploading and a tagging system in the next post.", title: 'Markdown Editor')