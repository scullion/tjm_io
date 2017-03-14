BAR_OPACITY_THRESHOLD = 1000
BAR_HEIGHT = 50
MENU_CLICK_INTERNAL_MSEC = 150
SCROLL_OFFSET_FUDGE = 1
OBFUSCATED_EMAIL = 'k_kur1vp'

obfuscate = (s) -> String.fromCharCode (31 ^ ch.charCodeAt() for ch in s)...

setUpScrollspy = ($w) ->
	$w = $(window)
	$menu = $('.article-menu')
	clickTime = 0
	clickedLink = null

	# Returns an offset to use when mapping the document position to a menu
	# link interval.
	computeScrollOffset = -> 
		SCROLL_OFFSET_FUDGE + (if $w.width() < BAR_OPACITY_THRESHOLD then BAR_HEIGHT else 0)

	deactivateParents = (e) ->
		e.parents('li').removeClass('active')

	# Activates a menu link in the same way as bs.scrollspy.
	activate = (link) ->
		$menu.find('li.active').removeClass('active')
		deactivateParents link.closest('li').addClass('active')

	$w.on
		'activate.bs.scrollspy': (e) -> 
			# If a link was clicked a short time ago, replace scrollspy's chosen
			# target with the clicked link. 
			elapsed = (new Date).getTime() - clickTime
			if elapsed <= MENU_CLICK_INTERNAL_MSEC
				activate(clickedLink)
			else
				deactivateParents $(e.target)
		'resize orientationChanged': -> 
			spy = $w.data('bs.scrollspy')
			spy.options.offset = computeScrollOffset()
			spy.process()
	

	# When a link is clicked, remember it and the time it was clicked.
	$menu.on('click', 'a', (e) -> 
		clickedLink = $(e.target)
		clickTime = (new Date).getTime()
		activate(clickedLink)
	)

	# Set up bs.scrollspy.
	$w.scrollspy target: '.article-menu', offset: computeScrollOffset()

	# Force-fire the event at load time to clear 'active' on parents of the
	# initially-selected element.
	$('.article-menu .active').trigger('activate.bs.scrollspy')

setUpContactForm = ($w) ->
	$('#contact-form').submit (e) ->
		form = $(e.target)
		url = "//formspree.io/#{obfuscate OBFUSCATED_EMAIL}"
		form.attr 'action', url
		data = form.serialize()
		button = $('#send-button').attr('disabled', 'disabled').button('sending')
		$.ajax(
			type: 'POST'
			url: url
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
