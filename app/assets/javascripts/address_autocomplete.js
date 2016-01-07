function initialize(input_id) {
  var input = document.getElementById(input_id);
  var autocomplete = new google.maps.places.Autocomplete(input);
}

$(function(){
  google.maps.event.addDomListener(window, 'load', initialize('company_team_address'));
  google.maps.event.addDomListener(window, 'load', initialize('company_address'));
});