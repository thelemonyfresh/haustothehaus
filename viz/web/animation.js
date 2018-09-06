// Set up and connect to the web socket
var port = new osc.WebSocketPort({
  url: "ws://localhost:8081"
});
port.open();

// catch and process osc messages
port.on("message", async function (oscMessage) {
  var [,duration,selector,actionType,val1] = oscMessage.address.split('/');
  console.log("ActionType: " + actionType);
  console.log("Duration: " + duration);
  console.log("Selector: " + selector);
  console.log("Val1: " + val1);

  if (actionType == 'flash') {
    $(selector).show();
    await sleep(duration);
    $(selector).hide();
  }

  if (actionType == 'pulse') {
    $(selector).velocity({ opacity: 0 }, {
      duration: duration/4,
      easing: 'easeOutCubix',
      queue: false
    });
    await sleep(duration/2);
    $(selector).velocity({ opacity: 1 },
                         { duration: 3*duration/2,
                           queue: false
                         });
  }

  if (actionType == 'rotate') {
    $(selector).animate({deg: val1}, {
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

  if (actionType == 'color') {
    $(selector).velocity({fill: val1 },
                         { duration: duration,
                           easing: 'easeOutCirc',
                           queue: false
                         });
  }
});

function sleep(ms) {
  return new Promise(resolve => setTimeout(resolve, ms));
}