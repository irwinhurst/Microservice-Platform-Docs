<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:include href="Canvas.xslt"/>
<xsl:output method="html"/>

<xsl:template match="/">

<html class="no-js" lang="en">
<head>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>Microservice Canvas</title>
<!-- Compressed CSS -->
<link href="http://getbootstrap.com/docs/4.1/dist/css/bootstrap.min.css" rel="stylesheet"/>
<link href="http://getbootstrap.com/docs/4.1/examples/dashboard/dashboard.css" rel="stylesheet"/>
</head>
<body>
<nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
    <a class="navbar-brand col-sm-3 col-md-2 mr-0" href="#">Microservice Canvas</a>
     
    </nav>

<div class="container-fluid">
      <div class="row">
        <nav class="col-md-2 d-none d-md-block bg-light sidebar">
          <div class="sidebar-sticky">
            <ul class="nav flex-column">
              <li class="nav-item">
                <a class="nav-link active" href="#">
                  <span data-feather="home"></span>
                  Dashboard <span class="sr-only">(current)</span>
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="file"></span>
                  Service Details
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#alldatabases">
                  <span data-feather="shopping-cart"></span>
                  Databases
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#allpublishers">
                  <span data-feather="users"></span>
                  Messages
                </a>
              </li>
              
            </ul>

            
          </div>
        </nav>
    <!-- TITLE -->
    

    <main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
          <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
            <h1 class="h2">
                <xsl:value-of select="/Release/@Name"/>
                <small class="text-muted">  Date:<xsl:value-of select="/Release/@Date"/>  Label:<xsl:value-of select="/Release/@Label"/></small>
            </h1>
            
          </div>
    <h2>Services</h2>
            <!-- SERVICE CARDS -->
            <div class="row">
                <xsl:for-each select="/Release/Services/Service">
                  <xsl:variable name="serviceInfo" select="document(Path)"></xsl:variable>
                    <xsl:call-template name="ServiceCard">
                    <xsl:with-param name="serviceInfo" select="$serviceInfo" />
                    <xsl:with-param name="serviceName" select="Name" />
                    </xsl:call-template>
                </xsl:for-each>
            </div>  
            <br/> 
            <h2>Service Details</h2>
                <xsl:for-each select="/Release/Services/Service">
                    <div class="row">
                    <xsl:call-template name="ServiceCanvas">
                        <xsl:with-param name="serviceInfo" select="document(Path)" />
                    </xsl:call-template>
                    </div>    
                </xsl:for-each>
            <div class="row">
                <xsl:call-template name="DatabaseSection"></xsl:call-template>
             </div>    
            <div class="row">
                <xsl:call-template name="AllPublishers"></xsl:call-template>
             </div>    
               
            
            
        </main>
      </div>
    </div>

    <script src="http://getbootstrap.com/docs/4.1/dist/js/bootstrap.min.js"></script>
</body>
</html>
</xsl:template>


 <xsl:template name="ServiceCard">
    <xsl:param name="serviceInfo" />
    <xsl:param name="serviceName" />

    <div class="col-sm-4" style="display: flex;padding-bottom: 5px;padding-top: 5px;">
        <div class="card border-dark shadow">
            <div class="card-body">
                <h5 class="card-title"><xsl:value-of select="$serviceName"/>
                <small class="text-muted"><text> - </text>
                    <xsl:value-of select="$serviceInfo/Info/Iterations/Iteration[1]/@Name"/>
                </small>
                </h5>
                <p class="card-text">
                            <xsl:value-of select="$serviceInfo/Info/Documentation/Description"/>
                </p>             
            </div>
        </div>  
    </div>
</xsl:template>


<xsl:template name="DatabaseSection">
  <a id="alldatabases">
      <h2>All Databases</h2>
    </a>
        <div class="table-responsive">
          <table class="table table-striped table-sm table-bordered">
            <thead>
              <tr>
                <th>Service</th>
                <th>Name</th>
                <th>Source</th>
              </tr>
            </thead>
            <tbody>
              <xsl:for-each select="/Release/Services/Service">
                  <xsl:variable name="serviceInfo" select="document(Path)"></xsl:variable>
                    <xsl:call-template name="DatabaseList">
                    <xsl:with-param name="serviceInfo" select="$serviceInfo" />
                    <xsl:with-param name="serviceName" select="Name" />
                    </xsl:call-template>
                </xsl:for-each>
            </tbody>
          </table>
        </div>
</xsl:template>



<xsl:template name="DatabaseList">
    <xsl:param name="serviceInfo" />
    <xsl:param name="serviceName" />

    <xsl:for-each select="$serviceInfo/Info/Databases/Database">
      <tr>
        <td>
          <xsl:value-of select="$serviceName"/>
        </td>
        <td>
          <xsl:value-of select="@Name"/>.<xsl:value-of select="@Schema"/>
        </td>
        <td>
          <xsl:value-of select="@SourcePath"/>
        </td>
      </tr>
    </xsl:for-each>
    <xsl:for-each select="$serviceInfo/Info/Dependencies/Resource[@Type = 'Database']">
      <tr>
        <td>
          <xsl:value-of select="$serviceName"/>
        </td>
        <td>
          <xsl:value-of select="@Name"/>
        </td>
        <td>
          
        </td>
      </tr>
    </xsl:for-each>
</xsl:template>

<xsl:template name="AllPublishers" >
    <a id="allpublishers">
      <h2>All Pubished Messages</h2>
    </a>
    <div class="table-responsive">
      <table class="table table-striped table-sm table-bordered">
        <thead>
          <tr>
            <th>Name</th>
            <th>Messages</th>
          </tr>
        </thead>
        <tbody>
          <xsl:for-each select="/Release/Services/Service">
            <xsl:for-each select="document(Path)">
              <tr>
                <td>
                  <xsl:value-of select="/Info/Name"/>
                </td>
                <td>
                  <xsl:value-of select="/Info/Interface/Publishes/Message"/>
                </td>
              </tr>
            </xsl:for-each>
          </xsl:for-each>

        </tbody>
      </table>
    </div>
  </xsl:template>



</xsl:stylesheet>