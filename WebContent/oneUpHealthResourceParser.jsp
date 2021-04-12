<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>


<script src="https://unpkg.com/react@16/umd/react.production.min.js"></script>
<script src="https://unpkg.com/react-dom@16/umd/react-dom.production.min.js"></script>
<script src="https://unpkg.com/babel-standalone@6.15.0/babel.min.js"></script>


<div id="rootContainer"></div>

<body>

<script type="text/babel">

//localStorage.clear();

var total = 0;
var patientFullCollectionFhirRes = [];


class PatientDataForm extends React.Component {



constructor(props) {
	super(props);
    this.state = {value: '', responselements: '',};
	
	this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
 	this.capture1UpHealthApiResponse = this.capture1UpHealthApiResponse.bind(this);
//	this.timeoutFunc = this.timeoutFunc.bind(this);
//	this.newprocess = this.newprocess.bind(this);
	


}


handleChange(event) {
    this.setState({value: event.target.value});
  }



capture1UpHealthApiResponse(patientId){
var promiseArr = [];
var submittedRequestCounter = 0; 
var totalNumOfFhirRes = 0;
var pageNumber = 0;
//var pageNumber = 250;
var totalNumOfPagesRounded;
var block1Completed = false;
var block2Completed = false;
var allFhirResTypeArr = [];

var requesturl = "https://api.1up.health/fhir/dstu2/Patient/" + patientId + "/$everything";
var bearer = 'Bearer c2b501249b87c926a1a253a226f27871528e4097' ;
var initialPromise1 = fetch(requesturl, {
        method: 'GET',
        headers: {
            'Authorization': bearer,
            'Content-Type': 'application/json'
        }
    });


var initialPromise2 = initialPromise1.then(response => response.json());

var initialPromise3 = initialPromise2.then(data => {
this.setState({responselements:data});
totalNumOfFhirRes = this.state.responselements.total;

var totalNumOfPages = totalNumOfFhirRes/10;

totalNumOfPagesRounded = Math.ceil(totalNumOfPages);


block1Completed = true;

}

);

var interval = setInterval(function(){ 
console.log("Executing setInterval body");
if(block1Completed === true)
{

do{
timeoutFunc();
//setTimeout(function(){ console.log("invoked setTimout # 2"); }, 2000);

var requesturl = "https://api.1up.health/fhir/dstu2/Patient/" + patientId + "/$everything?_skip=" + pageNumber;
console.log("request url: " + requesturl);
var bearer = 'Bearer c2b501249b87c926a1a253a226f27871528e4097' ;
var firstPromise = fetch(requesturl, {
        method: 'GET',
        headers: {
            'Authorization': bearer,
            'Content-Type': 'application/json'
        }
    });


promiseArr.push(firstPromise);

pageNumber = pageNumber + 10; 
submittedRequestCounter++;

}
while(submittedRequestCounter < totalNumOfPagesRounded); 
//while(submittedRequestCounter < 15); 

clearInterval(interval); 

console.log("total num of pages rounded: " + totalNumOfPagesRounded);
console.log("promise arr: " + promiseArr.toString());
console.log("promise arr length: " + promiseArr.length);
block2Completed = true;

}

if(block2Completed === true){
Promise.all(promiseArr).then(
promiseArray => {
var promiseArrLength = promiseArray.length;


/*
//test = setInterval(function(){ process(promiseArrayElement.json()); }, 3000);
promiseArray.forEach(promiseArrayElement=>{
//setTimeout(function(){ console.log("pausing do/while loop for 10 sec ......"); }, 3000);
//process(promiseArrayElement.json());
newprocess(promiseArrayElement.json(),);
//processArray(patientFullCollectionFhirRes);
}); // end of for each

*/



promiseArray.forEach(promiseArrayElement=>{
var indexOfElement = promiseArray.indexOf(promiseArrayElement);
var isLastIndex = false;
if(indexOfElement == promiseArrLength - 1){

isLastIndex = true;

}

newprocess(promiseArrayElement.json(), isLastIndex, patientId);

}); // end of for each




}//end of inner code block


);

} // end of if


}, 3000);


// this.setState({responselements:data});


} // end of my main method







handleSubmit(event) {
    event.preventDefault();
//	localStorage.clear();
	var patientId = this.state.value;
console.log("Patient Id received in handleSubmit function: " + patientId);

console.log("Contacting 1upHealth API...");
document.getElementById("container1").innerHTML = "Script is running. Please wait on this page... You will be notified when script finishes.";
this.capture1UpHealthApiResponse(patientId);



console.log("Finished executing click of onSubmit function");

}


render() {

//localStorage.clear();
    return (
	<div>
      <form onSubmit={this.handleSubmit}>
        <label>
          PatientId:
		  <input type="text" value={this.state.value} onChange={this.handleChange} />
        </label>
        <input type="submit" value="Submit"/>
      </form>
	<br/>
	<div id="containerTotalNumOfRes"></div>
	<div id="container1"></div>

	<br/>
</div>
);


}

}

