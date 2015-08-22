$(window).bind("load", function() {
  Materialize.updateTextFields();
  $('select').material_select();
  $('.select-dropdown').val('');
  $(".chosen-select").chosen({disable_search_threshold: 10, width: "100%"});
});

$(document).ready(function(){
  $('.datepicker').pickadate({
    selectMonths: true,
    selectYears: 100
  });
  $('.tooltipped').tooltip({delay: 50});
  $('input#input_text, textarea#textarea1').characterCounter();
  $(".button-collapse").sideNav();

  $('body').on('click', 'input[type=checkbox]', function(){
    $('input[type=checkbox]:checked').not(this).prop('checked', false);
  });
});