<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:chord="http://xchords.barad.cz/2003/XChords"
  >

<xsl:template match="chord:chordlibrary">
	<xsl:element name="html">
		<xsl:element name="head">
		<xsl:element name="title">XChords</xsl:element>
		<xsl:element name="link">
			<xsl:attribute name="rel">stylesheet</xsl:attribute>
			<xsl:attribute name="type">text/css</xsl:attribute>
			<xsl:attribute name="href">plain.css</xsl:attribute>
		</xsl:element>
	</xsl:element>
	
	<xsl:element name="body">
	
		<xsl:element name="table">
			<xsl:attribute name="border">0</xsl:attribute>
			<xsl:element name="thead">
				<xsl:element name="tr">
					<xsl:apply-templates mode="info"/>
					<xsl:element name="td">
						<xsl:attribute name="class">headerchord</xsl:attribute>
						<xsl:text>Chord Name</xsl:text>
					</xsl:element>
					<xsl:element name="td">
						<xsl:attribute name="class">headerdef</xsl:attribute>
						<xsl:text>Definition</xsl:text>
					</xsl:element>
				</xsl:element>		
			</xsl:element>
			<xsl:apply-templates/>
		</xsl:element>
                
                <xsl:element name="p">Output produced by XChords 0.3</xsl:element>
	</xsl:element>
	</xsl:element>
		
</xsl:template>

<xsl:template match="text()" mode="info"/>

<xsl:template match="desc" mode="info">
		<xsl:element name="tr">
			<xsl:element name="td">
				<xsl:attribute name="colspan">2</xsl:attribute>
				<xsl:attribute name="class">desc</xsl:attribute>
				<xsl:copy-of select="."/>
			</xsl:element>
		</xsl:element>
</xsl:template>

<xsl:template match="desc"/>

</xsl:stylesheet>