ReactDOM.render(<PatientDataForm/>,document.getElementById("rootContainer"));




let newprocess = (prom1,isLastProm,patientId) =>{
prom1.then(
function(data) {
console.log('data within this promise object', data);
var entryArr;
var lengthOfEntryArr;
var entryArrCounter;
var pageUrl;
var entryElementResourceType;


if(data)
{

console.log("isLastProm in array: " + isLastProm);

var linkArr = data.link;

if(linkArr){
if(linkArr.length != 0)
{
pageUrl = linkArr[0].url;

}
}


entryArr = data.entry;
lengthOfEntryArr = entryArr.length;

if(lengthOfEntryArr != 0)
{

total = total + lengthOfEntryArr;
for (entryArrCounter = 0; entryArrCounter < lengthOfEntryArr; entryArrCounter++) {
var entryElementResource = entryArr[entryArrCounter].resource;


if(entryElementResource){
entryElementResourceType = entryElementResource.resourceType;
patientFullCollectionFhirRes.push(entryElementResourceType);
}

console.log("resourceType: " + entryElementResourceType + " page url: " + pageUrl + " lengthOfEntryArr: " + lengthOfEntryArr);

} // end of entry array for loop
}  // end analyze entry array



console.log("Total # FHIR res in newly created array: " + total);

if(isLastProm){
processArray(patientFullCollectionFhirRes,patientId);

}


}

});



}





function processArray(collection,patientId){
var uniqueResArr = collection.filter((v, i, a) => a.indexOf(v) === i);
var uniqueResArrIterator; 
for(uniqueResArrIterator = 0; uniqueResArrIterator < uniqueResArr.length; uniqueResArrIterator++){
var uniqueRes = uniqueResArr[uniqueResArrIterator];
console.log("unique FHIR res: " + uniqueRes.toString());

}

countNumberOfUniqueRes(uniqueResArr, collection,patientId);


}


function timeoutFunc(){
var i = 0;
  while (i < 60000) {
    (function(i) {
      setTimeout(function() {
		
      }, 5000)
    })(i++)
  }
console.log("finished timeoutFunc");
}

function countNumberOfUniqueRes(uniqueResCollection, completeResCollection,patientId){

var allPatientResIterator; // checked
var uniqueResArrIterator; // checked
var resTypeCounter; // checked
var uniqueRes; // checked
var resSummary; // checked
var resSummaryArr = []; // checkedd

for(uniqueResArrIterator = 0; uniqueResArrIterator < uniqueResCollection.length; uniqueResArrIterator++){
uniqueRes = uniqueResCollection[uniqueResArrIterator];
if(uniqueRes){
resTypeCounter = 0;

	for (allPatientResIterator = 0; allPatientResIterator < completeResCollection.length; allPatientResIterator++) {
		var completeResCollectionElement = completeResCollection[allPatientResIterator];
		if(uniqueRes === completeResCollectionElement)
			{
				resTypeCounter++;
			}

	} // end of for loop

resSummary = uniqueRes + "_" + resTypeCounter;
resSummaryArr.push(resSummary);

}
}   // end of outer for loop

console.log(resSummaryArr.toString());

sendReqToNodeJsServer(resSummaryArr,patientId);
}


function sendReqToNodeJsServer(patientResTypeData,patientId){

//var urlWritePatientRes = "http://localhost:8082/writePatientResType/?values="+ patientResTypeData;
var urlWritePatientRes = "http://localhost:8082/writePatientResType/?values="+ patientResTypeData +"&"+ "id=" + patientId;

var promiseFromNodeJsServer = fetch(urlWritePatientRes,{
        method: 'GET',
				headers: {
            'Content-Type': 'application/json'
        }
		}).then((resnodejs) =>{
//document.body.innerHTML = "Finished processing request.";
document.getElementById("container1").innerHTML = "Successfully wrote to file resourceSummary.txt a current summary of this patient's resources";
if(resnodejs){
console.log("completed analysis for this patient id");
//document.write("Hello World!");
}
else{
console.log("problem performing analysis for this patient id");
}
});
		
}
</script>

</body>
</html>