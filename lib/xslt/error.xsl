<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
        doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
        encoding="utf-8" indent="yes" />

    <xsl:template match="/">
        <h1>
            <xsl:text>Ошибка No </xsl:text>
            <xsl:value-of select="/response/error/@error_id" />
        </h1>
        <xsl:value-of select="/response/error" />
    </xsl:template>
</xsl:stylesheet>
