/* Write here your custom javascript codes */

function registerAllow() {
	if ( $("input:checkbox[id='terms_agree']").is(":checked") ) {
		$("input:submit").prop('disabled', false);
	}
	else {
		$("input:submit").prop('disabled', true);	
	}
}
