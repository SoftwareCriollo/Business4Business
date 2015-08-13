$(document).ready(function() {
  $('select').material_select();
  $('.select-dropdown').val('');
  $(".chosen-select").chosen({disable_search_threshold: 10});
  $('.datepicker').pickadate({
    selectMonths: true,
    selectYears: 100
  });
  $('input#input_text, textarea#textarea1').characterCounter();
  $(".button-collapse").sideNav();
});
$(window).bind("load", function() {
  Materialize.updateTextFields();
});