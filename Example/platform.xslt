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
                  Orders
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="shopping-cart"></span>
                  Products
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="users"></span>
                  Customers
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="bar-chart-2"></span>
                  Reports
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="layers"></span>
                  Integrations
                </a>
              </li>
            </ul>

            <h6 class="sidebar-heading d-flex justify-content-between align-items-center px-3 mt-4 mb-1 text-muted">
              <span>Saved reports</span>
              <a class="d-flex align-items-center text-muted" href="#">
                <span data-feather="plus-circle"></span>
              </a>
            </h6>
            <ul class="nav flex-column mb-2">
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="file-text"></span>
                  Current month
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="file-text"></span>
                  Last quarter
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="file-text"></span>
                  Social engagement
                </a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="#">
                  <span data-feather="file-text"></span>
                  Year-end sale
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
    
            <!-- SERVICE CARDS -->
            <div class="row">
                <xsl:for-each select="/Release/Services/Service">
                    <xsl:call-template name="ServiceCard">
                    <xsl:with-param name="serviceInfo" select="document(Path)" />
                    <xsl:with-param name="serviceName" select="Name" />
                    </xsl:call-template>
                </xsl:for-each>
            </div>  
            <br/> 
            
                <xsl:for-each select="/Release/Services/Service">
                    <div class="row">
                    <xsl:call-template name="ServiceCanvas">
                        <xsl:with-param name="serviceInfo" select="document(Path)" />
                    </xsl:call-template>
                    </div>    
                </xsl:for-each>
            
            
        </main>
      </div>
    </div>

 <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <![CDATA[<script>window.jQuery || document.write('<script src="http://getbootstrap.com/docs/4.1/assets/js/vendor/jquery-slim.min.js"><\/script>')</script>]]>
    <script src="http://getbootstrap.com/docs/4.1/assets/js/vendor/popper.min.js"></script>
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




</xsl:stylesheet>