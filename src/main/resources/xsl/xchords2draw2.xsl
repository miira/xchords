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

	<xsl:copy>
		<xsl:copy-of select="@*"/>
		<!-- process next -->
		<xsl:apply-templates/>
	</xsl:copy>

</xsl:template>

<xsl:template match="name">
    <xsl:copy-of select="."/>
</xsl:template>

<!-- process 1st position -->
<xsl:template match="position[1]">
           
		<!-- call processing of next position -->
		<xsl:apply-templates select="." mode="others">
			<xsl:with-param name="lastusedfret" select="0"/>
		</xsl:apply-templates>

</xsl:template>

<!-- don't process other positions, they are processed from the first position ... -->
<xsl:template match="position"/>

<!-- other positions in chord -->
<xsl:template match="position" mode="others">
<xsl:param name="lastusedfret"/>

	<xsl:call-template name="commonposition">
		<xsl:with-param name="lastusedfret" select="$lastusedfret"/>
	</xsl:call-template>
</xsl:template>

<xsl:template name="commonposition">
<xsl:param name="lastusedfret"/>
	<!--<xsl:message>lastusedfret: <xsl:value-of select="$lastusedfret"/></xsl:message>
	<xsl:message>name: <xsl:value-of select="@name"/></xsl:message>-->
        
	<!-- base fret of this position before renumbering -->
	<xsl:variable name="basefret" select="@base"/>
	<xsl:variable name="maxfret" select="@maxfret"/>

	<!-- copy -->
	<xsl:copy>
	<xsl:copy-of select="@name|@fretlabel"/>
	<xsl:attribute name="base"><xsl:value-of select="$lastusedfret + 1"/></xsl:attribute>
	<xsl:attribute name="maxfret"><xsl:value-of select="($lastusedfret + 1 + ($maxfret - $basefret) )"/></xsl:attribute>
	<!-- for each string, barre, separator, endneck elements -->
	<xsl:for-each select="child::*">
		<xsl:variable name="newfret" select="($lastusedfret + 1 + (@fret - $basefret) )"/>
		<!-- copy -->
		<xsl:copy>
		<xsl:copy-of select="@name|@finger|@state|@low|@high"/>
		<xsl:attribute name="fret"><xsl:value-of select="$newfret"/></xsl:attribute>
		</xsl:copy>
	</xsl:for-each>
	</xsl:copy>
	<!-- call processing of next position -->
	<xsl:apply-templates select="following-sibling::position[1]" mode="others">
		<xsl:with-param name="lastusedfret"><xsl:value-of select="$lastusedfret + 1 + ($maxfret - $basefret)+ 1"/></xsl:with-param>
	</xsl:apply-templates>
	
</xsl:template>


</xsl:stylesheet>
