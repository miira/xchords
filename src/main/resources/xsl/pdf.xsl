<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:fo="http://www.w3.org/1999/XSL/Format"
  xmlns:xalan="http://xml.apache.org/xslt"
>
<xsl:strip-space elements="*"/>
<xsl:output method="xml"
	    omit-xml-declaration="no"
	    indent="yes"/>
<xsl:param name="directory"/>

<!--
Code for processing list xml file.
-->
<xsl:template match="chordfile">
<xsl:if test="position() mod 3 = 1">
  
<fo:table-row border-width="0.5pt">

	<xsl:variable name="file1"><xsl:value-of select="$directory"/><xsl:value-of select="@file"/>.svg</xsl:variable>
	<xsl:call-template name="oneimage">
		<xsl:with-param name="imagebase"><xsl:value-of select="$file1"/></xsl:with-param> 
	</xsl:call-template>
	
	<xsl:if test="count(following-sibling::chordfile[1])&gt;0">
	<xsl:variable name="file2"><xsl:value-of select="$directory"/><xsl:value-of select="following-sibling::chordfile[1]/@file"/>.svg</xsl:variable>
	<xsl:call-template name="oneimage">
		<xsl:with-param name="imagebase"><xsl:value-of select="$file2"/></xsl:with-param>
	</xsl:call-template>
	</xsl:if>
	
	<xsl:if test="count(following-sibling::chordfile[2])&gt;0">
	<xsl:variable name="file3"><xsl:value-of select="$directory"/><xsl:value-of select="following-sibling::chordfile[2]/@file"/>.svg</xsl:variable>
	<xsl:call-template name="oneimage">
		<xsl:with-param name="imagebase"><xsl:value-of select="$file3"/></xsl:with-param>
	</xsl:call-template>
	</xsl:if>

</fo:table-row>

</xsl:if>	
</xsl:template>


<xsl:template match="chordlist">
<fo:root >
  <fo:layout-master-set>
    <fo:simple-page-master
  margin-right="1.5cm"
  margin-left="1.5cm"
  margin-bottom="2cm"
  margin-top="1cm"
page-width="21cm"
  page-height="29.7cm"
  master-name="first">
      <fo:region-before extent="1cm"/>
      <fo:region-body margin-top="1cm"/>
      <fo:region-after extent="1.5cm"/>
    </fo:simple-page-master>
  </fo:layout-master-set>

  <fo:page-sequence master-reference="first">
    <fo:static-content flow-name="xsl-region-before">
      <fo:block line-height="14pt" font-size="10pt"
    text-align="end">Output produced by XChords 0.3</fo:block>
    </fo:static-content>
    <fo:static-content flow-name="xsl-region-after">
      <fo:block line-height="14pt" font-size="10pt"
    text-align="end">Page <fo:page-number/></fo:block>
    </fo:static-content>

    <fo:flow flow-name="xsl-region-body">


<fo:block widows="1">
      <fo:table border-width="0.5pt" border-color="red">

	<fo:table-column column-width="6cm"/>
	<fo:table-column column-width="6cm"/>
	<fo:table-column column-width="6cm"/>

    <fo:table-body>
	 
	<xsl:apply-templates/>


</fo:table-body>
      </fo:table>
      </fo:block>

</fo:flow>
  </fo:page-sequence>
</fo:root>


</xsl:template>

<xsl:template name="oneimage">
<xsl:param name="imagebase"/>

<fo:table-cell content-width="1cm">
<fo:block text-align="center">
<fo:external-graphic> 
        <xsl:attribute name="src"><xsl:value-of select="$imagebase"/></xsl:attribute> 
</fo:external-graphic> 
</fo:block>
</fo:table-cell>


</xsl:template>

<xsl:template match="text()"/>

</xsl:stylesheet>
