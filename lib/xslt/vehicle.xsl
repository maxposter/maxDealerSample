<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
        doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
        encoding="utf-8" indent="yes" />

    <xsl:template match="vehicle">
        <h1>
            <xsl:value-of select="./mark" />
            <xsl:text>    </xsl:text>
            <xsl:value-of select="./model" />
        </h1>

        <!-- Вывод основных характеристик -->
        <xsl:call-template name="car_main" />

        <!-- Вывод комплектации -->
        <xsl:call-template name="car_options" />

        <!-- Вывод фото -->
        <xsl:apply-templates select="./photos" />

        <!-- Вывод дополнительной информации -->
        <xsl:apply-templates select="./description" />

        <!-- Вывод контактов -->
        <xsl:call-template name="car_contact" />
    </xsl:template>

    <xsl:template name="car_main"></xsl:template>
    <xsl:template name="car_options"></xsl:template>
    <xsl:template match="photos"></xsl:template>
    <xsl:template match="description"></xsl:template>
    <xsl:template name="car_contact"></xsl:template>
</xsl:stylesheet>
