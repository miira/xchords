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
<xsl:param name="langcode">cs</xsl:param>

<xsl:include href="header.xsl"/>
<xsl:include href="readlist.xsl"/>
<xsl:include href="chordname.xsl"/>



<xsl:template match="chord">

	<!-- how much of space we need -->
	<xsl:variable name="maxfret" select="child::*/child::endneck/@fret"/>


	<xsl:element name="svg">

		<xsl:message><xsl:value-of select="$width"/></xsl:message>
		<xsl:message><xsl:value-of select="$height"/></xsl:message>

		<!-- this is important for displaying in firefox 1.5beta1 -->		
		<!--<xsl:text>xmlns="http://www.w3.org/2000/svg"</xsl:text>-->
		<!-- this is not so important, but it was in the example.. ;) -->
		
		<!-- Set Width and Height (parameters or calculated) (fop needs this) -->
		<xsl:choose>
		<xsl:when test="$width &gt; 0">
			<xsl:attribute name="width"><xsl:value-of select="$width"/></xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
			<xsl:attribute name="width">400</xsl:attribute>
		</xsl:otherwise>
		</xsl:choose>
		<xsl:choose>
		<xsl:when test="$height &gt; 0">
			<xsl:attribute name="height"><xsl:value-of select="$height"/></xsl:attribute>
		</xsl:when>
		<xsl:otherwise>
			<xsl:attribute name="height"><xsl:value-of select="100 + 50 * ($maxfret + 2)"/></xsl:attribute>
		</xsl:otherwise>
		</xsl:choose>

		<!-- Viewbox will be _always_ calculated -->
		<xsl:attribute name="viewBox">0 0 400 <xsl:value-of select="100 + 50 * ($maxfret + 2)"/></xsl:attribute>
		<xsl:attribute name="fill">white</xsl:attribute>
		<xsl:element name="title">Chord <xsl:call-template name="choosename"/></xsl:element>
		<!-- classes -->
		<xsl:element name="defs">
			<xsl:element name="style">
				<xsl:attribute name="type">text/css</xsl:attribute>
				<xsl:text>.label { fill:black; stroke: black; font-size:50px; text-anchor: middle; }
				.neck { fill:none; stroke:black; stroke-width:2px; }
				.endneck { fill:none; stroke:black; stroke-width:14px; }
				.frets { fill:black; stroke: black; stroke-width: 1px; }
				.strings { stroke: gray; }
				.dot { fill:black; stroke: black; }
				.emptydot { fill:white; stroke: black; }
				.disableddot { stroke: black; stroke-width: 2px; }
				.spacer {fill:white; stroke:white; stroke-width:1px}
				.spacerline {fill:none; stroke:black;}
				.finger {stroke:white; fill:white; font-size:23px;}
				.barrenum {stroke:black; fill:white; font-size:35px; text-anchor:end;}
				.barre { stroke:black; stroke-width: 6px; }</xsl:text>
			</xsl:element>
		</xsl:element>
		<!-- graphics -->
		<xsl:comment>chord</xsl:comment>
		<xsl:element name="g">
			<xsl:attribute name="id"><xsl:value-of select="@id"/></xsl:attribute>
			<xsl:comment>begin basic guitar image</xsl:comment>

			<!-- chord label -->
			<xsl:comment>chord label</xsl:comment>
			<xsl:element name="text">
				<xsl:attribute name="class">label</xsl:attribute>
				<xsl:attribute name="x">192</xsl:attribute>
				<xsl:attribute name="y">47</xsl:attribute>
				<xsl:call-template name="choosename"/>
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
				<xsl:attribute name="height"><xsl:value-of select="50 * $maxfret"/></xsl:attribute>
			</xsl:element>

			<!-- plot - frets -->
			<xsl:comment>plot - frets</xsl:comment>
			<xsl:call-template name="procfret">
				<xsl:with-param name="count" select="1"/>
				<xsl:with-param name="max" select="$maxfret"/>
			</xsl:call-template>


			<!-- plot - strings -->
			<xsl:comment>plot - strings</xsl:comment>
			<xsl:element name="line">
				<xsl:attribute name="class">strings</xsl:attribute>
				<xsl:attribute name="x1">117</xsl:attribute>
				<xsl:attribute name="y1">94</xsl:attribute>
				<xsl:attribute name="x2">117</xsl:attribute>
				<xsl:attribute name="y2"><xsl:value-of select="100 + 50 * $maxfret - 1"/></xsl:attribute>
			</xsl:element>
			<xsl:element name="line">
				<xsl:attribute name="class">strings</xsl:attribute>
				<xsl:attribute name="x1">147</xsl:attribute>
				<xsl:attribute name="y1">94</xsl:attribute>
				<xsl:attribute name="x2">147</xsl:attribute>
				<xsl:attribute name="y2"><xsl:value-of select="100 + 50 * $maxfret - 1"/></xsl:attribute>
			</xsl:element>
			<xsl:element name="line">
				<xsl:attribute name="class">strings</xsl:attribute>
				<xsl:attribute name="x1">177</xsl:attribute>
				<xsl:attribute name="y1">94</xsl:attribute>
				<xsl:attribute name="x2">177</xsl:attribute>
				<xsl:attribute name="y2"><xsl:value-of select="100 + 50 * $maxfret - 1"/></xsl:attribute>
			</xsl:element>
			<xsl:element name="line">
				<xsl:attribute name="class">strings</xsl:attribute>
				<xsl:attribute name="x1">207</xsl:attribute>
				<xsl:attribute name="y1">94</xsl:attribute>
				<xsl:attribute name="x2">207</xsl:attribute>
				<xsl:attribute name="y2"><xsl:value-of select="100 + 50 * $maxfret - 1"/></xsl:attribute>
			</xsl:element>
			<xsl:element name="line">
				<xsl:attribute name="class">strings</xsl:attribute>
				<xsl:attribute name="x1">237</xsl:attribute>
				<xsl:attribute name="y1">94</xsl:attribute>
				<xsl:attribute name="x2">237</xsl:attribute>
				<xsl:attribute name="y2"><xsl:value-of select="100 + 50 * $maxfret - 1"/></xsl:attribute>
			</xsl:element>
			<xsl:element name="line">
				<xsl:attribute name="class">strings</xsl:attribute>
				<xsl:attribute name="x1">267</xsl:attribute>
				<xsl:attribute name="y1">94</xsl:attribute>
				<xsl:attribute name="x2">267</xsl:attribute>
				<xsl:attribute name="y2"><xsl:value-of select="100 + 50 * $maxfret - 1"/></xsl:attribute>
			</xsl:element>

			<xsl:comment>end basic guitar image</xsl:comment>

			<!-- process next -->
			<xsl:apply-templates/>

		</xsl:element>
	</xsl:element>
