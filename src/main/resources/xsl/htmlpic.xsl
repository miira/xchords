<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
>
<xsl:strip-space elements="*"/>
<xsl:output method="html"
	    omit-xml-declaration="no"
	    indent="yes"/>
<xsl:param name="directory"/>
<xsl:param name="imageformat"/>
<xsl:param name="items_on_row"/>

<!--
Code for processing list xml file.
-->
<xsl:template match="chordfile">
	<xsl:choose>
		<xsl:when test="$imageformat = 'jpeg'">
			<xsl:call-template name="onerow">
				<xsl:with-param name="fileext">.jpg</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:when test="$imageformat = 'tiff'">
			<xsl:call-template name="onerow">
				<xsl:with-param name="fileext">.tiff</xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<xsl:call-template name="onerow">
				<xsl:with-param name="fileext">.png</xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
	</xsl:choose>
</xsl:template>

<xsl:template name="onerow">
<xsl:param name="fileext"/>

<xsl:if test="position() mod $items_on_row = 1">
  
<xsl:element name="tr">

	<xsl:variable name="file1"><xsl:value-of select="@file"/><xsl:value-of select="$fileext"/></xsl:variable>
	<xsl:call-template name="oneimage">
		<xsl:with-param name="imagebase"><xsl:value-of select="$file1"/></xsl:with-param> 
	</xsl:call-template>
	
	<xsl:choose>
	<xsl:when test="count(following-sibling::chordfile[1])&gt;0">
	<xsl:variable name="file2"><xsl:value-of select="following-sibling::chordfile[1]/@file"/><xsl:value-of select="$fileext"/></xsl:variable>
	<xsl:call-template name="oneimage">
		<xsl:with-param name="imagebase"><xsl:value-of select="$file2"/></xsl:with-param>
	</xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
		<xsl:element name="td">&amp;nbsp;</xsl:element>
	</xsl:otherwise>
	</xsl:choose>

	<xsl:choose>
	<xsl:when test="count(following-sibling::chordfile[2])&gt;0">
	<xsl:variable name="file3"><xsl:value-of select="following-sibling::chordfile[2]/@file"/><xsl:value-of select="$fileext"/></xsl:variable>
	<xsl:call-template name="oneimage">
		<xsl:with-param name="imagebase"><xsl:value-of select="$file3"/></xsl:with-param>
	</xsl:call-template>
	</xsl:when>
	<xsl:otherwise>
		<xsl:element name="td"></xsl:element>
	</xsl:otherwise>
	</xsl:choose>

</xsl:element>

</xsl:if>	
</xsl:template>


<xsl:template match="chordlist">
<xsl:element name="html">
  
<xsl:element name="header">
</xsl:element>

<xsl:element name="body">

<xsl:element name="table">
<xsl:attribute name="border">0</xsl:attribute>
	 
	<xsl:apply-templates/>


</xsl:element>
      
<xsl:element name="p">Output produced by XChords 0.3</xsl:element>
</xsl:element>
</xsl:element>

</xsl:template>

<xsl:template name="oneimage">
<xsl:param name="imagebase"/>

<xsl:element name="td">

<xsl:attribute name="align">center</xsl:attribute>

<xsl:element name="img">
	<xsl:attribute name="src"><xsl:value-of select="$imagebase"/></xsl:attribute> 
</xsl:element> 

</xsl:element>


</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>
