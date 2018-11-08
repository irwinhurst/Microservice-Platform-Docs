<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="3.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:output method="html"/>

<xsl:template name="ServiceCanvas">
    <xsl:param name="serviceInfo" />

          <div class="card flex-md-row mb-4 shadow-sm h-md-250">
            <div class="card-body d-flex flex-column align-items-start">
            <h2 class="card-title"><xsl:value-of select="$serviceInfo/Info/Name"/></h2>
                <p class="card-text">
                    <xsl:value-of select="$serviceInfo/Info/Documentation/Description"/>
                </p>
        <div class="row">
            <div class="col-sm-4" style="display: flex;">
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
                    <div class="col-sm-4" style="display: flex;">
                        test
                    </div>
                </div>  
            </div>
          </div>
</xsl:template>
</xsl:stylesheet>