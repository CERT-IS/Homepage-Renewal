/* Write here your custom javascript codes */

function registerAllow() {
	if ( $("input:checkbox[id='terms_agree']").is(":checked") ) {
		$("#reg_btn").prop('disabled', false);
	}
	else {
		$("#reg_btn").prop('disabled', true);	
	}
}

function summernote_submit() {
	var t =  $('#summernote').code();
    console.log(t);
}
