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

    <xsl:template name="car_main">
        <div class="car_main">
            <h3>Основные характеристики</h3>
            <div class="span-8">
                <div class="span-3">Год выпуска:</div>
                <xsl:value-of select="./year" />
            </div>
            <div class="span-8">
                <div class="span-2">Кузов:</div>
                <xsl:value-of select="./body/type" />
            </div>
            <div class="span-8">
                <div class="span-3">Двигатель:</div>
                <xsl:value-of select="./engine/type" />
                <xsl:text>, </xsl:text>
                <xsl:value-of select="./engine/volume " />
                <xsl:text> см3</xsl:text>
            </div>
            <div class="span-8">
                <div class="span-2">Руль:</div>
                <xsl:value-of select="./steering_wheel/place"/>
            </div>
            <div class="span-8">
                <div class="span-3">Привод:</div>
                <xsl:value-of select="./drive/type"/>
            </div>
            <div class="span-8">
                <div class="span-2">Пробег:</div>
                <xsl:value-of select="./mileage/value"/>
                <xsl:choose>
                    <xsl:when test="./mileage/value/@unit = 'km'">
                        <xsl:text> км.</xsl:text>
                    </xsl:when>
                    <xsl:when test="./mileage/value/@unit = 'mile'">
                        <xsl:text> миль</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </div>
            <div class="span-8">
                <div class="span-3">КПП:</div>
                <xsl:value-of select="./gearbox/type" />
            </div>
            <div class="span-8">
                <div class="span-2">Состояние:</div>
                <xsl:value-of select="./condition" />
            </div>
            <div class="span-8">
                <div class="span-3">Цена:</div>
                <xsl:choose>
                    <xsl:when test="./price/value/@unit = 'eur'">
                        <xsl:text>€ </xsl:text>
                        <xsl:value-of select="./price/value" />
                    </xsl:when>
                    <xsl:when test="./price/value/@unit = 'usd'">
                        <xsl:text>$ </xsl:text>
                        <xsl:value-of select="./price/value" />
                    </xsl:when>
                    <xsl:when test="./price/value/@unit = 'rub'">
                        <xsl:value-of select="./price/value" />
                        <xsl:text> руб.</xsl:text>
                    </xsl:when>
                </xsl:choose>
            </div>
        </div>
        <div class="clear"></div>
    </xsl:template>

    <xsl:template name="car_options"></xsl:template>
    <xsl:template match="photos"></xsl:template>
    <xsl:template match="description"></xsl:template>
    <xsl:template name="car_contact"></xsl:template>
</xsl:stylesheet>
