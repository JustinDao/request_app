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