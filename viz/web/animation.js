var port = new osc.WebSocketPort({
  url: "ws://localhost:8081"
});

function sleep(ms) {
}

port.on("message", async function (oscMessage) {
  var [,duration,selector,actionType,amount] = oscMessage.address.split('/');
  console.log("ActionType: " + actionType);
  console.log("Duration: " + duration);
  console.log("Selector: " + selector);
  console.log("Amount1: " + amount);

  if (actionType == 'flash') {
    $(selector).show();
    await new Promise(resolve => setTimeout(resolve, duration));
    $(selector).hide();

    // $(selector).velocity({ "color" : "red" });
  }

  if (actionType == 'pulse') {
    $(selector).fadeIn(duration/2);
    await new Promise(resolve => setTimeout(resolve, duration/2));
    $(selector).fadeOut(duration/2);
  }

  if (actionType == 'rotate') {
    $(selector).animate({deg: amount}, {
      duration: duration,
      step: function(now) {
        // in the step-callback (that is fired each step of the animation),
        // you can use the `now` paramter which contains the current
        // animation-position (`0` up to `angle`)
        $(selector).css({
          transform: 'rotate(' + now + 'deg)'
        });
      }
    });
  }

  if (actionType == 'translateX') {
    $(selector).animate({ top: '-=' + amount + 'px' }, duration);
  }

  console.log(oscMessage.address.split('/'));
  // console.log("message", oscMessage['address']);
});

port.open();

// BD should step through the first haus, keys through the second
// sub bass should swell the size of the large haus, thorny_melody should swell the second
//