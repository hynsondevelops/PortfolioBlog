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
	var plain_text = document.getElementById("content").value;
	var markdown_box = document.getElementsByClassName("markdown-html")[0];//there is only ever one element with this classname
	var markdown = ""

	$.ajax({
	    type: "GET",
	    url: "/markdown",
	    data: { 
	        content: plain_text
	    },
	    dataType: "json",
	    success: function(data){
	        markdown_box.innerHTML = data.content
	    }        
	});
};

/*$.get('/markdown', {"content": plain_text}, function(response){
    // the response variable will contain the output of the controller method
      	console.log(response);
      	console.log(response[0])

  	});
  	*/

function createPost()
{
	$('#plain-text-form').submit();
}


