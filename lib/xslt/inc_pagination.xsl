<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <!--
    Разбивка длинных XML на страницы
    требует наличия рассчитанных переменных:
    - $count - количество строк всего в XML;
    - $page - номер текущей страницы;
    - $rows - количество строк на одной странице
    -->
    <!-- Именованный шаблон для вывода ссылок постраничной навигации -->
    <xsl:template name="Navigation">
        <xsl:variable name="pagecount" select="ceiling($count div $rows)" />
        <xsl:if test="$pagecount>1">
            <div class="pagination">
                <xsl:call-template name="NavigationItem">
                    <xsl:with-param name="currentpage" select="1" />
                    <xsl:with-param name="pagecount" select="$pagecount" />
                </xsl:call-template>
            </div>
        </xsl:if>
    </xsl:template>

    <!-- Именованный шаблон для вывода ссылки на конкретную страницу -->
    <xsl:template name="NavigationItem">
        <xsl:param name="currentpage" />
        <xsl:param name="pagecount" />
        <xsl:if test="$currentpage>0">
            <xsl:text> </xsl:text>
        </xsl:if>
        <xsl:text>[</xsl:text>
        <xsl:choose>
            <xsl:when test="$page!=$currentpage">
                <a>
                    <xsl:attribute name="href">
                        <xsl:text>/?</xsl:text>
                        <xsl:text>page=</xsl:text><xsl:value-of select="$currentpage" />
                    </xsl:attribute>
                    <xsl:value-of select="($currentpage - 1) * $rows + 1" />
                    <xsl:text>-</xsl:text>
                    <xsl:choose>
                        <xsl:when test="$pagecount=$currentpage">
                            <xsl:value-of select="$count" />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$currentpage * $rows" />
                        </xsl:otherwise>
                    </xsl:choose>
                </a>
            </xsl:when>
            <xsl:otherwise>
                <xsl:value-of select="($currentpage - 1) * $rows + 1" />
                <xsl:text>-</xsl:text>
                <xsl:choose>
                    <xsl:when test="$pagecount=$currentpage">
                        <xsl:value-of select="$count" />
                    </xsl:when>
                    <xsl:otherwise>
                        <xsl:value-of select="$currentpage * $rows" />
                    </xsl:otherwise>
                </xsl:choose>
            </xsl:otherwise>
        </xsl:choose>
        <xsl:text>]</xsl:text>
        <xsl:if test="$pagecount>$currentpage ">
            <xsl:call-template name="NavigationItem">
                <xsl:with-param name="currentpage" select="$currentpage+1" />
                <xsl:with-param name="pagecount" select="$pagecount" />
            </xsl:call-template>
        </xsl:if>
    </xsl:template>
</xsl:stylesheet>
