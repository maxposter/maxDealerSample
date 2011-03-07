<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:template match="search_form">
        <div class="span-17 last" id="search_form">
            <xsl:choose>
                <xsl:when test="./*[starts-with(@name, 'search')][@error]">
                    <h3>Ошибка в параметрах поиска</h3>
                </xsl:when>
                <xsl:otherwise>
                    <h3>Поиск</h3>
                </xsl:otherwise>
            </xsl:choose>
            <form action="/" method="get">
                <div class="span-9">
                    <xsl:call-template name="field">
                        <xsl:with-param name="label" select="'Марка'" />
                        <xsl:with-param name="element" select="./*[@name='search[mark_id]']" />
                    </xsl:call-template>
                    <xsl:call-template name="field">
                        <xsl:with-param name="label" select="'Модель'" />
                        <xsl:with-param name="element" select="./*[@name='search[model_id]']" />
                    </xsl:call-template>
                    <xsl:call-template name="field">
                        <xsl:with-param name="label" select="'Год выпуска'" />
                        <xsl:with-param name="element" select="./*[@name='search[year_id]']" />
                    </xsl:call-template>
                    <div class="span-3">
                        <label for="search_price_from">Цена</label>
                    </div>
                    <div class="span-6 last">
                        <xsl:apply-templates select="./*[@name='search[price][from]']" />
                        <label for="search_price_to"> до </label>
                        <xsl:apply-templates select="./*[@name='search[price][to]']" />
                        <xsl:call-template name="hidden_field">
                            <xsl:with-param name="element" select="./*[@name='search[price][unit]']" />
                        </xsl:call-template>
                        <b> руб.</b>
                        <xsl:call-template name="error">
                            <xsl:with-param name="element" select="./*[@name='search[price][from]']" />
                        </xsl:call-template>
                    </div>
                </div>
                <div class="span-8 last">
                    <xsl:call-template name="field">
                        <xsl:with-param name="label" select="'Кузов'" />
                        <xsl:with-param name="element" select="./*[@name='search[body_type]']" />
                    </xsl:call-template>
                    <xsl:call-template name="field">
                        <xsl:with-param name="label" select="'Двигатель'" />
                        <xsl:with-param name="element" select="./*[@name='search[engine_type]']" />
                    </xsl:call-template>
                    <xsl:call-template name="field">
                        <xsl:with-param name="label" select="'КПП'" />
                        <xsl:with-param name="element" select="./*[@name='search[gearbox_type]']" />
                    </xsl:call-template>
                    <xsl:call-template name="field">
                        <xsl:with-param name="label" select="'Привод'" />
                        <xsl:with-param name="element" select="./*[@name='search[drive_type]']" />
                    </xsl:call-template>
                    <div class="span-2">
                        <input type="submit" value="Найти" />
                    </div>
                    <div class="span-3 last">
                        <a href="/">Cбросить фильтр</a>
                    </div>
                </div>
            </form>
        </div>
    </xsl:template>

    <xsl:template name="field">
        <xsl:param name="label" />
        <xsl:param name="element" />
        <div class="span-3">
            <label for="{translate($element/@name, '[]','_')}">
                <xsl:value-of select="$label" />
            </label>
        </div>
        <div class="span-5 last">
            <xsl:apply-templates select="$element" />
            <xsl:call-template name="error">
                <xsl:with-param name="element" select="$element"/>
            </xsl:call-template>
        </div>
    </xsl:template>

    <xsl:template match="list">
        <xsl:param name="empty_option" select="1" />
        <select name="{@name}" id="{translate(@name, '[]','_')}" class="span-5">
            <xsl:if test="$empty_option">
                <option value=''></option>
            </xsl:if>
            <xsl:apply-templates select="*" />
        </select>
    </xsl:template>

    <xsl:template match="optgroup">
        <optgroup label="{@label}" id="mark{@mark_id}">
            <xsl:apply-templates select="./*" />
        </optgroup>
    </xsl:template>

    <xsl:template match="option">
        <xsl:copy>
            <xsl:apply-templates select="* | @* |text()" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="@*">
        <xsl:copy>
            <xsl:apply-templates select="@*" />
        </xsl:copy>
    </xsl:template>

    <xsl:template match="field">
        <input name="{@name}" id="{translate(@name, '[]','_')}" value="{@value}" size="{@size}" class="span-2" />
    </xsl:template>

    <xsl:template name="hidden_field">
        <xsl:param name="element" />
        <xsl:param name="value" />
        <input name="{$element/@name}" id="{translate($element/@name, '[]','_')}" value="{$value}" type="hidden">
            <xsl:attribute name="value">
                <xsl:choose>
                    <xsl:when test="'list' = local-name($element)">
                        <xsl:value-of select="$element//option[position() = 1]/@value" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$element/@value" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
        </input>
    </xsl:template>

    <xsl:template name="error">
        <xsl:param name="element" />
        <xsl:if test="$element[@error]">
            <div class="error">
                <xsl:value-of select="$element/@error" />
            </div>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
