var express = require('express');
var app = express();
var portNum = 8080;

app.use(function(req, res, next) {
  res.header("Access-Control-Allow-Origin", "*");
  res.header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");
  next();
});

app.get('/', function (req, res) {
	console.log("...")
  res.send("send a start or end request");
})

app.get('/start', function (req, res) {
  // console.log(req)
  console.log(res.headers)
	console.log("Drone started...")
  res.send("Drone started...");
})

app.get('/end', function (req, res) {
  console.log(req)
	console.log("Drone stopped...")
  res.send("Drone stopped...");
})

var server = app.listen(portNum, function () {

  var host = server.address().address
  var port = server.address().port

  console.log("Test Drone server listening at localhost:" + port);

})