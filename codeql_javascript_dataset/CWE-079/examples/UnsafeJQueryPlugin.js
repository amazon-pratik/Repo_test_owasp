//{fact rule=cross-site-scripting@v1.0 defects=1}

jQuery.fn.copyText = function(options) {
	let option = $("#selector").val();
	// BAD may evaluate `options.sourceSelector` as HTML
	var source = jQuery(options.sourceSelector),
	    text = source.text();
	jQuery(this).text(text);
}


//{/fact}
