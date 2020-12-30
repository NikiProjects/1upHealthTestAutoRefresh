- Location of project on C drive: C:\Users\Nikita\Nex-G-wkspace\TestAutoRefresh

About this project: 


How to run this project: 
The project runs on Tomcat 7 Server. Specifically, 

- Specify here which file, we need to run on Tomcat 7 Server. Specifically we need to run the file oneUpHealthResourceParser.jsp on Tomcat 7 Server. 

- Running the oneUpHealthResourceParser.jsp file on Tomcat 7 Server will present a form to the user in which the user will enter the patient id. 

- Based on the patient id, the 1upHealth $everything API will be invoked. This program logic will parse thru the 
json response for a given patient, to collect the resource types associated with this patient. The program logic 
identifies the unique resources associated with a given patient and calculates a count for each unique resource. This information is sent to the NodeJS Server, and the NodeJS Server outputs this information to a file located on the file system. 

How to use the NodeJS Server: 
To start the NodeJS Server, navigate into file path C:\Users\Nikita\Nex-G-wkspace\TestAutoRefresh\WebContent> and then run the command 'node nodeJsServer.js' from the command prompt. In this specified command the file nodeJsServer.js can be found in the WebContent directory. 
Please note that:
- the NodeJS Server runs on port 8082. 
- the Tomcat 7 Server runs on port 8081. 
- this implementation has been tested on Windows machine. 


Dependencies used our implemented and customized NodeJS Server: 
1) C:\Users\Nikita\Nex-G-wkspace\TestAutoRefresh>npm install express --save
npm WARN saveError ENOENT: no such file or directory, open 'C:\Users\Nikita\Nex-G-wkspace\TestAutoRefresh\package.json'
npm notice created a lockfile as package-lock.json. You should commit this file.
npm WARN enoent ENOENT: no such file or directory, open 'C:\Users\Nikita\Nex-G-wkspace\TestAutoRefresh\package.json'
npm WARN TestAutoRefresh No description
npm WARN TestAutoRefresh No repository field.
npm WARN TestAutoRefresh No README data
npm WARN TestAutoRefresh No license field.

+ express@4.17.1
added 50 packages from 37 contributors and audited 50 packages in 3.503s
found 0 vulnerabilities

2) C:\Users\Nikita\Nex-G-wkspace\TestAutoRefresh>npm install body-parser --save
npm WARN saveError ENOENT: no such file or directory, open 'C:\Users\Nikita\Nex-G-wkspace\TestAutoRefresh\package.json'
npm WARN enoent ENOENT: no such file or directory, open 'C:\Users\Nikita\Nex-G-wkspace\TestAutoRefresh\package.json'
npm WARN TestAutoRefresh No description
npm WARN TestAutoRefresh No repository field.
npm WARN TestAutoRefresh No README data
npm WARN TestAutoRefresh No license field.

+ body-parser@1.19.0
updated 1 package and audited 88 packages in 1.244s
found 0 vulnerabilities

The following dependency is needed for cross server communication.
3) C:\Users\Nikita\Nex-G-wkspace\TestAutoRefresh>npm install cors --save
npm WARN saveError ENOENT: no such file or directory, open 'C:\Users\Nikita\Nex-G-wkspace\TestAutoRefresh\package.json'
npm WARN enoent ENOENT: no such file or directory, open 'C:\Users\Nikita\Nex-G-wkspace\TestAutoRefresh\package.json'
npm WARN TestAutoRefresh No description
npm WARN TestAutoRefresh No repository field.
npm WARN TestAutoRefresh No README data
npm WARN TestAutoRefresh No license field.

+ cors@2.8.5
added 2 packages from 2 contributors and audited 90 packages in 9.138s
found 0 vulnerabilities

Tested with the following patient id's: 
- e467f71f186f
- 2fbbf941fb26

 

