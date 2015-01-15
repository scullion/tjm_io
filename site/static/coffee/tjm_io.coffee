BAR_OPACITY_THRESHOLD = 1100
BAR_HEIGHT = 50

setUpScrollspy = ($w) ->
	$w = $(window)
	computeScrollOffset = -> if $w.width() < BAR_OPACITY_THRESHOLD then BAR_HEIGHT else 0 
	$w.scrollspy target: '.article-menu', offset: computeScrollOffset()
	$w.on 'activate.bs.scrollspy', (e) -> $(e.target).parents('li').removeClass('active')
	$w.on 'resize orientationChanged', -> 
		spy = $w.data('bs.scrollspy')
		spy.options.offset = computeScrollOffset()
		spy.process()

setUpContactForm = ($w) ->
	$('#contact-form').submit (e) ->
		form = $(e.target)
		data = form.serialize()
		button = $('#send-button').attr('disabled', 'disabled').button('sending')
		$.ajax(
			type: 'POST'
			url: "//formspree.io/thomasjamesmoran@gmail.com"
			data: form.serialize() 
			dataType: 'json'
		).done(
			-> 
				button.button('sent').removeClass('btn-default').addClass('btn-success').hide()
				$('#success-alert').fadeIn('slow')
		).fail(
			-> button.button('reset').removeAttr('disabled')
		)
		e.preventDefault()
		return false

setup = (e) ->
	$w = $(window)
	setUpScrollspy $w
	setUpContactForm $w

$(document).ready(setup)
