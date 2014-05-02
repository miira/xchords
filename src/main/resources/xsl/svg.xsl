<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:redirect="org.apache.xalan.lib.Redirect"
  extension-element-prefixes="redirect">
<xsl:strip-space elements="*"/>
<xsl:output method="xml"
	    omit-xml-declaration="yes"
	    indent="yes"
	    cdata-section-elements="style"/>
<!-- set to false, if you don't want info about fingers (numbers inside dots) -->
<xsl:param name="showfingers" select="'yes'"/>
<xsl:param name="width" select="100"/>
<xsl:param name="height" select="150"/>

<xsl:include href="header.xsl"/>

<!-- each chord should have record in html and svg file -->
<xsl:template match="chord">
	<xsl:variable name="filename"><xsl:value-of select="translate(name,'/','_')"/>.svg</xsl:variable>
	<xsl:message><xsl:value-of select="$filename"/></xsl:message>
	
	<xsl:element name="tr">
		<xsl:element name="td">
			<xsl:attribute name="class">chordname</xsl:attribute>
			<xsl:element name="a">
				<xsl:attribute name="href"><xsl:value-of select="$filename"/></xsl:attribute>
				<xsl:value-of select="name"/>
			</xsl:element>
		</xsl:element>
	</xsl:element>

	<redirect:write select="$filename" method="xml">

	<xsl:element name="svg">
		<xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
		<xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute>
		<xsl:attribute name="viewBox">0 0 400 600</xsl:attribute>
		<xsl:attribute name="fill">white</xsl:attribute>
		<xsl:element name="title">Chord <xsl:value-of select="name"/></xsl:element>
		<!-- classes -->
		<xsl:element name="defs">
			<xsl:element name="style">
				<xsl:attribute name="type">text/css</xsl:attribute>
				<xsl:text>.label { fill:black; stroke: black; font-size:50; text-anchor: middle; } 
				.neck { fill:none; stroke:black; stroke-width:2; }
				.endneck { fill:none; stroke:black; stroke-width:14; }
				.frets { fill:black; stroke: black; stroke-width: 1; }
				.strings { stroke: gray; }
				.dot { fill:black; stroke: black; }
				.emptydot { fill:white; stroke: black; }
				.disableddot { stroke: black; stroke-width: 2; }
				.spacer {fill:white; stroke:white; stroke-width:1}
				.spacerline {fill:none; stroke:black;}
				.finger {stroke:white; fill:white; font-size:23;}
				.barrenum {stroke:black; fill:white; font-size:35; text-anchor:end;}
				.barre { stroke:black; stroke-width: 6; }</xsl:text>
			</xsl:element>
		</xsl:element>
		<!-- graphics -->
		<xsl:element name="g">
			<!-- chord label -->
			<xsl:comment>chord label</xsl:comment>
			<xsl:element name="text">
				<xsl:attribute name="class">label</xsl:attribute>
				<xsl:attribute name="x">192</xsl:attribute>
				<xsl:attribute name="y">47</xsl:attribute>
				<xsl:value-of select="name"/>
			</xsl:element>

			<!-- guitar end neck  -->
			<xsl:comment>guitar end neck</xsl:comment>
			<xsl:element name="line">
				<xsl:attribute name="class">endneck</xsl:attribute>
				<xsl:attribute name="x1">92</xsl:attribute>
				<xsl:attribute name="y1">87</xsl:attribute>
				<xsl:attribute name="x2">292</xsl:attribute>
				<xsl:attribute name="y2">87</xsl:attribute>
			</xsl:element>

			<!-- guitar neck -->
			<xsl:comment>guitar neck</xsl:comment>
			<xsl:element name="rect">
				<xsl:attribute name="class">neck</xsl:attribute>
				<xsl:attribute name="x">100</xsl:attribute>
				<xsl:attribute name="y">100</xsl:attribute>
				<xsl:attribute name="width">184</xsl:attribute>
				<xsl:attribute name="height">450</xsl:attribute>
			</xsl:element>
			
			<!-- plot - frets -->
			<xsl:comment>plot - frets</xsl:comment>
			<xsl:element name="line">
				<xsl:attribute name="class">frets</xsl:attribute>
				<xsl:attribute name="x1">102</xsl:attribute>
				<xsl:attribute name="y1">152</xsl:attribute>
				<xsl:attribute name="x2">282</xsl:attribute>
				<xsl:attribute name="y2">152</xsl:attribute>
			</xsl:element>
			<xsl:element name="line">
				<xsl:attribute name="class">frets</xsl:attribute>
				<xsl:attribute name="x1">102</xsl:attribute>
				<xsl:attribute name="y1">202</xsl:attribute>
				<xsl:attribute name="x2">282</xsl:attribute>
				<xsl:attribute name="y2">202</xsl:attribute>
			</xsl:element>
			<xsl:element name="line">
				<xsl:attribute name="class">frets</xsl:attribute>
				<xsl:attribute name="x1">102</xsl:attribute>
				<xsl:attribute name="y1">252</xsl:attribute>
				<xsl:attribute name="x2">282</xsl:attribute>
				<xsl:attribute name="y2">252</xsl:attribute>
			</xsl:element>
			<xsl:element name="line">
				<xsl:attribute name="class">frets</xsl:attribute>
				<xsl:attribute name="x1">102</xsl:attribute>
				<xsl:attribute name="y1">302</xsl:attribute>
				<xsl:attribute name="x2">282</xsl:attribute>
				<xsl:attribute name="y2">302</xsl:attribute>
			</xsl:element>
			<xsl:element name="line">
				<xsl:attribute name="class">frets</xsl:attribute>
				<xsl:attribute name="x1">102</xsl:attribute>
				<xsl:attribute name="y1">352</xsl:attribute>
				<xsl:attribute name="x2">282</xsl:attribute>
				<xsl:attribute name="y2">352</xsl:attribute>
			</xsl:element>
			<xsl:element name="line">
				<xsl:attribute name="class">frets</xsl:attribute>
				<xsl:attribute name="x1">102</xsl:attribute>
				<xsl:attribute name="y1">402</xsl:attribute>
				<xsl:attribute name="x2">282</xsl:attribute>
				<xsl:attribute name="y2">402</xsl:attribute>
			</xsl:element>
			<xsl:element name="line">
				<xsl:attribute name="class">frets</xsl:attribute>
				<xsl:attribute name="x1">102</xsl:attribute>
				<xsl:attribute name="y1">452</xsl:attribute>
				<xsl:attribute name="x2">282</xsl:attribute>
				<xsl:attribute name="y2">452</xsl:attribute>
			</xsl:element>
			<xsl:element name="line">
				<xsl:attribute name="class">frets</xsl:attribute>
				<xsl:attribute name="x1">102</xsl:attribute>
				<xsl:attribute name="y1">502</xsl:attribute>
				<xsl:attribute name="x2">282</xsl:attribute>
				<xsl:attribute name="y2">502</xsl:attribute>
			</xsl:element>
			
			<!-- plot - strings -->
			<xsl:comment>plot - strings</xsl:comment>
			<xsl:element name="line">
				<xsl:attribute name="class">strings</xsl:attribute>
				<xsl:attribute name="x1">117</xsl:attribute>
				<xsl:attribute name="y1">94</xsl:attribute>
				<xsl:attribute name="x2">117</xsl:attribute>
				<xsl:attribute name="y2">549</xsl:attribute>
			</xsl:element>
			<xsl:element name="line">
				<xsl:attribute name="class">strings</xsl:attribute>
				<xsl:attribute name="x1">147</xsl:attribute>
				<xsl:attribute name="y1">94</xsl:attribute>
				<xsl:attribute name="x2">147</xsl:attribute>
				<xsl:attribute name="y2">549</xsl:attribute>
			</xsl:element>
			<xsl:element name="line">
				<xsl:attribute name="class">strings</xsl:attribute>
				<xsl:attribute name="x1">177</xsl:attribute>
				<xsl:attribute name="y1">94</xsl:attribute>
				<xsl:attribute name="x2">177</xsl:attribute>
				<xsl:attribute name="y2">549</xsl:attribute>
			</xsl:element>
			<xsl:element name="line">
				<xsl:attribute name="class">strings</xsl:attribute>
				<xsl:attribute name="x1">207</xsl:attribute>
				<xsl:attribute name="y1">94</xsl:attribute>
				<xsl:attribute name="x2">207</xsl:attribute>
				<xsl:attribute name="y2">549</xsl:attribute>
			</xsl:element>
			<xsl:element name="line">
				<xsl:attribute name="class">strings</xsl:attribute>
				<xsl:attribute name="x1">237</xsl:attribute>
				<xsl:attribute name="y1">94</xsl:attribute>
				<xsl:attribute name="x2">237</xsl:attribute>
				<xsl:attribute name="y2">549</xsl:attribute>
			</xsl:element>
			<xsl:element name="line">
				<xsl:attribute name="class">strings</xsl:attribute>
				<xsl:attribute name="x1">267</xsl:attribute>
				<xsl:attribute name="y1">94</xsl:attribute>
				<xsl:attribute name="x2">267</xsl:attribute>
				<xsl:attribute name="y2">549</xsl:attribute>
			</xsl:element>

			<!-- process next -->
			<xsl:apply-templates/>
		
		</xsl:element>
	</xsl:element>
	</redirect:write>
