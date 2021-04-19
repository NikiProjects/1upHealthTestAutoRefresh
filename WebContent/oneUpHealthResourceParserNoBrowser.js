//localStorage.clear();

const fetch = require("node-fetch");
require("core-js");

var total = 0;
var patientFullCollectionFhirRes = [];
var newprocessCounter = 0;











function capture1UpHealthApiResponse(patientId){
var state;
//patientId = "efcfce77bd6e";
var promiseArr = [];
var submittedRequestCounter = 0; 
var totalNumOfFhirRes = 0;
var pageNumber = 0;
//var pageNumber = 250;
var totalNumOfPagesRounded;
var block1Completed = false;
var block2Completed = false;
var allFhirResTypeArr = [];
var copyArr = [];

var requesturl = "https://api.1up.health/fhir/dstu2/Patient/" + patientId + "/$everything";
var bearer = 'Bearer cda1c6182679152d60e45c721147688a86a9fed8';
var initialPromise1 = fetch(requesturl, {
        method: 'GET',
        headers: {
            'Authorization': bearer,
            'Content-Type': 'application/json'
        }
    });


var initialPromise2 = initialPromise1.then((response) => response.json());

var initialPromise3 = initialPromise2.then(data => {
//this.setState({responselements:data});
state = data;
//console.log("debug state: " + state);
totalNumOfFhirRes = state.total;
//console.log("syntax change: " + totalNumOfFhirRes);

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
var bearer = 'Bearer cda1c6182679152d60e45c721147688a86a9fed8';
var firstPromise = fetch(requesturl, {
        method: 'GET',
        headers: {
            'Authorization': bearer,
            'Content-Type': 'application/json'
        }
    });


timeoutFunc();
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
(promiseArray) => {

var promiseArrLength = promiseArray.length;
console.log("debug length: " + promiseArrLength);


timeoutFunc();


for (var mycount=0; mycount < promiseArrLength; mycount++)
{ 
    copyArr[mycount]= promiseArray[mycount];
}


promiseArray.forEach(promiseArrayElement=>{
timeoutFunc();

promiseArrayElement.json().then(
function(data) {
newprocess(data, patientId, totalNumOfPagesRounded);
}

);

//newprocess(promiseArrayElement.json(), isLastIndex, patientId, totalNumOfPagesRounded);



}); // end of for each




}//end of inner code block


).catch((error) => {
    console.log("hello Promise rejected", error);
});

} // end of if


}, 3000);


// this.setState({responselements:data});


} // end of my main method



















function newprocess(data,patientId,totalNumOfPgInRes){
newprocessCounter++;
timeoutFunc();


console.log('data within this promise object', data);
var entryArr;
var lengthOfEntryArr;
var entryArrCounter;
var pageUrl;
var entryElementResourceType;
//var lastPageAsStr = lastPage.toString();

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


//if(entryElementResource){
entryElementResourceType = entryElementResource.resourceType;
patientFullCollectionFhirRes.push(entryElementResourceType);
//}

console.log("resourceType: " + entryElementResourceType + " page url: " + pageUrl + " lengthOfEntryArr: " + lengthOfEntryArr);

} // end of entry array for loop
}  // end analyze entry array



console.log("Total # FHIR res in newly created array: " + total);

timeoutFunc();




// if(pageUrl.includes((pgCounter.toString())) === false){
if(totalNumOfPgInRes === newprocessCounter){
console.log("totalPg: " + totalNumOfPgInRes);
processArray(patientFullCollectionFhirRes,patientId);
}







//}

}














}


function processArray(collection,patientId){
var uniqueResArr = collection.filter((v, i, a) => a.indexOf(v) === i);
var uniqueResArrIterator; 
for(uniqueResArrIterator = 0; uniqueResArrIterator < uniqueResArr.length; uniqueResArrIterator++){
var uniqueRes = uniqueResArr[uniqueResArrIterator];
console.log("debug iterator: " + uniqueResArrIterator);
console.log("unique FHIR res: " + uniqueRes.toString());

}

countNumberOfUniqueRes(uniqueResArr, collection,patientId);


}


function timeoutFunc(){
  const date = Date.now();
  let currentDate = null;
  do {
    currentDate = Date.now();
  } while (currentDate - date < 4000);
}


function countNumberOfUniqueRes(uniqueResCollection, completeResCollection,patientId){

var allPatientResIterator; // checked
var uniqueResArrIterator; // checked
var resTypeCounter; // checked
var uniqueRes; // checked
var resSummary; // checked
var resSummaryArr = []; // checkedd
var loopCompleted = false;

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
loopCompleted = true;
}   // end of outer for loop

console.log(resSummaryArr.toString());

if(loopCompleted === true){
sendReqToNodeJsServer(resSummaryArr,patientId);


}
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

if(resnodejs){
console.log("completed analysis for this patient id");
//document.write("Hello World!");
}
else{
console.log("problem performing analysis for this patient id");
}
});
		
}

capture1UpHealthApiResponse("efcfce77bd6e");