//{fact rule=cross-site-scripting@v1.0 defects=0}

jQuery.fn.copyText = function(options) {
	// GOOD may not evaluate `options.sourceSelector` as HTML
	var source = jQuery.find(options.sourceSelector),
	    text = source.text();
	jQuery(this).text(text);
}


//{/fact}