</xsl:template>


<xsl:template match="position">
	<!-- test if this is the first -->
	<xsl:choose>
	<xsl:when test="position() = 1">
		<xsl:call-template name="firstposition"/>
	
	</xsl:when>
	<xsl:otherwise>
		<!-- the others are called recursively from inside the first - way how to draw multiple positions - remember max fret from previous position -->
		<!-- so we don't want to process other positions, they are processed from another point -->
	
	</xsl:otherwise>
	</xsl:choose>
</xsl:template>


<!-- the first position in the chord -->
<xsl:template name="firstposition">
<xsl:param name="basedrawfret" select="1"/>

	<xsl:call-template name="commonposition">
		<xsl:with-param name="basedrawfret" select="$basedrawfret"/>
	</xsl:call-template>
</xsl:template>


<!-- other positions in chord -->
<xsl:template match="position" mode="others">
<xsl:param name="basedrawfret"/>

	<xsl:call-template name="commonposition">
		<xsl:with-param name="basedrawfret" select="$basedrawfret"/>
	</xsl:call-template>
</xsl:template>


<!-- both branches are merged together -->
<xsl:template name="commonposition">
<xsl:param name="basedrawfret"/>
	<xsl:comment>common position</xsl:comment>

	<xsl:variable name="basefret" select="@base"/>

	<!-- mechanism with sorting and position()-ing -> to have the max() simulation -->
	<xsl:for-each select="string">
		<xsl:sort select="@fret" order="descending" data-type="number"/>
			
		<!-- barre number: only if actual base $basefret>1 ??? now always - true() -->
		<xsl:if test="true()">
			<xsl:element name="text">
				<xsl:attribute name="class">barrenum</xsl:attribute>
				<xsl:attribute name="x">85</xsl:attribute>
				<xsl:attribute name="y"><xsl:value-of select="($basedrawfret+1) * 50 + 72 -32"/></xsl:attribute>
				<xsl:number value="$basefret" format="I"/><xsl:text>.</xsl:text>
			</xsl:element>
		</xsl:if>
		<xsl:choose>
		<xsl:when test="@state='no'">
			<!-- disabled string -->
			<xsl:call-template name="docircle">
				<xsl:with-param name="stringname"><xsl:value-of select="@name"/></xsl:with-param>
				<xsl:with-param name="y"><xsl:value-of select="$basedrawfret * 50 + 77"/></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
                <xsl:when test="@state='open'">
			<!-- open string -->
			<xsl:call-template name="docircle">
				<xsl:with-param name="stringname"><xsl:value-of select="@name"/></xsl:with-param>
				<xsl:with-param name="y"><xsl:value-of select="$basedrawfret * 50 + 21"/></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<!-- classic string - full or optional -->
			<xsl:call-template name="string">
				<xsl:with-param name="order"><xsl:value-of select="position()"/></xsl:with-param>
				<xsl:with-param name="basedrawfret"><xsl:value-of select="$basedrawfret"/></xsl:with-param>
				<xsl:with-param name="basefret"><xsl:value-of select="$basefret"/></xsl:with-param>
			</xsl:call-template>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:for-each>
	
	<!-- draw barre -->
	<xsl:for-each select="barre">
		<!-- circles with finger number -->
		<xsl:call-template name="dobarre">
			<xsl:with-param name="basedrawfret"><xsl:value-of select="$basedrawfret"/></xsl:with-param>
			<xsl:with-param name="basefret"><xsl:value-of select="$basefret"/></xsl:with-param>
		</xsl:call-template>
	</xsl:for-each>
