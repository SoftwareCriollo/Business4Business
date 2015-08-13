function initialize() {
  var input = document.getElementById('company_address');
  var autocomplete = new google.maps.places.Autocomplete(input);
}

$(function(){
  google.maps.event.addDomListener(window, 'load', initialize);
});