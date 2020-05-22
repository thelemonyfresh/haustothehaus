$('document').ready( function(){
  // Set up and connect to the web socket
  var port = new osc.WebSocketPort({
    url: "ws://localhost:8081"
  });
  port.open();

  console.log("port is open");
  console.log(port);


  var visualizationFunctions = {
    '/blink': blink,
    '/pulse': pulse,
    '/gif': gif
  };

  // catch and process osc messages
  port.on("message", async function (oscMessage) {
    console.log(`address: ${oscMessage.address}, args: ${oscMessage.args}`);
    console.log(oscMessage.args);

    visualizationFunctions[oscMessage.address](oscMessage.args);
  });
});