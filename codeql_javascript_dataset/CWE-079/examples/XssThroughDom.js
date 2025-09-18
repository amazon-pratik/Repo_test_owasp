//{fact rule=cross-site-scripting@v1.0 defects=1}

$("button").click(function () {
    var target = $(this).attr("data-target");
    $(target).hide();
});

//{/fact}
