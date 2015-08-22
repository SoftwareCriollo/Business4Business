$(window).bind("load", function() {
  $(".next").click(function(){
    $('#btn_edit_account').hide('slow');
    $('#form_edit_account').show('slow');
  });
});