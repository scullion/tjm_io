(function() {
  var BAR_HEIGHT, BAR_OPACITY_THRESHOLD, OBFUSCATED_EMAIL, SCROLL_OFFSET_FUDGE, obfuscate, setUpContactForm, setUpScrollspy, setup;

  BAR_OPACITY_THRESHOLD = 1000;

  BAR_HEIGHT = 50;

  SCROLL_OFFSET_FUDGE = 10;

  OBFUSCATED_EMAIL = 'k_kur1vp';

  obfuscate = function(s) {
    var ch;
    return String.fromCharCode.apply(String, (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = s.length; _i < _len; _i++) {
        ch = s[_i];
        _results.push(31 ^ ch.charCodeAt());
      }
      return _results;
    })());
  };

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
      var button, data, form, url;
      form = $(e.target);
      url = "//formspree.io/" + (obfuscate(OBFUSCATED_EMAIL));
      form.attr('action', url);
      data = form.serialize();
      button = $('#send-button').attr('disabled', 'disabled').button('sending');
      $.ajax({
        type: 'POST',
        url: url,
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
