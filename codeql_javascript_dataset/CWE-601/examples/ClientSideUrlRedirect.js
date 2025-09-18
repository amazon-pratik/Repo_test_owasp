//{fact rule=open-redirect@v1.0 defects=1}

window.location = /.*redirect=([^&]*).*/.exec(document.location.href)[1];


//{/fact}