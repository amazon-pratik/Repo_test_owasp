//{fact rule=code-injection@v1.0 defects=1}

// API methods
function play(data) {
  // ...
}
function pause(data) {
  // ...
}

window.addEventListener("message", (ev) => {
    let message = JSON.parse(ev.data);

    // Let the parent frame call the 'play' or 'pause' function 
    window[message.name](message.payload);
});

//{/fact}