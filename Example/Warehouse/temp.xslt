<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
                xmlns:hp="https://www.upmc.com/HealthPlaNET/Services"
                xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>

  <xsl:template match="/">
    <HTML>
      <HEAD>
        <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-WskhaSGFgHYWDcbwN70/dfYBj47jz9qbsMId/iRN3ewGhXQFZCSftd1LZCfmhktB" crossorigin="anonymous"/>
        <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.1/js/bootstrap.min.js" integrity="sha384-smHYKdLADwkXOn1EmN1qk/HfnUcbVRZyYmZ4qpPea6sjB/pTJ0euyQp0Mk8ck+5T" crossorigin="anonymous"></script>
        <script src="https://gojs.net/latest/release/go.js"></script>


        <script type="text/javascript">
          <xsl:text disable-output-escaping="yes">
          <![CDATA[ function init() {
          if (window.goSamples) goSamples();  // init for these samples -- you don't need to call this
          var $ = go.GraphObject.make;  // for conciseness in defining templates
          myDiagram = $(go.Diagram, "myDiagramDiv",  // create a Diagram for the DIV HTML element
                  {
                   initialAutoScale: go.Diagram.UniformToFill,  // automatically scale down to show whole tree
              maxScale: 0.75,
                  initialContentAlignment: go.Spot.Center,  // center the content
                  layout: $(go.TreeLayout,
                      { angle: 90, sorting: go.TreeLayout.SortingAscending })
                  });

// define the link template
      myDiagram.linkTemplate =
        $(go.Link,
          {
            selectionAdornmentTemplate:
              $(go.Adornment,
                $(go.Shape,
                  { isPanelMain: true, stroke: "dodgerblue", strokeWidth: 3 }),
                $(go.Shape,
                  { toArrow: "Standard", fill: "dodgerblue", stroke: null, scale: 1 })
              ),
            routing: go.Link.Normal,
            corner: 10,
            curve: go.Link.Bezier,
            toShortLength: 2
          },
          $(go.Shape,  //  the link shape
            { name: "OBJSHAPE" }),
           
          
        );
        myDiagram.groupTemplate =
      $(go.Group, "Vertical",
        { selectionObjectName: "PANEL",  // selection handle goes around shape, not label
          ungroupable: true },  // enable Ctrl-Shift-G to ungroup a selected Group
        $(go.TextBlock,
          {
            font: "bold 19px sans-serif",
            isMultiline: true,  // don't allow newlines in text
            editable: true  // allow in-place editing by user
          },
          new go.Binding("text", "text").makeTwoWay(),
          new go.Binding("stroke", "color")),
        $(go.Panel, "Auto",
          { name: "PANEL" },
          $(go.Shape, "Rectangle",  // the rectangular shape around the members
            {
              fill: "rgba(128,128,128,0.2)", stroke: "gray", strokeWidth: 3,
              width: 900, height: 400
            }),
          $(go.Placeholder, { margin: 10, background: "transparent" })  // represents where the members are
        )
        
      );


          // define a simple Node template
          myDiagram.nodeTemplate =
            $(go.Node, "Auto",  // the Shape will go around the TextBlock
              $(go.Shape, "Ellipse", { strokeWidth: 1},
                // Shape.fill is bound to Node.data.color
                new go.Binding("fill", "color"),
                new go.Binding("figure")
                ),
               $(go.TextBlock,
                  { margin: 8 },  // some room around the text
                  // TextBlock.text is bound to Node.data.key
                  new go.Binding("text", "text")
                  )
               );
          // but use the default Link template, by not setting Diagram.linkTemplate
          // create the model data that will be represented by Nodes and Links
          ]]></xsl:text>
          var nodeDataArray = [];
          var key = "";
          var node = {};
          var linkDataArray = [];
          var name = "";

          node = { key: "ServicesGroup" , text: "Services", figure: "Rectangle", color: "lightblue", isGroup: true };
          nodeDataArray.push(node);
          node = { key: "DBGroup" , text: "Databases", figure: "Rectangle", color: "lightgray", isGroup: true };
          nodeDataArray.push(node);

          <xsl:for-each select="/HealthPlanet/build">
            <xsl:call-template name="DrawModels">
              <xsl:with-param name="serviceDetails" select="document(path)" />
            </xsl:call-template>
          </xsl:for-each>
          <xsl:for-each select="/HealthPlanet/build">
            <xsl:call-template name="DrawLinks">
              <xsl:with-param name="serviceDetails" select="document(path)" />
            </xsl:call-template>
          </xsl:for-each>
          myDiagram.model = new go.GraphLinksModel(nodeDataArray, linkDataArray);
          }
        </script>
        <TITLE>
          <xsl:value-of select="/HealthPlanet/@ReleaseLabel"/>
        </TITLE>
      </HEAD>
      <BODY onload="init()">
        <div class="container-fluid">
          <div class="row-fluid">
            <div class="col-sm-12" style="margin-bottom:20; background-color: #563d7c;color: #fff;">
              <!--Header content-->

                  <h2>
                    <xsl:value-of select="/HealthPlanet/@ReleaseLabel"/>
                  </h2>
                  <ul style="color: #fff; ">
                    <li class="nav-item">
                      Iteration: <xsl:value-of select="/HealthPlanet/@Iteration"/>
                    </li>
                    <li class="nav-item">
                      Scheduled Release: <xsl:value-of select="/HealthPlanet/@ScheduledRelease"/>
                    </li>
                  </ul>
            </div>
          </div>
          <div class="row">
            <div class="col-lg-2">
              <!--side bar-->
              <nav class="d-none d-md-block bg-light sidebar">
                <div class="sidebar-sticky">
                  <xsl:call-template name="NavBar"/>

                </div>
              </nav>
            </div>
            <div class="ml-sm-auto col-lg-10 px-4">
              <!--Body content-->
              <div class="row">
                <div class="col">
                  <div class="card flex-md-row mb-4 shadow-sm h-md-250">
                    <div class="card-body d-flex flex-column align-items-start">
                      <xsl:call-template name="ServiceList"/>
                    </div>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col">
                  <div class="card flex-md-row mb-4 shadow-sm h-md-250">
                    <div class="card-body d-flex flex-column align-items-start">
                      <xsl:call-template name="CMSummary"/>
                    </div>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col">
                  <div class="card flex-md-row mb-4 shadow-sm h-md-250">
                    <div class="card-body d-flex flex-column align-items-start">
                      <xsl:call-template name="AllDatabases"/>
                    </div>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col">
                  <div class="card flex-md-row mb-4 shadow-sm h-md-250">
                    <div class="card-body d-flex flex-column align-items-start">
                      <xsl:call-template name="AllPublishers"/>
                    </div>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col">
                  <div class="card flex-md-row mb-4 shadow-sm h-md-250">
                    <div class="card-body d-flex flex-column align-items-start">
                      <a id="diagram">
                        <h2>System Diagram</h2>
                      </a>
                      <div id="myDiagramDiv" style="border: solid 1px black; width:1200px; height:600px"></div>
                    </div>
                  </div>
                </div>
              </div>
              <div class="row">
                <div class="col">
                  <div class="card shadow-sm">
                    <div class="card-header">
                      <a id="services">
                        <h2>Service Details</h2>
                      </a>
                    </div>
                    <div class="card-body d-flex flex-column align-items-start">
                      <xsl:call-template name="Details"/>
                    </div>
                  </div>
                </div>
              </div>
                

            </div>
          </div>
        </div>
        
        

        
      </BODY>
    </HTML>
  </xsl:template>

  <xsl:template name="NavBar" >
    <ul class="nav flex-column mb-2 nav-pills">
      <li class="nav-item">
        <a class="nav-link" href="#services">
          <h4>Services</h4>
        </a>
      </li>
      <xsl:for-each select="/HealthPlanet/build">
        <xsl:apply-templates select="document(path)/hp:systemDefinition/hp:System"/>
      </xsl:for-each>
      <li class="nav-item">
        <a class="nav-link" href="#CMSummary">
          <h4>CM Summary</h4>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#Databases">
          <h4>Databases</h4>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#allpublishers">
          <h4>Message Contracts</h4>
        </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#diagram">
          <h4>Diagram</h4>
        </a>
      </li>
    </ul>
  </xsl:template>


  <xsl:template name="ServiceList" >

    <div class="row">
      <xsl:for-each select="/HealthPlanet/build">
        <xsl:call-template name="ServiceCard">
          <xsl:with-param name="serviceDetails" select="document(path)" />
          <xsl:with-param name="serviceName" select="name" />
        </xsl:call-template>
      </xsl:for-each>
    </div>
  </xsl:template>

  <xsl:template name="DrawModels">
    <xsl:param name="serviceDetails" />
    <xsl:text disable-output-escaping="yes">
    key = "</xsl:text><xsl:value-of select="$serviceDetails/hp:systemDefinition/hp:System/hp:Name"/><xsl:text disable-output-escaping="yes">"</xsl:text>

    node = { key: key , text: key, color: "lightblue",group:"ServicesGroup" };
    nodeDataArray.push(node);
    <xsl:for-each select="$serviceDetails/hp:systemDefinition/hp:System/hp:Implementation/hp:Data/hp:Database">
      key = "<xsl:value-of select="@SourcePath"/>";
      name = "<xsl:value-of select="@Name"/>";

      if (nodeDataArray.filter(function(e) { return e.key === key; }).length == 0) {
      node = { key: key , text: name, figure: "Database", color: "lightgray", group:"DBGroup" };
      nodeDataArray.push(node);
      }
    </xsl:for-each>

  </xsl:template>

  <xsl:template name="DrawLinks">
    <xsl:param name="serviceDetails" />
    <xsl:for-each select="$serviceDetails/hp:systemDefinition/hp:System/hp:Implementation/hp:Data/hp:Database">
      <xsl:text disable-output-escaping="yes">
      from = "</xsl:text><xsl:value-of select="$serviceDetails/hp:systemDefinition/hp:System/hp:Name"/><xsl:text disable-output-escaping="yes">"
      to = "</xsl:text><xsl:value-of select="@SourcePath"/>"
      node = { from: from , to: to };
      linkDataArray.push(node);
    </xsl:for-each>

  </xsl:template>



  <xsl:template name="ServiceCard">
    <xsl:param name="serviceDetails" />
    <xsl:param name="serviceName" />

    <div class="col-sm-4" style="display: flex;">
      <div class="card border-dark mb-3 shadow" style="display: flex;">
        <div class="card-header">
          <h5 class="my-0 font-weight-normal">
            <xsl:value-of select="$serviceName"/>
          </h5>
        </div>
        <xsl:choose>
          <!-- if YOUR_STRING is greater than the MAXIMUM_LENGTH -->
          <xsl:when test="string-length($serviceDetails/hp:systemDefinition/hp:System/hp:Description ) &gt; 100 ">
            <div class="show multi-collapse" id="{$serviceDetails/hp:systemDefinition/hp:System/hp:Name}-multiCollapseExample1">
              <div class="card-body" >
                <p class="card-text">
                  <xsl:value-of select="substring($serviceDetails/hp:systemDefinition/hp:System/hp:Description,0, 100)"/>
                  <button class="btn btn-link" type="button" data-toggle="collapse" data-target=".multi-collapse" aria-expanded="false" aria-controls="{$serviceDetails/hp:systemDefinition/hp:System/hp:Name}-multiCollapseExample1 {$serviceDetails/hp:systemDefinition/hp:System/hp:Name}-multiCollapseExample2">...More</button>
                </p>
              </div>
            </div>
            <div class="collapse multi-collapse " id="{$serviceDetails/hp:systemDefinition/hp:System/hp:Name}-multiCollapseExample2">
              <div class="card-body" >
                <p class="card-text">
                  <xsl:value-of select="$serviceDetails/hp:systemDefinition/hp:System/hp:Description"/>
                </p>
              </div>
            </div>
          </xsl:when>
          <xsl:otherwise>
            <!-- otherwise print out the whole, un-truncated string -->
            <div class="card-body" >
              <p class="card-text">
                <xsl:value-of select="$serviceDetails/hp:systemDefinition/hp:System/hp:Description"/>
              </p>
            </div>
          </xsl:otherwise>
        </xsl:choose>

      </div>
    </div>
  </xsl:template>

  
  <xsl:template match="hp:System">
    <li class="nav-item">
      <a class="nav-link" href="#{hp:Source/hp:Application/@Name}">
        <xsl:value-of select="hp:Name"/>
      </a>
    </li>
  </xsl:template>

  <xsl:template name="Details" >
    <xsl:for-each select="/HealthPlanet/build">
      <div class="card">
        <xsl:call-template name="FullDescription">
          <xsl:with-param name="serviceDetails" select="document(path)" />
        </xsl:call-template>
      </div>
      <br/>
      <br/>
    </xsl:for-each>
  </xsl:template>

  <xsl:template name="Qualities" >
    <xsl:param name="qualities" />
    <h3>Qualities</h3>
    <ul class="list-group mb-3">
      <xsl:for-each select="$qualities/hp:item">
        <li class="list-group-item" style="padding-top:2px;padding-bottom:2px">
          <h6 class="my-0">
            <xsl:value-of select="."/>
          </h6>
        </li>

      </xsl:for-each>
    </ul>
  </xsl:template>

  <xsl:template name="Configuration" >
    <xsl:param name="config" />
    <h3>
      Configuration
    </h3>
    <div class="table-responsive">
      <table class="table table-striped table-sm table-bordered">
        <thead>
          <tr>
            <th>Name</th>
            <th>Source</th>
          </tr>
        </thead>
        <tbody>
          <xsl:for-each select="$config/hp:Config">
            <tr>
              <td>
                <xsl:value-of select="@Type"/>
              </td>
              <td>
                <xsl:value-of select="."/>
              </td>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </div>
  </xsl:template>
  <xsl:template name="Databases" >
    <xsl:param name="data" />
    <h3>
      Databases
    </h3>
    <div class="table-responsive">
      <table class="table table-striped table-sm table-bordered">
        <thead>
          <tr>
            <th>Name</th>
            <th>Source</th>
          </tr>
        </thead>
        <tbody>
          <xsl:for-each select="$data/hp:Database">
            <tr>
              <td>
                <xsl:value-of select="@Name"/>
              </td>
              <td>
                <xsl:value-of select="@SourcePath"/>
              </td>
            </tr>
          </xsl:for-each>
        </tbody>
      </table>
    </div>
  </xsl:template>

  <xsl:template name="Interfaces">
    <xsl:param name="interface" />
    
    <table class="table table-striped table-sm table-bordered">
      <tr>
        <th colspan="2">
          <h2>Interfaces</h2>
        </th>
      </tr>
      <tr >
        <td>
          <h5>Queries</h5>
        </td>
        <td>
          <a href="{$interface/hp:Queries}">See Swagger file</a>
        </td>
      </tr>
      <tr >
        <td>
          <h5>Commands</h5>
        </td>
        <td>
          <xsl:value-of select="$interface/hp:Commands"/>
        </td>
      </tr>
      <tr >
        <td>
          <h5>Publishes</h5>
        
      </td>
        <td>
          <xsl:value-of select="$interface/hp:Publishes"/>
        </td>
      </tr>
      <tr >
        <td>
          <h5>Subscribes</h5>
        </td>
        <td>
          <xsl:value-of select="$interface/hp:Subscribes"/>
        </td>
      </tr>
    </table>
  </xsl:template>

  <xsl:template name="FullDescription">
    <xsl:param name="serviceDetails" />
    <div class="card-header">
      <a id="{$serviceDetails/hp:systemDefinition/hp:System/hp:Source/hp:Application/@Name}">
        <h2>
          Service: <xsl:value-of select="$serviceDetails/hp:systemDefinition/hp:System/hp:Name"/>
        </h2>
      </a>
      <span>Source:</span>
      <a href="{$serviceDetails/hp:systemDefinition/hp:System/hp:Source/hp:Application/@SourcePath}">
        <xsl:value-of select="$serviceDetails/hp:systemDefinition/hp:System/hp:Source/hp:Application/@SourcePath"/>
      </a>
    </div>



    <div class="card-body">
      <p class="card-text">
        <xsl:value-of select="$serviceDetails/hp:systemDefinition/hp:System/hp:Description"/>
      </p>
      <xsl:call-template name="Qualities">
        <xsl:with-param name="qualities" select="$serviceDetails/hp:systemDefinition/hp:System/hp:Implementation/hp:Qualities" />
      </xsl:call-template>
      <xsl:call-template name="Configuration">
        <xsl:with-param name="config" select="$serviceDetails/hp:systemDefinition/hp:System/hp:Implementation/hp:Configuration" />
      </xsl:call-template>


      <xsl:call-template name="Interfaces">
        <xsl:with-param name="interface" select="$serviceDetails/hp:systemDefinition/hp:System/hp:Interface" />
      </xsl:call-template>
      <xsl:call-template name="Databases">
        <xsl:with-param name="data" select="$serviceDetails/hp:systemDefinition/hp:System/hp:Implementation/hp:Data" />
      </xsl:call-template>


    </div>
  </xsl:template>

  <xsl:template name="CMSummary" >
    <a id="CMSummary">
      <h2>CM Service Summary</h2>
    </a>
    <div class="table-responsive">
      <table class="table table-striped table-sm table-bordered">
        <thead>
          <tr>
            <th>Name</th>
            <th>Redirect</th>
            <th>Queues</th>
            <th>Configs</th>
          </tr>
        </thead>
        <tbody>

          <xsl:for-each select="/HealthPlanet/build">
            <xsl:for-each select="document(path)/hp:systemDefinition">
              <tr>
                <td>
                  <xsl:if test="./hp:System/hp:Interface/hp:Queries != 'None'">
                    <b>Web Host:</b>
                    <xsl:value-of select="./hp:System/hp:Source/hp:Application/@Name"/>
                  </xsl:if>
                  <p>
                    <xsl:if test="./hp:System/hp:Implementation/hp:Configuration/hp:Config[@Type = 'ServiceName'] != 'None'">
                      <b>Service Host:</b><xsl:value-of select="./hp:System/hp:Implementation/hp:Configuration/hp:Config[@Type = 'ServiceName']"/>
                    </xsl:if>
                  </p>
                </td>
                <td>
                  <xsl:value-of select="./hp:System/hp:Implementation/hp:Configuration/hp:Config[@Type = 'RedirectName']"/>
                </td>
                <td>
                  
                </td>
                <td>
                  <ul class="list-group">
                      <li class="list-group-item d-flex justify-content-between lh-condensed">
                          Database: <xsl:value-of select="./hp:System/hp:Implementation/hp:Configuration/hp:Config[@Type = 'table']"/>
                      </li>
                    <li class="list-group-item d-flex justify-content-between lh-condensed">
                      File:<xsl:value-of select="./hp:System/hp:Implementation/hp:Configuration/hp:Config[@Type = 'File']"/>
                    </li>
                    <li class="list-group-item d-flex justify-content-between lh-condensed">
                      Tokens:<xsl:value-of select="./hp:System/hp:Implementation/hp:Configuration/hp:Config[@Type = 'TokenizedFiles']"/>
                    </li>
                   </ul>
                  
                </td>
              </tr>
            </xsl:for-each>
          </xsl:for-each>

        </tbody>
      </table>
    </div>
  </xsl:template>

  <xsl:template name="AllDatabases" >
    <a id="Databases">
      <h2>All Databases in Release</h2>
    </a>
    <div class="table-responsive">
      <table class="table table-striped table-sm table-bordered">
        <thead>
          <tr>
            <th>Name</th>
            <th>Source</th>
          </tr>
        </thead>
        <tbody>

          <xsl:for-each select="/HealthPlanet/build">
            <tr>
              <td colspan="2">
                <h5><xsl:value-of select="document(path)/hp:systemDefinition/hp:System/hp:Name"/>
                </h5>
              </td>
            </tr>
            <xsl:for-each select="document(path)/hp:systemDefinition/hp:System/hp:Implementation/hp:Data/hp:Database">
              <tr>
                <td>
                  <xsl:value-of select="@Name"/>
                </td>
                <td>
                  <xsl:value-of select="@SourcePath"/>
                </td>
              </tr>
            </xsl:for-each>
          </xsl:for-each>

        </tbody>
      </table>
    </div>
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
          <xsl:for-each select="/HealthPlanet/build">
            <xsl:for-each select="document(path)">
              <tr>
                <td>
                  <xsl:value-of select="hp:systemDefinition/hp:System/hp:Name"/>
                </td>
                <td>
                  <xsl:value-of select="hp:systemDefinition/hp:System/hp:Interface/hp:Publishes"/>
                </td>
              </tr>
            </xsl:for-each>
          </xsl:for-each>

        </tbody>
      </table>
    </div>
  </xsl:template>




</xsl:stylesheet>