</xsl:template>


<!-- process one barre info -->
<xsl:template name="dobarre">
<xsl:param name="basedrawfret"/>
<xsl:param name="basefret"/>
	<xsl:comment>barre</xsl:comment>

	<xsl:variable name="y" select="($basedrawfret + (@fret - $basefret) ) * 50 + 77"/>

	<xsl:call-template name="docircle">
		<xsl:with-param name="stringname" select="@low"/>
		<xsl:with-param name="y" select="$y"/>
	</xsl:call-template>
	<xsl:call-template name="docircle">
		<xsl:with-param name="stringname" select="@high"/>
		<xsl:with-param name="y" select="$y"/>
	</xsl:call-template>
	<xsl:call-template name="beginbarre">
		<xsl:with-param name="lowname" select="@low"/>
		<xsl:with-param name="highname" select="@high"/>
		<xsl:with-param name="y" select="$y"/>
	</xsl:call-template>
</xsl:template>


<!-- process one string info -->
<xsl:template name="string">
<xsl:param name="order"/>
<xsl:param name="basedrawfret"/>
<xsl:param name="basefret"/>
	
	<xsl:comment><xsl:value-of select="@name"/></xsl:comment>

	<!-- do the circle -->
	<xsl:call-template name="docircle">
		<xsl:with-param name="stringname" select="@name"/>
		<xsl:with-param name="y" select="($basedrawfret + (@fret - $basefret) ) * 50 + 77"/>
	</xsl:call-template>

	<!-- if this is max fret number, draw spacer and call next position - recursive -->
	<xsl:if test="$order = 1">
		<!-- this is the max @fret number in this position -->
		<xsl:variable name="ys" select="($basedrawfret + (@fret - $basefret) + 1) * 50 + 72"/>
		<xsl:choose>
		<!-- we are processing last position in chord def. end neck here. -->
		<xsl:when test="not(../following-sibling::*)"> 
			<xsl:comment>endneck</xsl:comment>
			<!-- spacer -->
			<xsl:element name="path">
				<xsl:attribute name="class">spacer</xsl:attribute>
				<xsl:attribute name="d">M87,<xsl:value-of select="$ys"/> A100,40 0 0,0 192,<xsl:value-of select="$ys"/> A100,40 0 0,1 297,<xsl:value-of select="$ys"/> L297,600 L87,600 Z</xsl:attribute>
			</xsl:element>
			<!-- line -->
			<xsl:element name="path">
				<xsl:attribute name="class">spacerline</xsl:attribute>
				<xsl:attribute name="d">M87,<xsl:value-of select="$ys"/> A100,40 0 0,0 192,<xsl:value-of select="$ys"/> A100,40 0 0,1 297,<xsl:value-of select="$ys"/></xsl:attribute>
			</xsl:element>
		</xsl:when>
		<xsl:otherwise>
			<!-- just draw spacer -->
			<xsl:comment>spacer</xsl:comment>
			<xsl:element name="path">
				<xsl:attribute name="class">spacer</xsl:attribute>
				<xsl:attribute name="d">M87,<xsl:value-of select="$ys"/> A100,40 0 0,0 192,<xsl:value-of select="$ys"/> A100,40 0 0,1 297,<xsl:value-of select="$ys"/> L297,<xsl:value-of select="$ys+10"/> A100,40 0 0,0 192,<xsl:value-of select="$ys+10"/> A100,40 0 0,1 87,<xsl:value-of select="$ys+10"/> L87,<xsl:value-of select="$ys"/> Z</xsl:attribute>
			</xsl:element>
			<!-- spacer lines -->
			<xsl:comment>spacer lines</xsl:comment>
			<xsl:element name="path">
				<xsl:attribute name="class">spacerline</xsl:attribute>
				<xsl:attribute name="d">M87,<xsl:value-of select="$ys"/> A100,40 0 0,0 192,<xsl:value-of select="$ys"/> A100,40 0 0,1 297,<xsl:value-of select="$ys"/></xsl:attribute>
			</xsl:element>
			<xsl:element name="path">
				<xsl:attribute name="class">spacerline</xsl:attribute>
				<xsl:attribute name="d">M297,<xsl:value-of select="$ys+10"/> A100,40 0 0,0 192,<xsl:value-of select="$ys+10"/> A100,40 0 0,1 87,<xsl:value-of select="$ys+10"/></xsl:attribute>
			</xsl:element>
			<!-- call processing of next position -->
			<xsl:apply-templates select="../following-sibling::*" mode="others">
				<xsl:with-param name="basedrawfret"><xsl:value-of select="@fret + 2"/></xsl:with-param>
			</xsl:apply-templates>

		</xsl:otherwise>
		</xsl:choose>
		
	</xsl:if>
