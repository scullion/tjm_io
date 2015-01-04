spy = $(window).scrollspy(target: '.article-menu')
spy.on 'activate.bs.scrollspy', (e) -> $(e.target).parents('li').removeClass('active')

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

