$(function(){
  $('.type-company').click(function(event){
    event.preventDefault();
    $('#company_type_company').val($(this).attr('typec'));
    $('.type-company').children().removeClass('selected-type');
    $(this).children().addClass('selected-type');
  });
});