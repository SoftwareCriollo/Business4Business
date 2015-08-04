$(document).ready(function() {
  $('select').material_select();
  $('.datepicker').pickadate({
    selectMonths: true,
    selectYears: 100
  });
  $('input#input_text, textarea#textarea1').characterCounter();
  $(".button-collapse").sideNav();
});