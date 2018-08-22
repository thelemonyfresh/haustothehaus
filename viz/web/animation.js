var port = new osc.WebSocketPort({
  url: "ws://localhost:8081"
});

function sleep(ms) {
}

port.on("message", async function (oscMessage) {
  var [,duration,selector,actionType] = oscMessage.address.split('/');

  if (actionType == 'flash') {
    console.log(duration);
    console.log(selector);

    $(selector).show();
    await new Promise(resolve => setTimeout(resolve, duration));
    $(selector).hide();

    // $(selector).velocity({ "color" : "red" });
  }




  console.log(oscMessage.address.split('/'));
  // console.log("message", oscMessage['address']);
});

port.open();

// BD should step through the first haus, keys through the second
// sub bass should swell the size of the large haus, thorny_melody should swell the second
//