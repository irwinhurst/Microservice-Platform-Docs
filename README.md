# Microservice-Platform-Docs
An XML and style sheet to document all the microservices in your platform.
https://dzone.com/articles/streamlined-microservice-design-in-practice

https://dzone.com/articles/a-readme-for-your-microservice-github-repository


## Directions:
1. Copy the template.info.xml file into the root folder of each service.  
2. Rename it based on your service such as cartservice.info.xml
3. Copy all the canvas.xslt, service.xslt, release.xslt and release.xml, to the parent folder above all of your services. Or to your release folder.
4. Fill in the details for you release.xml and for each service, add a name and the path to all info.xml files.
5. From the parent folder where you created your release.xml file, execute a tranform to generate the release.html file
Command Line
C:\Program Files\Saxonica\SaxonHE9.8N\bin\transform -s:release.xml -xsl:canvas.xslt -o:release.html

transform -s:C:\Users\ihurst\source\repos\Microservice-Platform-Docs\release.xml -xsl:C:\Users\ihurst\source\repos\Microservice-Platform-Docs\canvas.xslt -o:release.html





| Field  | Description |
| ------------- | ------------- |
|Name:                  |    The name of your serice          |
|Description:           |    A business description of your service and its features          |
|Owner:                 |    Ussually a team lead or the team name if you have one. This is the main point of contact for more information.          |
|Domains:               |   In an ideal world each microservice controls a single domain. However in the real world a service can be a hybrid or a legacy monolith that responsible for multiple domains.           |
|Backlog:               |   A link to your backlog           |
|Iteration:            |    A link to the current iteration you are working on.  When pushed with a release this is the released iteration          |
|Source:                |   A link to the location of your source control           |
|Interface:             |   The next few feilds help document the public face of your service           |
|API:                 |     A link to your swagger file or other type of documentation         |
|Publishes:             |   A list of messages that your service publishes           |
|Subscribes:            |   A list of messages that your service subscribes to           |
|CommandHandlers:       |   A list of command messages that your service handles           |
|Databases:             |   This area help keep track of the databases required for your application. Things like a "logging: database can be documented here or as a dependency.          |
|Name:                  | The name of your database              |
|Schema:                | The name of your schema if you are using schema isolation in your services             |
|Location:              | A link to the source control for your database, not a connection string./             |
|Configuration:         | Any configuration information needed by your service such as files, connection names, licenses, etc             |
|Dependencies:          | This is a critical section that documents the run time dependencies of your service.  Any remote service calls, or external databases such as logging or auditing, Redis, etc. Anything that will stop your service from working if it isn't available.  Sometimes even sending a Command Message can be a dependency if the service is expecting a response.           |

