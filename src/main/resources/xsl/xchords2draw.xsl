<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
<xsl:strip-space elements="*"/>
<xsl:output method="xml"
	    omit-xml-declaration="no"
	    indent="yes"
	    cdata-section-elements="style"/>
<!-- Parameters of this stylesheet -->
<xsl:param name="showfingers" select="'yes'"/>
<xsl:param name="width" select="100"/>
<xsl:param name="height" select="150"/>

<xsl:template match="chord">
    
    <xsl:element name="chord">
    <xsl:copy-of select="@*"/>
    <xsl:apply-templates/>
    </xsl:element>
    </xsl:template>
    
   
    <xsl:template match="name">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:value-of select="text()"/>
        </xsl:copy>
    </xsl:template>

<!--
Position.
Sorts childs (strings and barres) descending based on @fret, calculates max fret for position.
Creates <separator> and <endneck> elements.

-->
<xsl:template match="position">
	<xsl:copy>
	<xsl:copy-of select="@*"/>

	<xsl:attribute name="fretlabel"><xsl:value-of select="@base"/></xsl:attribute>
        <xsl:variable name="basevar" select="@base"/>
        
	<xsl:choose>
	<xsl:when test="position() = last()">
		<xsl:for-each select="child::*">
			<xsl:sort select="@fret" order="descending" data-type="number"/>
			<xsl:call-template name="proc_string">
				<xsl:with-param name="order" select="position()"/>
				<xsl:with-param name="fret" select="@fret"/>
				<xsl:with-param name="last">yes</xsl:with-param>
                <xsl:with-param name="base"><xsl:value-of select="$basevar"/></xsl:with-param>
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
                <xsl:with-param name="base"><xsl:value-of select="$basevar"/></xsl:with-param>
			</xsl:call-template>
		</xsl:for-each>
	</xsl:otherwise>
	</xsl:choose>
	</xsl:copy>

</xsl:template>

<xsl:template name="proc_string">
<xsl:param name="order"/>
<xsl:param name="fret"/>
<xsl:param name="last"/>
<xsl:param name="base"/>

	<!-- maximum fret number = create separator -->
	<xsl:if test="$order = 1">
		<xsl:variable name="mmaxfret">
			<xsl:choose>
			<xsl:when test="$fret &gt; 0">
				<xsl:value-of select="$fret"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="$base"/>
			</xsl:otherwise>
			</xsl:choose>
		</xsl:variable>
		<xsl:attribute name="maxfret"><xsl:value-of select="$mmaxfret"/></xsl:attribute>
		<xsl:call-template name="proc_separator">
			<xsl:with-param name="fret"><xsl:value-of select="$mmaxfret + 1"/></xsl:with-param>
			<xsl:with-param name="last" select="$last"/>
		</xsl:call-template>
	</xsl:if>

	<!-- copy all the strings info (based on state and fret)-->
	<xsl:choose>
        <xsl:when test="@state = 'no'">
            <xsl:element name="string">
            <xsl:attribute name="fret"><xsl:value-of select="$base"/></xsl:attribute>
            <xsl:attribute name="state">no</xsl:attribute>
            <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
            </xsl:element>
        </xsl:when>
        <xsl:when test="@state = 'open'">
            <xsl:element name="string">
            <xsl:attribute name="fret"><xsl:value-of select="$base"/></xsl:attribute>
            <xsl:attribute name="state">open</xsl:attribute>
            <xsl:attribute name="name"><xsl:value-of select="@name"/></xsl:attribute>
            </xsl:element>
        </xsl:when>
        <xsl:when test="@state = 'opt'">
        	
            <xsl:copy-of select="."/>
        </xsl:when>
        <xsl:when test="@fret and @state!='no' and @state!='opt' and @state!='open'">
			<xsl:copy-of select="."/>
		</xsl:when>
        <xsl:otherwise>
            <xsl:copy-of select=".">
            <xsl:attribute name="state">ok</xsl:attribute>
            </xsl:copy-of>
        </xsl:otherwise>
        </xsl:choose>
</xsl:template>

<xsl:template name="proc_separator">
<xsl:param name="fret"/>
<xsl:param name="last"/>
	<xsl:choose>
	<xsl:when test="$last = 'no'">
		<xsl:element name="separator">
			<xsl:attribute name="fret"><xsl:value-of select="$fret"/></xsl:attribute>
		</xsl:element>
	</xsl:when>
	<xsl:otherwise>
		<xsl:element name="endneck">
			<xsl:attribute name="fret"><xsl:value-of select="$fret"/></xsl:attribute>
		</xsl:element>
	</xsl:otherwise>
	</xsl:choose>

</xsl:template>

<!-- copy all the source document -->
<!-- <xsl:template match="*">
	<xsl:copy>
		<xsl:copy-of select="@*"/>
		<xsl:apply-templates/>
	</xsl:copy>

</xsl:template>
 -->

</xsl:stylesheet>
