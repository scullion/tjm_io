(function() {
  var BAR_HEIGHT, BAR_OPACITY_THRESHOLD, MENU_CLICK_INTERNAL_MSEC, OBFUSCATED_EMAIL, SCROLL_OFFSET_FUDGE, obfuscate, setUpContactForm, setUpScrollspy, setup;

  BAR_OPACITY_THRESHOLD = 1000;

  BAR_HEIGHT = 50;

  MENU_CLICK_INTERNAL_MSEC = 150;

  SCROLL_OFFSET_FUDGE = 1;

  OBFUSCATED_EMAIL = 'k_kur1vp';

  obfuscate = function(s) {
    var ch;
    return String.fromCharCode.apply(String, (function() {
      var i, len, results;
      results = [];
      for (i = 0, len = s.length; i < len; i++) {
        ch = s[i];
        results.push(31 ^ ch.charCodeAt());
      }
      return results;
    })());
  };

  setUpScrollspy = function($w) {
    var $menu, activate, clickTime, clickedLink, computeScrollOffset, deactivateParents;
    $w = $(window);
    $menu = $('.article-menu');
    clickTime = 0;
    clickedLink = null;
    computeScrollOffset = function() {
      return SCROLL_OFFSET_FUDGE + ($w.width() < BAR_OPACITY_THRESHOLD ? BAR_HEIGHT : 0);
    };
    deactivateParents = function(e) {
      return e.parents('li').removeClass('active');
    };
    activate = function(link) {
      $menu.find('li.active').removeClass('active');
      return deactivateParents(link.closest('li').addClass('active'));
    };
    $w.on({
      'activate.bs.scrollspy': function(e) {
        var elapsed;
        elapsed = (new Date).getTime() - clickTime;
        if (elapsed <= MENU_CLICK_INTERNAL_MSEC) {
          return activate(clickedLink);
        } else {
          return deactivateParents($(e.target));
        }
      },
      'resize orientationChanged': function() {
        var spy;
        spy = $w.data('bs.scrollspy');
        spy.options.offset = computeScrollOffset();
        return spy.process();
      }
    });
    $menu.on('click', 'a', function(e) {
      clickedLink = $(e.target);
      clickTime = (new Date).getTime();
      return activate(clickedLink);
    });
    $w.scrollspy({
      target: '.article-menu',
      offset: computeScrollOffset()
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
