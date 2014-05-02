<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:chord="http://xchords.barad.cz/2003/XChords" 
  >
<xsl:strip-space elements="*"/>
<xsl:output method="html"
	    omit-xml-declaration="no"
	    indent="yes"/>

<!--<xsl:param name="langcode">cs</xsl:param>-->

<xsl:include href="header.xsl"/>
<xsl:include href="chordname.xsl"/>

<xsl:template match="chord:chord">
	<xsl:apply-templates/>
</xsl:template>

<xsl:template match="text()">
    <!-- empty -->
</xsl:template>

<xsl:template match="chord:position">
<xsl:param name="chordname"/>
	<xsl:element name="tr">
		<xsl:element name="td">
			<xsl:attribute name="class">chordname</xsl:attribute>
			<xsl:call-template name="choosename2"/><xsl:text>: </xsl:text>
		</xsl:element>
		<xsl:element name="td">
			<xsl:attribute name="class">chorddef</xsl:attribute>
			<xsl:call-template name="process">
				<xsl:with-param name="basefret"><xsl:value-of select="@base"/></xsl:with-param>
			</xsl:call-template>
			<xsl:if test="@name">
				<xsl:text>  [</xsl:text><xsl:value-of select="@name"/><xsl:text>]</xsl:text>
			</xsl:if>
		</xsl:element>
	</xsl:element>
</xsl:template>


<xsl:template name="process">
<xsl:param name="basefret"/>
    <!--<xsl:message><xsl:value-of select="$basefret"/></xsl:message>-->
	<xsl:call-template name="processstring">
		<xsl:with-param name="basefret" select="$basefret"/>
		<xsl:with-param name="stringname">e6</xsl:with-param>
	</xsl:call-template>

	<xsl:call-template name="processstring">
		<xsl:with-param name="basefret" select="$basefret"/>
		<xsl:with-param name="stringname">a</xsl:with-param>
	</xsl:call-template>

	<xsl:call-template name="processstring">
		<xsl:with-param name="basefret" select="$basefret"/>
		<xsl:with-param name="stringname">d</xsl:with-param>
	</xsl:call-template>

	<xsl:call-template name="processstring">
		<xsl:with-param name="basefret" select="$basefret"/>
		<xsl:with-param name="stringname">g</xsl:with-param>
	</xsl:call-template>

	<xsl:call-template name="processstring">
		<xsl:with-param name="basefret" select="$basefret"/>
		<xsl:with-param name="stringname">b</xsl:with-param>
	</xsl:call-template>

	<xsl:call-template name="processstring">
		<xsl:with-param name="basefret" select="$basefret"/>
		<xsl:with-param name="stringname">e1</xsl:with-param>
	</xsl:call-template>

</xsl:template>


<xsl:template name="processstring">
<xsl:param name="basefret"/>
<xsl:param name="stringname"/>

	
	<xsl:choose>
		<xsl:when test="chord:string[@name=$stringname and @state='no']">
			<xsl:text>x</xsl:text>
		</xsl:when>
		<xsl:when test="chord:string[@name=$stringname]">
			<xsl:value-of select="chord:string[@name=$stringname]/@fret"/>
		</xsl:when>
		<xsl:when test="$basefret>1">
			<xsl:value-of select="$basefret"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:text>0</xsl:text>
		</xsl:otherwise>
	</xsl:choose>

<!--
	
		<xsl:when test="../barre/@fret">
			<xsl:value-of select="../barre/@fret"/>
		</xsl:when>
	  -->

</xsl:template>


</xsl:stylesheet>
