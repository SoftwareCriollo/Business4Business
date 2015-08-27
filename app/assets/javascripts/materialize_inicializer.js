$(window).bind("load", function() {
  Materialize.updateTextFields();
  $('select').material_select();
  $(".chosen-select").chosen({disable_search_threshold: 10, width: "100%"});
  $('.select-edit-company').find("input[type='text']").addClass('select-edit-company-valid input-new-project');
  $('.input-select-skill-project').find("input[type='text']").addClass('input-new-project');
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
  $('.datepicker-new-project').change(function() {
    if ( $('.datepicker-new-project').val() ) {
      $('.datepicker-new-project').addClass('select-skill-valid');
    } else {
      $('.datepicker-new-project').removeClass('select-skill-valid');
    }
  });
});