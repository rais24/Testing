$ ->
  $('a[href=#how-it-works]').click (e) ->
    e.preventDefault()
    $('.btn-navbar').click()

    visorHeight  = $('#visor').height()
    anchorOffset = $('#how-it-works').offset()

    $('html,body').animate { scrollTop: anchorOffset.top - visorHeight }, 400


$(document).ready ->
	$("#zip-form").on("ajax:success", (e, data, status, xhr) ->
		).bind "ajax:complete", (e, xhr, status) ->
			resp = jQuery.parseJSON(xhr.responseText);
			if resp.txt == "Found"
				$('.user_zipcode').val(resp.zip)
				$('#zip-confirmed').modal();
			else
				$('.user_zipcode').val(resp.zip)
				$('#zip-not-found').modal();
				
	$('.second-form').on('hidden.bs.modal', (e) ->
		$('#mailing-list-submit').modal('show'); )
		
	$(".second-form").submit (event) ->
	  event.preventDefault();
	  $(this).modal('hide');
