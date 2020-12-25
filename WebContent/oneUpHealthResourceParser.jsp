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

class PatientDataForm extends React.Component {



constructor(props) {
	super(props);
    this.state = {value: '', responselements: '',};
	
	this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
 	this.capture1UpHealthApiResponse = this.capture1UpHealthApiResponse.bind(this);
//	this.timeoutFunc = this.timeoutFunc.bind(this);
	


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
var bearer = 'Bearer 9e857688f012249ac04c3961d853039117d8908f' ;
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
console.log("roundedNum " + totalNumOfPagesRounded);

block1Completed = true;
console.log("finished executing 1st block " + block1Completed);
}

);



var interval = setInterval(function(){ 
console.log("Executing setInterval body");
if(block1Completed === true)
{

console.log("Executing 2nd block");
do{
console.log("Inside do while loop");
timeoutFunc();
//setTimeout(function(){ console.log("invoked setTimout # 2"); }, 2000);

submittedRequestCounter++;
pageNumber = pageNumber + 10;  


var requesturl = "https://api.1up.health/fhir/dstu2/Patient/" + patientId + "/$everything?_skip=" + pageNumber;
console.log("request url: " + requesturl);
var bearer = 'Bearer 9e857688f012249ac04c3961d853039117d8908f' ;
var firstPromise = fetch(requesturl, {
        method: 'GET',
        headers: {
            'Authorization': bearer,
            'Content-Type': 'application/json'
        }
    });


promiseArr.push(firstPromise);

}
while(submittedRequestCounter < totalNumOfPagesRounded); 
//while(submittedRequestCounter < 15); 

clearInterval(interval); 

console.log("total num of pages rounded: " + totalNumOfPagesRounded);
console.log("promise arr: " + promiseArr.toString());
console.log("promise arr length: " + promiseArr.length);
block2Completed = true;

}
console.log("Finished executing 2nd block");


if(block2Completed === true){
Promise.all(promiseArr).then(
promiseArray => {
//test = setInterval(function(){ process(promiseArrayElement.json()); }, 3000);
promiseArray.forEach(promiseArrayElement=>{
//setTimeout(function(){ console.log("pausing do/while loop for 10 sec ......"); }, 3000);
//process(promiseArrayElement.json());
newprocess(promiseArrayElement.json());
}); // end of for each




}//end of inner code block


);

} // end of if


}, 3000);

console.log("Exited from setInterval function");






// this.setState({responselements:data});


} // end of my main method







handleSubmit(event) {
    event.preventDefault();
//	localStorage.clear();
	var patientId = this.state.value;
console.log("Patient Id received in handleSubmit function: " + patientId);

console.log("Contacting 1upHealth API...");
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
	<br/>
</div>
);


}

}

ReactDOM.render(<PatientDataForm/>,document.getElementById("rootContainer"));






let newprocess = (prom1) =>{
prom1.then(
function(data) {
console.log('all is complted', data);
var entryArr;
var lengthOfEntryArr;
var entryArrCounter;
var pageUrl;
var entryElementResourceType;


if(data)
{

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
}

console.log("resourceType: " + entryElementResourceType + " page url: " + pageUrl + " lengthOfEntryArr: " + lengthOfEntryArr);

} // end of entry array for loop
}  // end analyze entry array



console.log("My total: " + total);

//var resource = data.resource;
//var resourceType = resource.resourceType;


}

});
}

function timeoutFunc(){
var i = 0;
  while (i < 50000) {
    (function(i) {
      setTimeout(function() {
		
      }, 1000 * i)
    })(i++)
  }
console.log("finished settimeout");
}


</script>

</body>
</html>