</xsl:template>


<!-- find out x from string name -->
<xsl:template name="docircle">
<xsl:param name="stringname"/>
<xsl:param name="y"/>

	<xsl:choose>
	<xsl:when test="$stringname = 'e6'">
		<xsl:call-template name="circle">
			<xsl:with-param name="x">117</xsl:with-param>
			<xsl:with-param name="y" select="$y"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="$stringname = 'a'">
		<xsl:call-template name="circle">
			<xsl:with-param name="x">147</xsl:with-param>
			<xsl:with-param name="y" select="$y"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="$stringname = 'd'">
		<xsl:call-template name="circle">
			<xsl:with-param name="x">177</xsl:with-param>
			<xsl:with-param name="y" select="$y"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="$stringname = 'g'">
		<xsl:call-template name="circle">
			<xsl:with-param name="x">207</xsl:with-param>
			<xsl:with-param name="y" select="$y"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="$stringname = 'b'">
		<xsl:call-template name="circle">
			<xsl:with-param name="x">237</xsl:with-param>
			<xsl:with-param name="y" select="$y"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="$stringname = 'e1'">
		<xsl:call-template name="circle">
			<xsl:with-param name="x">267</xsl:with-param>
			<xsl:with-param name="y" select="$y"/>
		</xsl:call-template>
	</xsl:when>
	</xsl:choose>
