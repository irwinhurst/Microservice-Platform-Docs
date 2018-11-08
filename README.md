# Microservice-Platform-Docs
A set of XML files and style sheets to document all the microservices in your platform.

## Inspired by these articles
https://dzone.com/articles/streamlined-microservice-design-in-practice

https://dzone.com/articles/a-readme-for-your-microservice-github-repository

## Example
http://htmlpreview.github.io/?https://github.com/irwinhurst/Microservice-Platform-Docs/blob/master/release.html



## Directions:
1. Make a copy the **template.info.xml** file into the root folder of each service.  This is where you will fill in the details of your service.
2. Rename the file and replace template with the name of your service. For example: cartservice.info.xml
3. Copy all the canvas.xslt, service.xslt, release.xslt and release.xml, to the parent folder above all of your services. Or to your release folder.
4. The **release.xml** file is where you will document the high level information about a full platform release. It will also include a list of all the services you are including in your release.
5. From the parent folder where you created your release.xml file, execute a tranform to generate the release.html file
Command Line
```
C:\Program Files\Saxonica\SaxonHE9.8N\bin\transform -s:release.xml -xsl:canvas.xslt -o:release.html
```



| **Field**  | **Description** |
| ------------- | ------------- |
|Name:                  |    The name of your service          |
|Iteration:            |    A link to the current iteration you are working on.  When pushed with a release this is the released iteration          |
|**Documentation:**    These fields are used to document or link to the business documentation and requirements          |
|Description:           |    A business description of your service and its features          |
|Backlog:               |   A link to your backlog           |
|Source:                |   A link to the location of your source control           |
|Owner:                 |    Ussually a team lead or the team name if you have one. This is the main point of contact for more information.          |
|Domains:               |   In an ideal world each microservice controls a single domain. However in the real world a service can be a hybrid or a legacy monolith that responsible for multiple domains.           |
| **Interface:**                The next few feilds help document the public face of your service           |
|API:                 |     A link to your swagger file or other type of documentation         |
|Publishes:             |   A list of messages that your service publishes           |
|Subscribes:            |   A list of messages that your service subscribes to           |
|CommandHandlers:       |   A list of command messages that your service handles           |
|**Databases:**             This area help keep track of the databases required for your application. Things like a "logging: database can be documented here or as a dependency.          |
|Name:                  | The name of your database              |
|Schema:                | The name of your schema if you are using schema isolation in your services             |
|Location:              | A link to the source control for your database, not a connection string./             |
|**Configuration:**         | This section documentation any configuration information needed by your service such as files, connection names, licenses, etc. Needed when setting up deployments.             |
|Config:                  | A single config resource with a name and type             |
|**Dependencies:**          | This is a critical section that documents the run time dependencies of your service.  Any remote service calls, or external databases such as logging or auditing, Redis, etc. Anything that will stop your service from working if it isn't available.  Sometimes even sending a Command Message can be a dependency if the service is expecting a response.           |
|Resource:                  | A single dependency with a name and a type              |

