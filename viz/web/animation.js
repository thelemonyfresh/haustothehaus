$('document').ready( function(){
  // Set up and connect to the web socket
  var port = new osc.WebSocketPort({
    url: "ws://localhost:8081"
  });
  port.open();

  console.log("port is open");
  console.log(port);

  // catch and process osc messages
  port.on("message", async function (oscMessage) {
    console.log("asdf");
    var [,duration,selector,actionType,val1,val2] = oscMessage.address.split('/');
    console.log("ActionType: " + actionType);
    console.log("Duration: " + duration);
    console.log("Selector: " + selector);
    console.log("Val1: " + val1);
    console.log("Val2: " + val2);

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

    if (actionType == 'text') {
      $(selector).prepend(val1 + " ");
    };

    if (actionType == 'falling_text') {
      fallingText(val1, duration);
    };
  });

  function fallingText(text, duration) {
    var elem = document.createElement("div");
    elem.textContent = text;
    elem.style.position = 'relative';
    elem.style.color = '#f9de2a';

    start_x = window.innerWidth * Math.random() + "px";
    start_y = window.innerHeight * Math.random() + "px";

    console.log(start_x);
    console.log(start_y);

    elem.style.left = start_x;
    elem.style.top = start_y;

    document.body.appendChild(elem);

    //sleep(duration);

    console.log("duration");
    console.log(Math.round(duration));
    //document.body.removeChild(elem);
    $(elem).animate({
      top: "-25%",
    }, Math.round(duration), function() {
      // Animation complete.
    });
  }

  function sleep(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
  }
});