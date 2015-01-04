(function() {
  var spy;

  spy = $(window).scrollspy({
    target: '.article-menu'
  });

  spy.on('activate.bs.scrollspy', function(e) {
    return $(e.target).parents('li').removeClass('active');
  });

  $('#contact-form').submit(function(e) {
    var button, data, form;
    form = $(e.target);
    data = form.serialize();
    button = $('#send-button').attr('disabled', 'disabled').button('sending');
    $.ajax({
      type: 'POST',
      url: "//formspree.io/thomasjamesmoran@gmail.com",
      data: form.serialize(),
      dataType: 'json'
    }).done(function() {
      button.button('sent').removeClass('btn-default').addClass('btn-success').hide();
      return $('#success-alert').fadeIn('slow');
    }).fail(function() {
      return button.button('reset').removeAttr('disabled');
    });
    e.preventDefault();
    return false;
  });

}).call(this);
