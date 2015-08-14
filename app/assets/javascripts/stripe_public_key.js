$(function(){

  var handler = StripeCheckout.configure({
  key: $('#pstripe').attr('pkey'),
  image: $('#pstripe').attr('src-img'),
  token: function(token) {
      $('#customButton').attr('disabled', true);
      $('#customButton').addClass('disabled');
    $.post('/charges.json', { stripeToken: token.id }, function(data){
      if (data.message !== 'succeeded'){
        Materialize.toast(data.message+', please try again', 4000);
        $('#customButton').prop('disabled', false);
        $('#customButton').removeClass('disabled');
      }else{
        window.location.reload();
      }
    });
  }
  });

  $('#customButton').on('click', function(e) {
    handler.open({
      name: 'Business4Business',
      description: 'Annual payment',
      amount: 5000,
      color: '#2196F3'
    });
    e.preventDefault();
  });

  $(window).on('popstate', function() {
    handler.close();
  });
});