// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .


$(document).ready(function(){
	document.getElementById("user_residence").selectedIndex = -1;

	$("#user_residence").bind("change", function(){
		$("#user_building").empty();
		var value = $(this).find(":selected").val();
		$.ajax({
			url: '/buildings/',
			dataType: 'json',
			type: 'GET',
			success: function(data) {
				$.each(data, function(){
					if(this.residence_id == value) {
						$('#user_building').append($("<option/>", {
							value: this.id,
							text: this.name
						}));
					}
				});					
				
				var buildings = document.getElementById("user_building");
				if(buildings.length > 1){
					buildings.selectedIndex = -1;
				}

			}
		});

	});
});