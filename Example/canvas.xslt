<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>

<xsl:template name="ServiceCanvas">
    <xsl:param name="serviceInfo" />

          <div class="card mb-4 border-dark shadow-sm" style="width:100%">
            <div class="card-header" style="padding: 0px;">
                
                <ul class="navbar" style="margin-bottom:0px;">
                    <li class="nav-item">
                        <a id="$serviceInfo/Info/Name">
                            <h2 class="card-title"><xsl:value-of select="$serviceInfo/Info/Name"/></h2>
                    
                    </a>
                    <xsl:value-of select="$serviceInfo/Info/Documentation/Description"/>
                    </li>
                    <li class="nav-item float-right navbar-nav">
                         <p>Backlog:  <a href="{$serviceInfo/Info/Documentation/Backlog/@Location}"><xsl:value-of select="$serviceInfo/Info/Documentation/Backlog/@Location"/></a></p>
                        <p>Source:  <a href="{$serviceInfo/Info/Documentation/Source/@Location}"><xsl:value-of select="$serviceInfo/Info/Documentation/Source/@Location"/></a></p>
               
                    </li>
                </ul>
            </div>
            
            <div class="card-body d-flex flex-column align-items-start">
                
                <div class="row" style="width:100%">
                    <div class="col" >
                        <table class="table table-striped table-sm table-bordered">
                        <tr>
                            <th colspan="3">
                            <h4>Iterations</h4>
                            </th>
                        </tr>
                        <xsl:for-each select="$serviceInfo/Info/Iterations/Iteration">
                            <tr >
                                <td>
                                    <xsl:value-of select="@Name"/>
                                </td>
                                <td><xsl:value-of select="@StartDate"/>-<xsl:value-of select="@EndDate"/></td>
                                <td><xsl:value-of select="@Location"/></td>
                            </tr>
                        </xsl:for-each>
                        
                        </table>
                        
                    </div>
                </div>                
                <div class="row" style="width:100%">
                    <div class="col" >
                        <table class="table table-striped table-sm table-bordered">
                        <tr>
                            <th colspan="2">
                            <h4>Interfaces</h4>
                            </th>
                        </tr>
                        <tr >
                            <td>
                            <h5>Queries</h5>
                            </td>
                            <td>
                            <a href="{$serviceInfo/Info/Interface/API}">See Swagger file</a>
                            </td>
                        </tr>
                        <tr >
                            <td>
                            <h5>Commands</h5>
                            </td>
                            <td>
                            <xsl:value-of select="$serviceInfo/Info/Interface/CommandHandlers/Message"/>
                            </td>
                        </tr>
                        <tr >
                            <td>
                            <h5>Publishes</h5>
                            
                        </td>
                            <td>
                            <xsl:value-of select="$serviceInfo/Info/Interface/Publishes/Message"/>
                            </td>
                        </tr>
                        <tr >
                            <td>
                            <h5>Subscribes</h5>
                            </td>
                            <td>
                            <xsl:value-of select="$serviceInfo/Info/Interface/Subscribes/Message"/>
                            </td>
                        </tr>
                        </table>
                    </div>
                    <div class="col">
                        <table class="table table-striped table-sm table-bordered">
                        <tr>
                            <th colspan="2">
                            <h4>Databases</h4>
                            </th>
                        </tr>
                        <xsl:for-each select="$serviceInfo/Info/Databases/Database">
                            <tr >
                                <td>
                                <h5><xsl:value-of select="@Name"/>.<xsl:value-of select="@Schema"/></h5>
                                </td>
                                <td>
                                Repo: <a href="{@Location}"><xsl:value-of select="@Location"/></a>
                                <xsl:value-of select="@Location"/>
                                </td>
                            </tr>
                        </xsl:for-each>        
                        </table>
                    </div>
                    <div class="col">
                        <table class="table table-striped table-sm table-bordered">
                        <tr>
                            <th colspan="2">
                            <h2>Dependencies</h2>
                            </th>
                        </tr>
                        <xsl:for-each select="$serviceInfo/Info/Dependencies/Resource">
                            <tr >
                                <td>
                                <h5><xsl:value-of select="@Type"/></h5>
                                </td>
                                <td>
                                <xsl:value-of select="@Name"/>
                                </td>
                            </tr>
                        </xsl:for-each>        
                        </table>
                    </div>
                </div>  
            </div>
          </div>
</xsl:template>
</xsl:stylesheet>