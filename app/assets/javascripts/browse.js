$(document).ready(function() {

  $("#item_name").bind("change", function(){
    $("#item_list").empty();
    var item_name = $(this).find(":selected").val();
    var item_type = $("#item_type").find(":selected").val();

    $.ajax({
      url: '/browse/',
      dataType: 'json',
      type: 'GET',
      success: function(data) {
        $.each(data, function(){
          if(item_type != undefined) {
            if( (this.name[0] == item_name || this.name[0] == item_name.toLowerCase()) && this.item_type_id == item_type ) {
              $('#item_list').append($("<a/>", {
                href: "/users/" + this.user_id + "/items/"+this.id,
                text: this.name
              }));
              $('#item_list').append($("<br/>", {           
              }));
            }
          }
          else {
            if(this.name[0] == item_name || this.name[0] == item_name.toLowerCase()) {
              $('#item_list').append($("<a/>", {
                href: "/users/" + this.user_id + "/items/"+this.id,
                text: this.name
              }));
              $('#item_list').append($("<br/>", {           
              }));
          }}
      });     
    }});
  });

  $("#item_type").bind("change", function(){
    $("#item_list").empty();
    var item_name = $("#item_name").find(":selected").val();
    var item_type = $(this).find(":selected").val();

    $.ajax({
      url: '/browse/',
      dataType: 'json',
      type: 'GET',
      success: function(data) {
        $.each(data, function(){
          if(item_name != undefined) {
            if( (this.name[0] == item_name || this.name[0] == item_name.toLowerCase()) && this.item_type_id == item_type ) {
              $('#item_list').append($("<a/>", {
                href: "/users/" + this.user_id + "/items/"+this.id,
                text: this.name
              }));
              $('#item_list').append($("<br/>", {           
              }));
            }
          }
          else {
            if(this.item_type_id == item_type) {
              $('#item_list').append($("<a/>", {
                href: "/users/" + this.user_id + "/items/"+this.id,
                text: this.name
              }));
              $('#item_list').append($("<br/>", {           
              }));
          }}
      });     
    }});
  });

});