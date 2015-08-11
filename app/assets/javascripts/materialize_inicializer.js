$(document).ready(function() {
  $('select').material_select();
  $(".chosen-select").chosen({disable_search_threshold: 10});
  $('.datepicker').pickadate({
    selectMonths: true,
    selectYears: 100
  });
  $('input#input_text, textarea#textarea1').characterCounter();
  $(".button-collapse").sideNav();
});