$('document').ready( function(){
  // Set up and connect to the web socket
  var port = new osc.WebSocketPort({
    url: "ws://localhost:8081"
  });
  port.open();

  console.log("port is open");
  console.log(port);


  var visualizationFunctions = {
    '/flash': flash,
  };

  // catch and process osc messages
  port.on("message", async function (oscMessage) {
    visualizationFunctions[oscMessage.address](oscMessage.args);
    console.log("args");
    console.log(oscMessage.args);
  });
});