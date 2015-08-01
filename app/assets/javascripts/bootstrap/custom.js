/* Write here your custom javascript codes */

function registerAllow() {
	if ( $("input:checkbox[id='terms_agree']").is(":checked") ) {
		$("#reg_btn").prop('disabled', false);
	}
	else {
		$("#reg_btn").prop('disabled', true);	
	}
}