</xsl:template>


<!-- begin barre - first choose low x and then high x - don't know how to do better -->
<xsl:template name="beginbarre">
<xsl:param name="lowname"/>
<xsl:param name="highname"/>
<xsl:param name="y"/>
	<xsl:comment>beginbarre</xsl:comment>
	<xsl:choose>
	<xsl:when test="$lowname = 'e6'">
		<xsl:call-template name="endbarre">
			<xsl:with-param name="highname" select="$highname"/>
			<xsl:with-param name="x1">127</xsl:with-param>
			<xsl:with-param name="y" select="$y"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="$lowname = 'a'">
		<xsl:call-template name="endbarre">
			<xsl:with-param name="highname" select="$highname"/>
			<xsl:with-param name="x1">157</xsl:with-param>
			<xsl:with-param name="y" select="$y"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="$lowname = 'd'">
		<xsl:call-template name="endbarre">
			<xsl:with-param name="highname" select="$highname"/>
			<xsl:with-param name="x1">187</xsl:with-param>
			<xsl:with-param name="y" select="$y"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="$lowname = 'g'">
		<xsl:call-template name="endbarre">
			<xsl:with-param name="highname" select="$highname"/>
			<xsl:with-param name="x1">217</xsl:with-param>
			<xsl:with-param name="y" select="$y"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="$lowname = 'b'">
		<xsl:call-template name="endbarre">
			<xsl:with-param name="highname" select="$highname"/>
			<xsl:with-param name="x1">247</xsl:with-param>
			<xsl:with-param name="y" select="$y"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="$lowname = 'e1'">
		<xsl:call-template name="endbarre">
			<xsl:with-param name="highname" select="$highname"/>
			<xsl:with-param name="x1">277</xsl:with-param>
			<xsl:with-param name="y" select="$y"/>
		</xsl:call-template>
	</xsl:when>
	</xsl:choose>

