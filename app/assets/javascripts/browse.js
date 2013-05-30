$(document).ready(function() {

  $("#item_name").bind("change", function(){
    $("#item_list").empty();
    var item_name = $(this).find(":selected").val();
    var item_type = $("#item_type").find(":selected").val();
    
    var names = new Object(); 
    var check = new Object();
    
    function get1(k) {
        return names[k];
    }
    function get2(k) {
        return check[k];
    }

    $.ajax({
      url: '/browse/',
      dataType: 'json',
      type: 'GET',
      success: function(data) {
        $.each(data, function(){
          var n = this.name.toLowerCase();
          if(names[n] == undefined){
            names[n] = 1;
          }
          else{
            names[n] += 1;
          }
        });

        $.each(data, function(){
          var n = this.name.toLowerCase();
          if(item_type != undefined) {
            if( n[0] == item_name.toLowerCase() && this.item_type_id == item_type ) {
              if(get1(n) > 1){
                if(get2(n) == undefined){
                  check[n] = 1;
                  $('#item_list').append($("<a/>", {
                    href: "/items/find?name=" + this.name,
                    text: this.name
                  }));
                  $('#item_list').append($("<br/>", {           
                  }));
                }
              }
              else{
                $('#item_list').append($("<a/>", {
                  href: "/users/" + this.user_id + "/items" + this.id,
                  text: this.name
                }));
                $('#item_list').append($("<br/>", {           
                }));
              }
            }
          }
          else {
            if(n[0] == item_name.toLowerCase()) {
              if(get1(n) > 1){
                if(get2(n) == undefined){
                  check[n] = 1;
                  $('#item_list').append($("<a/>", {
                    href: "/items/find?name=" + this.name,
                    text: this.name
                  }));
                  $('#item_list').append($("<br/>", {           
                  }));
                }
              }
              else{
                $('#item_list').append($("<a/>", {
                  href: "/users/" + this.user_id + "/items" + this.id,
                  text: this.name
                }));
                $('#item_list').append($("<br/>", {           
                }));
              }
            }
          }
        });     
      }
    });
  });

  $("#item_type").bind("change", function(){
    $("#item_list").empty();
    var item_name = $("#item_name").find(":selected").val();
    var item_type = $(this).find(":selected").val();
    
    var names = new Object(); 
    var check = new Object();
    
    function get1(k) {
        return names[k];
    }
    function get2(k) {
        return check[k];
    }

    $.ajax({
      url: '/browse/',
      dataType: 'json',
      type: 'GET',
      success: function(data) {
        $.each(data, function(){
          var n = this.name.toLowerCase();
          if(names[n] == undefined){
            names[n] = 1;
          }
          else{
            names[n] += 1;
          }
        });

        $.each(data, function(){
          var n = this.name.toLowerCase();
          if(item_type != undefined) {
            if( n[0] == item_name.toLowerCase() && this.item_type_id == item_type ) {
              if(get1(n) > 1){
                if(get2(n) == undefined){
                  check[n] = 1;
                  $('#item_list').append($("<a/>", {
                    href: "/items/find?name=" + this.name,
                    text: this.name
                  }));
                  $('#item_list').append($("<br/>", {           
                  }));
                }
              }
              else{
                $('#item_list').append($("<a/>", {
                  href: "/users/" + this.user_id + "/items" + this.id,
                  text: this.name
                }));
                $('#item_list').append($("<br/>", {           
                }));
              }
            }
          }
          else {
            if(n[0] == item_name.toLowerCase()) {
              if(get1(n) > 1){
                if(get2(n) == undefined){
                  check[n] = 1;
                  $('#item_list').append($("<a/>", {
                    href: "/items/find?name=" + this.name,
                    text: this.name
                  }));
                  $('#item_list').append($("<br/>", {           
                  }));
                }
              }
              else{
                $('#item_list').append($("<a/>", {
                  href: "/users/" + this.user_id + "/items" + this.id,
                  text: this.name
                }));
                $('#item_list').append($("<br/>", {           
                }));
              }
            }
          }
        });     
      }
    });
  });

});