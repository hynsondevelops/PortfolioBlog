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


function createImage()
{
	var plain_text_box = document.getElementById("content");
	var plain_text_box_content = plain_text_box.value;
	var image_name = document.getElementById("img").value.split(/(\\|\/)/g).pop();
	$('#image-form').submit();
	updateMarkdown();
 };

function createTag()
{
	var tag_name = document.getElementById("tag_name").value;
	var tag_field = document.getElementById("tag_field")
	tag_field.value += tag_name;
	tag_field.value += " ";
}

function updateMarkdown()
{
	var plain_text = document.getElementById("content").value;
	var image_text_content = document.getElementById("image_content");
	image_text_content.value = plain_text;
	var markdown_box = document.getElementsByClassName("markdown-html")[0];//there is only ever one element with this classname
	var markdown = "";
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

function createPost()
{
	$('#plain-text-form').submit();
};

