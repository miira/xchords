<?xml version="1.0"?>
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

    <xsl:output method="xml" indent="yes"
        doctype-system="../src/xchords.dtd"
        doctype-public="-//Chopin Musical Solutions//DTD XChords//en"/>


    <!-- make sorted copy -->
    <xsl:template match="chordlibrary">
        <xsl:copy>
            <xsl:apply-templates/>
        <xsl:for-each select="//chord">
            <xsl:sort select="@id"/>
            <xsl:copy-of select="."/>
        </xsl:for-each>
        </xsl:copy>
    </xsl:template>

    <xsl:template match="desc">
        <xsl:copy-of select="."/>
    </xsl:template>

    <xsl:template match="text()"/>
</xsl:stylesheet>