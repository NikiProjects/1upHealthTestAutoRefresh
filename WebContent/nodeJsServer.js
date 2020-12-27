const express = require('express');
const bodyParser = require('body-parser');
var cors = require('cors');

var app = express();

app.use(bodyParser.urlencoded({ extended: true })); 
app.use(cors());

app.get('/writePatientResType', function (req, res) {
	console.log("invoked new Node JS Server");
	
/*
	res.write('<html>');
	res.write('<head> <title> Patient Resources </title> </head>');
	res.write(' <body> <b>Patient resources types are now summarized in file </b></body>');
	res.write('</html>');
	//write end to mark it as stop for node js response.


	res.end();	
	
	
*/

	res.send('completed');	


}	);


//Setting up server
var server = app.listen(8082,function(){
    var port = server.address().port;
    console.log("New nodejs server now running on port ",port);
});