</xsl:template>


<!-- end barre - first choose low x and then high x - don't know how to do better -->
<xsl:template name="endbarre">
<xsl:param name="highname"/>
<xsl:param name="x1"/>
<xsl:param name="y"/>
	<xsl:comment>endbarre</xsl:comment>

	<xsl:choose>
	<xsl:when test="$highname = 'e6'">
		<xsl:call-template name="barre">
			<xsl:with-param name="x1" select="$x1"/>
			<xsl:with-param name="x2">107</xsl:with-param>
			<xsl:with-param name="y" select="$y"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="$highname = 'a'">
		<xsl:call-template name="barre">
			<xsl:with-param name="x1" select="$x1"/>
			<xsl:with-param name="x2">137</xsl:with-param>
			<xsl:with-param name="y" select="$y"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="$highname = 'd'">
		<xsl:call-template name="barre">
			<xsl:with-param name="x1" select="$x1"/>
			<xsl:with-param name="x2">167</xsl:with-param>
			<xsl:with-param name="y" select="$y"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="$highname = 'g'">
		<xsl:call-template name="barre">
			<xsl:with-param name="x1" select="$x1"/>
			<xsl:with-param name="x2">197</xsl:with-param>
			<xsl:with-param name="y" select="$y"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="$highname = 'b'">
		<xsl:call-template name="barre">
			<xsl:with-param name="x1" select="$x1"/>
			<xsl:with-param name="x2">227</xsl:with-param>
			<xsl:with-param name="y" select="$y"/>
		</xsl:call-template>
	</xsl:when>
	<xsl:when test="$highname = 'e1'">
		<xsl:call-template name="barre">
			<xsl:with-param name="x1" select="$x1"/>
			<xsl:with-param name="x2">257</xsl:with-param>
			<xsl:with-param name="y" select="$y"/>
		</xsl:call-template>
	</xsl:when>
	</xsl:choose>

</xsl:template>


<!-- pure draw barre template -->
<xsl:template name="barre">
<xsl:param name="x1"/>
<xsl:param name="x2"/>
<xsl:param name="y"/>
	<xsl:comment>drawbarre</xsl:comment>
	<xsl:element name="line">
		<xsl:attribute name="class">barre</xsl:attribute>
		<xsl:attribute name="x1"><xsl:value-of select="$x1"/></xsl:attribute>
		<xsl:attribute name="y1"><xsl:value-of select="$y"/></xsl:attribute>
		<xsl:attribute name="x2"><xsl:value-of select="$x2"/></xsl:attribute>
		<xsl:attribute name="y2"><xsl:value-of select="$y"/></xsl:attribute>
	</xsl:element>
</xsl:template>