</xsl:template>

<xsl:template match="text()"/>

<!-- recursive drawing of frets (the max in real life is limited aprox. to 20) -->
<xsl:template name="procfret">
<xsl:param name="count"/>
<xsl:param name="max"/>

	<xsl:if test="$count &lt; $max">
		<!-- draw actual fret -->
		<xsl:call-template name="drawfret">
			<xsl:with-param name="fretnum" select="$count"/>
		</xsl:call-template>
		<!-- call next processing -->
		<xsl:call-template name="procfret">
			<xsl:with-param name="count" select="$count + 1"/>
			<xsl:with-param name="max" select="$max"/>
		</xsl:call-template>
	</xsl:if>

</xsl:template>

<!-- draw the fret -->
<xsl:template name="drawfret">
<xsl:param name="fretnum"/>
	<xsl:element name="line">
		<xsl:attribute name="class">frets</xsl:attribute>
		<xsl:attribute name="x1">102</xsl:attribute>
		<xsl:attribute name="y1"><xsl:value-of select="102 + 50 * $fretnum"/></xsl:attribute>
		<xsl:attribute name="x2">282</xsl:attribute>
		<xsl:attribute name="y2"><xsl:value-of select="102 + 50 * $fretnum"/></xsl:attribute>
	</xsl:element>

</xsl:template>


