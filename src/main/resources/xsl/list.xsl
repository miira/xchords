<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:redirect="http://xml.apache.org/xalan/redirect"
  
  xmlns:chord="http://xchords.barad.cz/2003/XChords" 
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  extension-element-prefixes="redirect"
  exclude-result-prefixes="xsi chord #default">
<xsl:strip-space elements="*"/>
<xsl:output method="xml"
	    omit-xml-declaration="no"
	    indent="yes"/>
<xsl:param name="directory"/>
<!-- 
This stylesheet produces list of files, that will be generated. 
For use with stylesheets in next steps.
-->

<xsl:template match="chord:chordlibrary">

	<xsl:element name="chordlist">
		<!--<xsl:copy-of select="@*"/>-->
		<xsl:apply-templates/>
	</xsl:element>
</xsl:template>


<!-- 
Each chord would produce record in list file and apropriate NAME.pre file.
New attributes:
	positions	=	number of positions, the chord has
 -->
<xsl:template match="chord:chord">
	<!--<xsl:variable name="name"><xsl:value-of select="translate(@name,'/#','_~')"/></xsl:variable>-->
	<!--<xsl:variable name="name"><xsl:value-of select="@id"/></xsl:variable>-->
	<xsl:variable name="name" select="substring-after(@id, '-')" />
	<xsl:variable name="filename"><xsl:value-of select="$directory"/><xsl:value-of select="$name"/>.pre</xsl:variable>
	<xsl:message><xsl:value-of select="$filename"/></xsl:message>
	
	<xsl:element name="chordfile" >
		<xsl:copy-of select="@*"/>
		<xsl:attribute name="file"><xsl:value-of select="$name"/></xsl:attribute>
	</xsl:element>

	<!-- create the file -->
	<!--<redirect:open file="$filename"/>-->
	<redirect:write file="{$filename}">
	<!--<redirect:write select="$filename" method="xml" xsl:exclude-result-prefixes="xsi chord #default" >-->
	<!--<xsl:document href="{$filename}" method="xml">-->
		<xsl:variable name="poscount" select="count(child::chord:position)"/>
                <xsl:element name="chord">
        <!--<xsl:copy>-->
			<!--<xsl:copy-of select="@*"/>-->
			<xsl:attribute name="positions"><xsl:value-of select="$poscount"/></xsl:attribute>
			
			<xsl:apply-templates/>
		<!--</xsl:copy>-->
                </xsl:element>
<!--	</xsl:document>	-->
	</redirect:write>
	<!--<redirect:close file="$filename"/>-->

</xsl:template>


</xsl:stylesheet>
