//{fact rule=code-injection@v1.0 defects=0}

// API methods
let api = {
  play: function(data) {
    // ...
  },
  pause: function(data) {
    // ...
  }
};

window.addEventListener("message", (ev) => {
    let message = JSON.parse(ev.data);

    // Let the parent frame call the 'play' or 'pause' function
    if (!api.hasOwnProperty(message.name)) {
      return;
    }
    api[message.name](message.payload);
});


//{/fact}