<xsl:template match="position">
	<xsl:comment>position</xsl:comment>
	<xsl:element name="g">
	<xsl:choose>
	<xsl:when test="@name">
		<xsl:attribute name="id"><xsl:value-of select="../name"/>.<xsl:value-of select="@name"/></xsl:attribute>
	</xsl:when>
	<xsl:otherwise>
		<xsl:attribute name="id"><xsl:value-of select="../name"/>.<xsl:value-of select="position()"/></xsl:attribute>
	</xsl:otherwise>
	</xsl:choose>

	<xsl:variable name="basefret" select="@fretlabel"/>
	<xsl:variable name="basedrawfret" select="@base"/>

			<xsl:element name="text">
				<xsl:attribute name="class">barrenum</xsl:attribute>
				<xsl:attribute name="x">85</xsl:attribute>
				<xsl:attribute name="y"><xsl:value-of select="($basedrawfret+1) * 50 + 72 -32"/></xsl:attribute>
				<xsl:number value="$basefret" format="I"/><xsl:text>.</xsl:text>
			</xsl:element>

	<xsl:apply-templates/>

	</xsl:element>
</xsl:template>

<xsl:template match="string">
	<xsl:choose>
		<xsl:when test="@state='no'">
			<!-- disabled string -->
			<xsl:call-template name="docircle">
				<xsl:with-param name="stringname"><xsl:value-of select="@name"/></xsl:with-param>
				<xsl:with-param name="y"><xsl:value-of select="@fret * 50 + 77"/></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
                <xsl:when test="@state='open'">
			<!-- open string -->
			<xsl:call-template name="docircle">
				<xsl:with-param name="stringname"><xsl:value-of select="@name"/></xsl:with-param>
				<xsl:with-param name="y"><xsl:value-of select="@fret * 50 + 21"/></xsl:with-param>
			</xsl:call-template>
		</xsl:when>
		<xsl:otherwise>
			<!-- classic string - full or optional -->
			<xsl:call-template name="string"/>
		</xsl:otherwise>
		</xsl:choose>

</xsl:template>

<!-- process one barre info -->
<xsl:template match="barre">
	<xsl:comment>barre</xsl:comment>

	<xsl:variable name="y" select="@fret * 50 + 77"/>

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


<xsl:template match="separator">
	<!-- this is the max @fret number in this position -->
	<xsl:variable name="ys" select="@fret * 50 + 72"/>
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
</xsl:template>


<xsl:template match="endneck">
	<!-- this is the max @fret number in this position -->
	<xsl:variable name="ys" select="@fret * 50 + 72"/>
	<!-- this must be the same as in the beginning of the file!!! -->
	<xsl:variable name="maxy" select="100 + (@fret + 1) * 50"/>

	<xsl:comment>endneck</xsl:comment>
	<!-- spacer -->
	<xsl:element name="path">
		<xsl:attribute name="class">spacer</xsl:attribute>
		<xsl:attribute name="d">M87,<xsl:value-of select="$ys"/> A100,40 0 0,0 192,<xsl:value-of select="$ys"/> A100,40 0 0,1 297,<xsl:value-of select="$ys"/> L297,<xsl:value-of select="$maxy"/> L87,<xsl:value-of select="$maxy"/> Z</xsl:attribute>
	</xsl:element>
	<!-- line -->
	<xsl:element name="path">
		<xsl:attribute name="class">spacerline</xsl:attribute>
		<xsl:attribute name="d">M87,<xsl:value-of select="$ys"/> A100,40 0 0,0 192,<xsl:value-of select="$ys"/> A100,40 0 0,1 297,<xsl:value-of select="$ys"/></xsl:attribute>
	</xsl:element>

</xsl:template>


<!-- process one string info -->
<xsl:template name="string">

	<xsl:comment><xsl:value-of select="@name"/></xsl:comment>

	<!-- do the circle -->
	<xsl:call-template name="docircle">
		<xsl:with-param name="stringname" select="@name"/>
		<xsl:with-param name="y" select="@fret * 50 + 77"/>
	</xsl:call-template>

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
