<?xml version="1.0"?>
<xsl:stylesheet version="1.0" 
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:chord="http://xchords.barad.cz/2003/XChords"
  >
<xsl:param name="langcode">cs</xsl:param>

<!-- This is for choosing name from no-namespace intermediate files. 
     Svg target, for example. -->
<xsl:template name="choosename">
    <xsl:choose>
        <xsl:when test="name[lang($langcode)]">
            <xsl:value-of select="name[lang($langcode)]"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="name[lang('en')]"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>

<!-- This is for choosing name from namespaced original data file. (and from parent elem)
     Plain target, for example. -->
<xsl:template name="choosename2">
    <xsl:choose>
        <xsl:when test="../chord:name[lang($langcode)]">
            <xsl:value-of select="../chord:name[lang($langcode)]"/>
        </xsl:when>
        <xsl:when test="../chord:name[lang('en')]">
            <xsl:value-of select="../chord:name[lang('en')]"/>
        </xsl:when>
        <xsl:otherwise>
            <xsl:value-of select="../chord:name"/>
        </xsl:otherwise>
    </xsl:choose>
</xsl:template>
</xsl:stylesheet>