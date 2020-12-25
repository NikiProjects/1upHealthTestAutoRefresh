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


class PatientDataForm extends React.Component {



constructor(props) {
	super(props);
    this.state = {value: '', responselements: '',};
	
	this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
 	this.runAsyncTask = this.runAsyncTask.bind(this);
	
	


}


handleChange(event) {
    this.setState({value: event.target.value});
  }



runAsyncTask(patientId){
//localStorage.clear();

var counter = 0;
var loopcounter = 0; 
var resTypeList = [];
var resCount = 0;
var totalNumOfFhirRes = 0;
var currentlyBusy = true;
localStorage.setItem("threadBusy",currentlyBusy);

do{
setTimeout(function(){ console.log("invoked setTimout # 1"); }, 1000);
loopcounter = loopcounter + 1;
counter = counter + 10; 
//counter = 310;

console.log("enter do: " + patientId);
var requesturl = "https://api.1up.health/fhir/dstu2/Patient/" + patientId + "/$everything?_skip=" + counter;
var bearer = 'Bearer 4dd25ac3a5d0e67bdaf5cf6fe5ea737b4b073ebd' ;
console.log("requesturl: " + requesturl);


var promise1 = fetch(requesturl, {
        method: 'GET',
        headers: {
            'Authorization': bearer,
            'Content-Type': 'application/json'
        }
    });


var promise2 = promise1.then(response => response.json());

var promise3 = promise2.then(data => {
this.setState({responselements:data});


totalNumOfFhirRes = this.state.responselements.total;
localStorage.setItem("lastname", "Smith");
localStorage.setItem("totalNumOfFhirRes", totalNumOfFhirRes);


console.log("The total number of FHIR resources is: " + totalNumOfFhirRes);
document.getElementById("containerTotalNumOfRes").innerHTML = "Total num of res : " + totalNumOfFhirRes;

var entryArr = this.state.responselements.entry;

var lengthOfEntryArr = entryArr.length;
localStorage.setItem("lengthOfEntryArr",lengthOfEntryArr);
console.log("lengthOfEntryArr: " + lengthOfEntryArr);

var remainder = totalNumOfFhirRes%10;
console.log("remainder: " + remainder);

var totalNumOfPages = totalNumOfFhirRes/10;

var totalNumOfPagesRounded = Math.ceil(totalNumOfPages);
console.log("roundedNum " + totalNumOfPagesRounded);
localStorage.setItem("totalNumOfPagesRounded",totalNumOfPagesRounded);

// begin 1st for loop

console.log("lengthOfEntryArr " + lengthOfEntryArr);

var forLoopCounter;
for (forLoopCounter = 0; forLoopCounter < lengthOfEntryArr; forLoopCounter++) {
try{
console.log("invoked for loop1");
resCount++;
var entryArrElement = entryArr[forLoopCounter];


var entryResource = entryArrElement.resource;
var resourceType = entryResource.resourceType;

localStorage.setItem("key" + resCount, resourceType);


console.log("pushed value " + resourceType);

}
catch(e){
console.log("Detected problem" + e);
}

}  // end first for loop


localStorage.setItem("resCountForLoop1", resCount);
console.log("TotalForLoop1 " + resCount);


console.log("Reached end of then function");

}



); // end of then function


console.log(localStorage.getItem("lastname"));
var retrTotalNumOfPagesRounded = localStorage.getItem("totalNumOfPagesRounded");

console.log("loop counter " + loopcounter);

}
while(loopcounter < localStorage.getItem("totalNumOfPagesRounded")); 

currentlyBusy = false;
localStorage.setItem("threadBusy",currentlyBusy);


console.log("totalNumOfPagesRounded in session storage: " + retrTotalNumOfPagesRounded);



var collectedResArr = [];

var resCountForLoop2;
var resCount2 = 0;
var keyName = "key";
var retrThreadBusy;
console.log("before for loop 2: " + localStorage.getItem("totalNumOfFhirRes"));



setTimeout(function(){ console.log("invoked setTimout # 2"); }, 5000);


for (resCountForLoop2 = 0; resCountForLoop2 < localStorage.getItem("totalNumOfFhirRes"); resCountForLoop2++) {
resCount2++;
console.log("resCount2 inside: " + resCount2);
var entryArrItem = localStorage.getItem("key" + resCount2);


collectedResArr.push(entryArrItem);
console.log("value pushed to my array " + entryArrItem);



}   // end 2nd for loop


console.log("resCount2 outside: " + resCount2);

//var urlgetdbrecs = "http://localhost:8082/getPatientRecord/?id="+ patientId;
//var sendSortedArr = "http://localhost:8082/sendarray/?array="+ collectedResArr;



}





handleSubmit(event) {
    event.preventDefault();
//	localStorage.clear();
	var patientId = this.state.value;
console.log("Patient Id received in handleSubmit function: " + patientId);

console.log("Contacting 1upHealth API...");
this.runAsyncTask(patientId);



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










</script>

</body>
</html>