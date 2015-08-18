function initialize(input) {
  var input = document.getElementById(input);
  var autocomplete = new google.maps.places.Autocomplete(input);
}

$(function(){
  google.maps.event.addDomListener(window, 'load', initialize('company_team_address'));
  google.maps.event.addDomListener(window, 'load', initialize('company_address'));
});