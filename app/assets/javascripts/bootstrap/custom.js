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
	var title      = $('#board_title').val();
	var body_empty = $('#summernote').code().length == 0

	if ( !title || body_empty )
	{
		if ( !title ) 
		{
			if ( !$('#title-error').length )
			{
				$('#board-title').addClass("has-error");
				$('#board-title').append('<p id="title-error" style="color:red">제목을 입력하세요.</p>');
			}
		}
		else
		{
			$('#board-title').removeClass("has-error");
			$('#title-error').remove();
		}

		if ( body_empty ) 
		{
			if ( !$('#body-error').length )
			{
				$('#content_head').addClass("has-error");
				$('#content_head').after('<p id="body-error" style="color:red">본문을 입력하세요.</p>');
			}
		}
		else
		{
			$('#content_head').removeClass("has-error");
			$('#body-error').remove();
		}

		$("html, body").animate({ scrollTop: 0 }, "slow");
		event.preventDefault();
	}
}