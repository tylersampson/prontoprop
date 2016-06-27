ready = ->
	$("select#per").on 'change', ->
		$(this).parent('form').submit()

	$('form').on 'click', '[data-behavior=remove_fields]', (event) ->
		$(this).prev('input[type=hidden]').val('1')
		$(this).closest('.jarviswidget').hide()
		event.preventDefault()

	$('form').on 'click', '[data-behavior=add_fields]', (event) ->
    time = new Date().getTime()
    regexp = new RegExp($(this).data('id'), 'g')
    $(this).before($(this).data('fields').replace(regexp, time))
    event.preventDefault()

	calculateCommission = (event) ->
		commAmt = parseFloat($("#sale_commission_amount").val())
		vatAmt = (commAmt * 0.14).toFixed(2)
		$('#sale_tax_amount').val vatAmt
		nettComm = commAmt - vatAmt
		$("#sale_nett_amount").val nettComm
		$('[data-behavior=commission]').each ->
			percent = parseFloat($(this).find('[data-behavior=agent_percent]').val())
			agentGross = (nettComm * percent / 100.0).toFixed(2)
			$(this).find('[data-behavior=agent_comm_gross]').val(agentGross)
			taxPercent = parseFloat($(this).find('[data-behavior=agent_tax_percent]').val())
			taxAmount = (agentGross * taxPercent / 100.0).toFixed(2)
			$(this).find('[data-behavior=agent_tax_amount]').val(taxAmount)
			agentNett = (agentGross - taxAmount).toFixed(2)
			$(this).find('[data-behavior=agent_nett_comm]').val(agentNett)

	$('#sale_commission_amount').on 'keyup change blur', calculateCommission
	$('form').on 'keyup change blur', '[data-behavior=agent_percent]', calculateCommission

	calculateCommission()

	$('[data-behavior=agent_id]').each ->
		elem = $(this)
		commission = elem.closest('[data-behavior=commission]')
		$.getJSON '/agents/' + elem.val() + '.json', (data) ->
			console.log data.tax_percent
			commission.find('[data-behavior=agent_tax_percent]').val(data.tax_percent)
			calculateCommission()

	$('form').on 'change', '[data-behavior=agent_id]', (event) ->
		elem = $(this)
		commission = elem.closest('[data-behavior=commission]')
		$.getJSON '/agents/' + elem.val() + '.json', (data) ->
			console.log data.tax_percent
			commission.find('[data-behavior=agent_tax_percent]').val(data.tax_percent)

	$('form').on 'change', '[data-behavior=deductable_id]', (event) ->
		elem = $(this)
		deduction = elem.closest('.jarviswidget')
		$.getJSON '/deductables/' + elem.val() + '.json', (data) ->
			console.log data.default_cost
			deduction.find('[data-behavior=total_cost]').val(data.default_cost)
			deduction.find('[data-behavior=name]').val(data.name)


$(document).on('turbolinks:load', ready);
