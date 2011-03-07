<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
        doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
        encoding="utf-8" indent="yes" />

    <xsl:template match="/">
        <h2 class="makes">В продаже:</h2>
        <ul class="makes">
            <xsl:apply-templates select="/response/marks/mark" />
        </ul>
    </xsl:template>
    <xsl:template match="mark">
        <li>
            <a href="/?search[mark_id]={@mark_id}">
                <strong>
                    <xsl:value-of select="name" />
                    <xsl:text> (</xsl:text>
                    <xsl:value-of select="count" />
                    <xsl:text> шт.) </xsl:text>
                </strong>
            </a>
            <ul>
                <xsl:apply-templates select="./models/model" />
            </ul>
        </li>
    </xsl:template>
    <xsl:template match="model">
        <li>
            <a href="/?search[model_id]={@model_id}">
                <xsl:value-of select="name" />
                <xsl:text> (</xsl:text>
                <xsl:value-of select="count" />
                <xsl:text> шт.) </xsl:text>
            </a>
        </li>
    </xsl:template>
</xsl:stylesheet>
