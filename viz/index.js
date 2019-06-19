var osc = require("osc"),
    WebSocket = require("ws");

//
// Set up OSC UDP connection
//
var getIPAddresses = function () {
  var os = require("os"),
      interfaces = os.networkInterfaces(),
      ipAddresses = [];

  for (var deviceName in interfaces){
    var addresses = interfaces[deviceName];

    for (var i = 0; i < addresses.length; i++) {
      var addressInfo = addresses[i];

      if (addressInfo.family === "IPv4" && !addressInfo.internal) {
        ipAddresses.push(addressInfo.address);
      }
    }
    }

    return ipAddresses;
};

var udp = new osc.UDPPort({
    localAddress: "0.0.0.0",
    localPort: 7400
});

udp.on("ready", function () {
    var ipAddresses = getIPAddresses();
    console.log("Listening for OSC over UDP.");
    ipAddresses.forEach(function (address) {
        console.log("Host:", address + ", Port:", udp.options.localPort);
    });
});

udp.open();

//
// Set up WebSocket connection
//
var wss = new WebSocket.Server({
    port: 8081
});

wss.on("connection", function (socket) {
    console.log("A Web Socket connection has been established!");
    var socketPort = new osc.WebSocketPort({
        socket: socket
    });

    var relay = new osc.Relay(udp, socketPort, {
        raw: true
    });
});
