<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:strip-space elements="*"/>
<xsl:output method="xml"
	    omit-xml-declaration="no"
	    indent="yes"
	    cdata-section-elements="style"/>
<!-- Parameters of this stylesheet -->
<xsl:param name="showfingers"/>
<xsl:param name="width"/>
<xsl:param name="height"/>
<!-- how big would be the picture. normal is 50 -->
<xsl:param name="fretheight" select="40"/>
	<!-- if 1, xml-stylesheet processing instruction for external CSS is used. if 0, CSS are included in SVG - all in one doc. -->
<xsl:param name="externalstyle" select="true"/> 
<!-- if 1, base numbering at the left is shown -->
<xsl:param name="showbase" select="0"/>
<!-- y axis of top line, everything is aligned to this, normal is 100 TODO -->
<xsl:param name="topliney" select="100"/>
<!-- if 1, forget on CSS (internal/external) and put the styling info inline to the elements -->
<xsl:param name="inlinestyle" select="false"/>
<xsl:param name="cssfile" select="document('xchords-default-css.xml')"/>
<xsl:param name="vx" select="0"/>
<xsl:param name="vy" select="0"/>
<xsl:param name="vmaxy" select="410"/>

<xsl:include href="header.xsl"/>
<xsl:include href="readlist.xsl"/>

<xsl:include href="draw2svg.xsl"/>

</xsl:stylesheet>
