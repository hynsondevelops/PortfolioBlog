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
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.widget
//= require z.jquery.fileupload
//= require turbolinks
//= require_tree .
//= require bootstrap.min

function createImage()
{
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
	        markdown_box.innerHTML = "  <br>" + data.content
	        console.log(markdown_box.innerHTML)

	    }        
	});
};

function createPost()
{
	$('#plain-text-form').submit();
};

function redirectToShow()
{
	$('#redirect')[0].click();
	alert("You do not have edit privledges for this post.")
	console.log("CLICKED")
};

function nextText()
{

	var skills = $(".portfolio-skills")
	for (var i = 0; i < skills.length; i++)
	{
		console.log(i)
		console.log(skills[i].style)
		if ($(skills[i]).css("display") != "none")
		{
			console.log("True")
			console.log(i)
			if (i + 1 == skills.length)
			{
				$("#skill" + i).hide()
				$("#skill0").css("display", "inline-block")
				return
			}
			else
			{
				$("#skill" + i).hide()
				$("#skill" + (i + 1)).css("display", "inline-block")
				return
			}
		}
	}
	$("#skill6").css("display", "inline-block")

}

function rotateText()
{
	nextText(); 
	window.setInterval(nextText, 4000);
}


function submitContactInfo()
{
	$("#new_contact").submit();
	var modal = $("#contact-modal");
	modal.html("Your contact request has been submitted. Thank you for contacting me. I will get back to you by the next day. ");
	var buttons = $("#contact-create-buttons");
	buttons.html('<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>')
}
