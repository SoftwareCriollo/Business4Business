$(function(){

  var handler = StripeCheckout.configure({
  key: $('#pstripe').attr('pkey'),
  image: 'https://stripe.com/img/documentation/checkout/marketplace.png',
  token: function(token) {
      $('#customButton').attr('disabled', true);
      $('#customButton').addClass('disabled');
    $.post('/charges.json', { stripeToken: token.id }, function(data){
      if (data.message != 'succeeded'){
        Materialize.toast(data.message+', please try again', 4000)
        $('#customButton').prop('disabled', false);
        $('#customButton').removeClass('disabled');
      }
    });
  }
  });

  $('#customButton').on('click', function(e) {
    handler.open({
      name: 'B4B',
      description: '2 widgets',
      amount: 2000,
      color: '#2196F3'
    });
    e.preventDefault();
  });

  $(window).on('popstate', function() {
    handler.close();
  });
});