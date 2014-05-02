<?xml version="1.0"?>
<xsl:stylesheet version="1.1" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:redirect="http://xml.apache.org/xalan/redirect"
  extension-element-prefixes="redirect">
<xsl:strip-space elements="*"/>
<xsl:output method="xml"
	    omit-xml-declaration="no"
	    indent="yes"/>
<xsl:param name="directory"/>
<xsl:param name="inext"/>
<xsl:param name="outext"/>

<!--
Code for processing list xml file.
-->
<xsl:template match="chordfile">
	<xsl:variable name="filein"><xsl:value-of select="$directory"/><xsl:value-of select="@file"/><xsl:value-of select="$inext"/></xsl:variable>
	<!--<xsl:variable name="fileout"><xsl:value-of select="$directory"/><xsl:value-of select="@file"/><xsl:value-of select="$outext"/></xsl:variable>-->
	<xsl:variable name="fileout"><xsl:value-of select="$directory"/><xsl:value-of select="@file"/><xsl:value-of select="$outext"/></xsl:variable>

	<xsl:message><xsl:value-of select="$filein"/></xsl:message>
	<xsl:message><xsl:value-of select="$fileout"/></xsl:message>

	<redirect:write file="{$fileout}" method="xml">
<!--  <xsl:document href="{$fileout}" method="xml"> -->
	
  	<xsl:apply-templates select="document($filein)"/>

  <!--</xsl:document>-->
	</redirect:write>

</xsl:template>


<xsl:template match="chord">

	<xsl:copy>
		<xsl:copy-of select="@*"/>
		<!-- process next -->
		<xsl:apply-templates/>
	</xsl:copy>

</xsl:template>

</xsl:stylesheet>
