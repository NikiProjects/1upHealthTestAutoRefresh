const express = require('express');
const bodyParser = require('body-parser');
var cors = require('cors');
const fs = require('fs');


var app = express();

app.use(bodyParser.urlencoded({ extended: true })); 
app.use(cors());

app.get('/writePatientResType', function (req, res) {
	console.log("Node JS Server GET API invoked");
	
/*
	res.write('<html>');
	res.write('<head> <title> Patient Resources </title> </head>');
	res.write(' <body> <b>Patient resources types are now summarized in file </b></body>');
	res.write('</html>');
	//write end to mark it as stop for node js response.


	res.end();	
	
	
*/

	

	var resSummaryArr = req.query.values;
	console.log("resource summary array: " + resSummaryArr);
	
	var idOfPatient = req.query.id;
	console.log("id of patient: " + idOfPatient);
	
	var dateAndTs = new Date();
	
	var resSummaryArrAsStr;
	if(resSummaryArr.length === 0){
		resSummaryArrAsStr = "No resources found for this patient";
		
	}
	
	resSummaryArrAsStr = resSummaryArr.toString();
	var concatonatedStr = "\n \n \n RESOURCE SUMMARY FOR PATIENT ID: " + idOfPatient + " CREATED ON: " + dateAndTs + "\n" + resSummaryArrAsStr; 


	fs.appendFile('resourceSummary.txt',concatonatedStr, function (err) {
		  if (err) return console.log(err);
		  console.log('finished writing patient resources to file');
		  
		});
	
	
	res.send('completed');	


}	);


//Setting up server
var server = app.listen(8082,function(){
    var port = server.address().port;
    console.log("New nodejs server now running on port ",port);
});