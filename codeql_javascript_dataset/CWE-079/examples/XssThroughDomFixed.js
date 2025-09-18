//{fact rule=cross-site-scripting@v1.0 defects=0}

$("button").click(function () {
    var target = $(this).attr("data-target");
	$.find(target).hide();
});

//{/fact}