<!-- pure draw circle template -->
<xsl:template name="circle">
<xsl:param name="x"/>
<xsl:param name="y"/>

	<xsl:if test="(@fret and @fret>0) or @state='no' or @state='open'">
		<xsl:choose>
		<xsl:when test="@state='opt'">	
			<!-- optional string -->
			<xsl:element name="circle">
				<xsl:attribute name="class">emptydot</xsl:attribute>
				<xsl:attribute name="cx"><xsl:value-of select="$x"/></xsl:attribute>
				<xsl:attribute name="cy"><xsl:value-of select="$y"/></xsl:attribute>
				<xsl:attribute name="r">14</xsl:attribute>
			</xsl:element>
		</xsl:when>
                 <xsl:when test="@state='open'">	
			<!-- open string -->
			<xsl:element name="circle" xmlns="http://www.w3.org/2000/svg">
				<xsl:attribute name="class">emptydot</xsl:attribute>
				<xsl:attribute name="cx"><xsl:value-of select="$x"/></xsl:attribute>
				<xsl:attribute name="cy"><xsl:value-of select="$y"/></xsl:attribute>
				<xsl:attribute name="r">7</xsl:attribute>
			</xsl:element>
		</xsl:when>
		<xsl:when test="@state='no'">
			<!-- disabled string -->
			<xsl:element name="line">
				<xsl:attribute name="class">disableddot</xsl:attribute>
				<xsl:attribute name="x1"><xsl:value-of select="$x - 12"/></xsl:attribute>
				<xsl:attribute name="y1"><xsl:value-of select="$y - 12"/></xsl:attribute>
				<xsl:attribute name="x2"><xsl:value-of select="$x + 12"/></xsl:attribute>
				<xsl:attribute name="y2"><xsl:value-of select="$y + 12"/></xsl:attribute>
			</xsl:element>
			<xsl:element name="line">
				<xsl:attribute name="class">disableddot</xsl:attribute>
				<xsl:attribute name="x1"><xsl:value-of select="$x - 12"/></xsl:attribute>
				<xsl:attribute name="y1"><xsl:value-of select="$y + 12"/></xsl:attribute>
				<xsl:attribute name="x2"><xsl:value-of select="$x + 12"/></xsl:attribute>
				<xsl:attribute name="y2"><xsl:value-of select="$y - 12"/></xsl:attribute>
			</xsl:element>
		</xsl:when>
		<xsl:otherwise>
			<!-- normal string -->
			<xsl:element name="circle">
				<xsl:attribute name="class">dot</xsl:attribute>
				<xsl:attribute name="cx"><xsl:value-of select="$x"/></xsl:attribute>
				<xsl:attribute name="cy"><xsl:value-of select="$y"/></xsl:attribute>
				<xsl:attribute name="r">14</xsl:attribute>
			</xsl:element>
		</xsl:otherwise>
		</xsl:choose>
	</xsl:if>
	<!-- parameter - fingers on/off -->
	<xsl:if test="$showfingers='yes' and (not(@state) or @state='ok')">	
	<xsl:choose>
	<xsl:when test="@finger='T'">
		<xsl:element name="text">
			<xsl:attribute name="class">finger</xsl:attribute>
			<xsl:attribute name="x"><xsl:value-of select="$x -7"/></xsl:attribute>
			<xsl:attribute name="y"><xsl:value-of select="$y +8+1"/></xsl:attribute>
			<xsl:value-of select="@finger"/>
		</xsl:element>
	</xsl:when>
	<xsl:when test="@finger='1'">
		<xsl:element name="text">
			<xsl:attribute name="class">finger</xsl:attribute>
			<xsl:attribute name="x"><xsl:value-of select="$x -7"/></xsl:attribute>
			<xsl:attribute name="y"><xsl:value-of select="$y +8"/></xsl:attribute>
			<xsl:value-of select="@finger"/>
		</xsl:element>
	</xsl:when>
	<xsl:when test="@finger='2'">
		<xsl:element name="text">
			<xsl:attribute name="class">finger</xsl:attribute>
			<xsl:attribute name="x"><xsl:value-of select="$x -7+1"/></xsl:attribute>
			<xsl:attribute name="y"><xsl:value-of select="$y +8"/></xsl:attribute>
			<xsl:value-of select="@finger"/>
		</xsl:element>
	</xsl:when>
	<xsl:when test="@finger='3'">
		<xsl:element name="text">
			<xsl:attribute name="class">finger</xsl:attribute>
			<xsl:attribute name="x"><xsl:value-of select="$x -7+1"/></xsl:attribute>
			<xsl:attribute name="y"><xsl:value-of select="$y +8"/></xsl:attribute>
			<xsl:value-of select="@finger"/>
		</xsl:element>
	</xsl:when>
	<xsl:when test="@finger='4'">
		<xsl:element name="text">
			<xsl:attribute name="class">finger</xsl:attribute>
			<xsl:attribute name="x"><xsl:value-of select="$x -7"/></xsl:attribute>
			<xsl:attribute name="y"><xsl:value-of select="$y +8"/></xsl:attribute>
			<xsl:value-of select="@finger"/>
		</xsl:element>
	</xsl:when>
	<xsl:otherwise>
	</xsl:otherwise>
	</xsl:choose>
	</xsl:if>
</xsl:template>


</xsl:stylesheet>
