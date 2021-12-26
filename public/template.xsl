<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:template match="/">
<html> 
<body>
  <Tabs>
      <Tab label="Ввод">
          <div className="mui--text-title" style="margin: 20px 0">Введенные данные</div>
          <table className="mui-table mui-table--bordered">
              <thead>
              <tr>
                  <th>#</th>
                  <th>Введенное число</th>
              </tr>
              </thead>
              <tbody>
              <xsl:for-each select="hash/input/input">
                <tr>
                  <td style="font-weight: bold"><xsl:number/></td>
                  <td><xsl:value-of select="."/></td>
                </tr>
              </xsl:for-each>
              </tbody>
          </table>
      </Tab>
      <Tab label="Вывод">
          <div className="mui--text-title" style="margin: 20px 0">Возрастающие последовательности</div>
          <table className="mui-table mui-table--bordered">
              <thead>
              <tr>
                  <th>#</th>
                  <th>##</th>
                  <th>Число последовательности</th>
              </tr>
              </thead>
              <tbody>
              <xsl:for-each select="hash/chunks/chunk">
                <xsl:for-each select="chunk">
                  <tr>
                    <xsl:if test="position() = 1">
                      <td style="font-weight: bold">
                        <xsl:attribute name="rowSpan">
                          <xsl:value-of select="count(following-sibling::*) + 1"/>
                        </xsl:attribute>
                        <xsl:number count="hash/chunks/chunk"/>
                      </td>
                    </xsl:if>
                    <td style="font-weight: bold"><xsl:number/></td>
                    <td><xsl:value-of select="."/></td>
                  </tr>
                </xsl:for-each>
              </xsl:for-each>
              </tbody>
          </table>
      </Tab>
      <Tab label="Ответ">
          <div className="mui--text-title" style="margin: 20px 0">Самая длинная возрастающая последовательность</div>
          <table className="mui-table mui-table--bordered">
              <thead>
              <tr>
                  <th>#</th>
                  <th>Число</th>
              </tr>
              </thead>
              <tbody>
              <xsl:for-each select="hash/max-length/max-length">
                <tr>
                  <td style="font-weight: bold"><xsl:number/></td>
                  <td><xsl:value-of select="."/></td>
                </tr>
              </xsl:for-each>
              </tbody>
          </table>
      </Tab>
  </Tabs>

</body>
</html>
</xsl:template>
</xsl:stylesheet>