/* Write here your custom javascript codes */
jQuery(document).ready(function() {
    App.init();
});

function registerAllow() {
	if ( $("input:checkbox[id='terms_agree']").is(":checked") ) {
		$("#reg_btn").prop('disabled', false);
	}
	else {
		$("#reg_btn").prop('disabled', true);	
	}
}

function summernote_submit() {
	var title = $('#board_title').val();
	if (!title) {
		$('#board-title').addClass("has-error");
		$('#board-title').append('<p style="color:red">제목을 입력하세요.</p>')
		$("html, body").animate({ scrollTop: 0 }, "slow");
		event.preventDefault();
	}
	var t =  $('#summernote').code();
    $('#board_contents').val(t);
}