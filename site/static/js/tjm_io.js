(function() {
  var BAR_HEIGHT, BAR_OPACITY_THRESHOLD, SCROLL_OFFSET_FUDGE, setUpContactForm, setUpScrollspy, setup;

  BAR_OPACITY_THRESHOLD = 1000;

  BAR_HEIGHT = 50;

  SCROLL_OFFSET_FUDGE = 10;

  setUpScrollspy = function($w) {
    var computeScrollOffset;
    $w = $(window);
    computeScrollOffset = function() {
      return SCROLL_OFFSET_FUDGE + ($w.width() < BAR_OPACITY_THRESHOLD ? BAR_HEIGHT : 0);
    };
    $w.scrollspy({
      target: '.article-menu',
      offset: computeScrollOffset()
    });
    $w.on({
      'activate.bs.scrollspy': function(e) {
        return $(e.target).parents('li').removeClass('active');
      },
      'resize orientationChanged': function() {
        var spy;
        spy = $w.data('bs.scrollspy');
        spy.options.offset = computeScrollOffset();
        return spy.process();
      }
    });
    return $('.article-menu .active').trigger('activate.bs.scrollspy');
  };

  setUpContactForm = function($w) {
    return $('#contact-form').submit(function(e) {
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
  };

  setup = function(e) {
    var $w;
    $w = $(window);
    setUpScrollspy($w);
    return setUpContactForm($w);
  };

  $(document).ready(setup);

}).call(this);

//# sourceMappingURL=tjm_io.js.map
