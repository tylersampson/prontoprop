ready = ->
	$("flash-message").each ->
		elem = $(this)
		$.smallBox
			title: elem.attr('title')
			content: elem.html()
			color: elem.attr('color')
			iconSmall: elem.attr('icon')
			timeout: 4000

$(document).on 'turbolinks:load', ready
