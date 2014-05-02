<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:chord="http://xchords.barad.cz/2003/XChords" 
  
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  exclude-result-prefixes="xsi chord #default"
  >
<xsl:strip-space elements="*"/>
<xsl:output method="xml"
	    omit-xml-declaration="no"
	    indent="yes"/>

<xsl:include href="list.xsl"/>
<!-- xmlns="http://xchords.barad.cz/2003/XChords" -->


    <xsl:template match="chord:name">
        <xsl:element name="name">
            <xsl:copy-of select="@xml:lang"/>
            <xsl:value-of select="text()"/>
        </xsl:element>
    </xsl:template>

<!--
This stylesheet produces chord files (.chord) - which are then used with drawing stylesheets.
Adds some important information, so the drawing stylesheets can concentrate on the drawing part only.
-->

<!--<xsl:template match="text()"/>-->
<xsl:template match="chord:desc"/>


<!--
Position.
Sorts childs (strings and barres) descending based on @fret, calculates max fret for position.
Creates <separator> and <endneck> elements.

-->
<xsl:template match="chord:position">
	<xsl:element name="position">
	<xsl:copy-of select="@base|@name|@fretlabel"/>
                

	<xsl:attribute name="fretlabel"><xsl:value-of select="@base"/></xsl:attribute>

	<xsl:choose>
	<xsl:when test="position() = last()">
		<xsl:for-each select="child::*">
			<xsl:sort select="@fret" order="descending" data-type="number"/>
		<xsl:call-template name="proc_string">
			<xsl:with-param name="order" select="position()"/>
			<xsl:with-param name="fret" select="@fret"/>
			<xsl:with-param name="last">yes</xsl:with-param>
		</xsl:call-template>
		</xsl:for-each>
	</xsl:when>
	<xsl:otherwise>
		<xsl:for-each select="child::*">
			<xsl:sort select="@fret" order="descending" data-type="number"/>
		<xsl:call-template name="proc_string">
			<xsl:with-param name="order" select="position()"/>
			<xsl:with-param name="fret" select="@fret"/>
			<xsl:with-param name="last">no</xsl:with-param>
		</xsl:call-template>
		</xsl:for-each>
	</xsl:otherwise>
	</xsl:choose>
	</xsl:element>

</xsl:template>

<xsl:template name="proc_string">
<xsl:param name="order"/>
<xsl:param name="fret"/>
<xsl:param name="last"/>

	<!-- maximum fret number = create separator -->
	<xsl:if test="$order = 1">
		<xsl:attribute name="maxfret"><xsl:value-of select="$fret"/></xsl:attribute>
		<xsl:call-template name="proc_separator">
			<xsl:with-param name="fret"><xsl:value-of select="$fret + 1"/></xsl:with-param>
			<xsl:with-param name="last" select="$last"/>
		</xsl:call-template>
	</xsl:if>

	<!-- copy all the strings info (if has @fret or @name)-->
	<xsl:if test="@fret or @name">
		<!--<xsl:copy-of select="."/>-->
                <!-- fuck namespaces -->
                
                <xsl:choose>
                <xsl:when test="local-name() = 'string'">
                <xsl:element name="string">
                    <xsl:copy-of select="@fret|@name|@finger|@state"/>
                </xsl:element>
                </xsl:when>
                <xsl:when test="local-name() = 'barre'">
                <xsl:element name="barre">
                    <xsl:copy-of select="@low|@high|@fret|@finger"/>
                </xsl:element>
                </xsl:when>
                </xsl:choose>
	</xsl:if>
</xsl:template>

<xsl:template name="proc_separator">
<xsl:param name="fret"/>
<xsl:param name="last"/>
	<xsl:choose>
	<xsl:when test="$last = 'no'">
		<xsl:element name="separator" >
			<xsl:attribute name="fret"><xsl:value-of select="$fret"/></xsl:attribute>
		</xsl:element>
	</xsl:when>
	<xsl:otherwise>
		<xsl:element name="endneck" >
			<xsl:attribute name="fret"><xsl:value-of select="$fret"/></xsl:attribute>
		</xsl:element>
	</xsl:otherwise>
	</xsl:choose>

</xsl:template>

<!-- copy all the source document -->
<xsl:template match="*">
	<xsl:copy>
		<xsl:copy-of select="@*"/>
		<xsl:apply-templates/>
	</xsl:copy>

</xsl:template>

</xsl:stylesheet>
