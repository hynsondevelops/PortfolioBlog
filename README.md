# PortfolioBlog
A Ruby on Rails application to serve as both a portfolio for myself and a blog to write about web development. I wrote an in browser Markdown converter and editor for writing drafts of blog posts. I documented developing this Markdown editor which you can read about [here](https://hynson-tech-blog.herokuapp.com/posts/Markdown%20Editor)

# Demo
You can see a running version of the application at [https://hynson-tech-blog.herokuapp.com/](https://hynson-tech-blog.herokuapp.com/).
[Portfolio Page](https://hynson-tech-blog.herokuapp.com/)

## Features
**Markdown Editor**

Allows for adding local images by uploading and inserting relevant hyperlink text for Markdown. 

Allows for writing text in on one half of screen and rendering the resulting Markdown output in real time. 

Utilizes RedCarpet gem for converting text to Markdown. 

Utilizes Pygmentize gem for color syntax highlighting within code blocks. 

**Posts**

Markdown editor page allows for posting the content to the blog. 

Posts have tags that are searchable. 

Each post has a Disqus comment section. 

Allows for address, zipcode, city, state, number of bedrooms, number of bathrooms, price, and text description.

Can attach as many pictures as desired to be displayed in a carousel on the listing page. 

## Built With

* [Ruby On Rails](http://rubyonrails.org/) - The web framework used
* [Bootstrap](https://getbootstrap.com/) - Front end design

## Authors

* **Adam Hynson** - *Developer* - [Github](https://github.com/hynsondevelops) - [Portfolio](https://hynson-tech-blog.herokuapp.com/portfolio) - [Blog](https://hynson-tech-blog.herokuapp.com/posts)