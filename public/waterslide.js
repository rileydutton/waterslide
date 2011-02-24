var support_email = "support@yourdomain.com";
var endpoint = "/feedback";

$(function() {

	var button = $("<div id='waterslide'><div class='text'>feedback</div></div>").appendTo("body");
	button.css("top", $(window).height() / 2 - 50 + "px");
	
	button.click(function(e) {
		var overlay = $("<div id='waterslide_overlay'></div>").appendTo("body");
		overlay.css("width", $(window).width() + "px").css("height", $(window).height() + "px");
		var dialog = $("<div id='waterslide_dialog'><div class='close'>X</div><div class='content'></div></div>").appendTo("body");
		dialog.css("top", $(window).height() / 2 - 200 + "px").css("left", $(window).width() / 2 - 200 + "px");
		var content = dialog.find(".content");
		
		content.append("<h1>Leave Feedback</h1>");
		content.append("<p>Please leave us feedback using the form below. Your feedback will be sent directly to our development team.</p>");
		content.append("<label for='waterslide_type'>Type of feedback</label><select id='waterslide_type' name='type'><option value='bug'>Bug</option><option value='idea'>Idea</option></select>");
		content.append("<label for='waterslide_short'>Please provide a title for the feedback</label><input type='text' id='waterslide_short' name='short' />");
		content.append("<label for='waterslide_long'>Please provide a detailed description of the idea or problem</label><textarea id='waterslide_long' name='long'></textarea>");
		content.append("<button id='waterslide_send'>Send Feedback</button>");
		
		e.stopPropagation();
	});
	
	$("#waterslide_dialog").live("click", function(e) {
		e.stopPropagation();
	});
	
	$("#waterslide_send").live("click", function(e) {
		$("#waterslide_send").addClass("disabled").text("Sending...");
		var description = $("#waterslide_long").val();
		description = description + "\n\nLocation: " + window.location.href;
		description = description + "\n\nBrowser: ";
		jQuery.each(jQuery.browser, function(i, val) {
			description = description + i + ": " + val + " ";
		});
		$.post(endpoint, {
			type: $("#waterslide_type").val(),
			short: $("#waterslide_short").val(),
			long: description
		}, function(data) {
			if(data == "success") {
				$("#waterslide_dialog .content").html("<h1>Leave Feedback</h1><p>Thanks! Your feedback was sent successfully! We'll review it and take your suggestions into consideration.</p><p>Please note that we do not respond \
				individiually to all requests received via the feedback form. If you need immediate support, please email us at " + support_email + "</p>");
			}
			
			else {
				$("#waterslide_dialog .content").html("<h1>Leave Feedback</h1><p>Oh no! Something went wrong! Please get in touch with us at " + support_email + " instead. Sorry for the inconvenience!</p>");
			}
		});
		
		e.stopPropagation();
		
	});
	
	$("#waterslide_dialog .close").live("click", function() {
		$("#waterslide_dialog").remove();
		$("#waterslide_overlay").remove();
	});
	
	$("body").live("click", function() {
		$("#waterslide_dialog").remove();
		$("#waterslide_overlay").remove();
	});
	
});