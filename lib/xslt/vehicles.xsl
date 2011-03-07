<?xml version="1.0" encoding="utf-8" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:output method="xml"
        doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd"
        doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
        encoding="utf-8" indent="yes" />

    <!--
    Поскольку посчитать количество автомобилей необходимо для нескольких
    задач в шаблоне, сохраним результат расчета в переменной.
    -->
    <xsl:variable name="count" select="count(/response/vehicles/vehicle)" />

    <xsl:template match="/">
        <!-- Правило для корневого элемента. Отсюда стартует преобразование. -->
        <h1>Автомобили в продаже</h1>
        <!-- Принудительно выводим только ноды, вложенные в vehicles -->
        <xsl:apply-templates select="/response/vehicles" />
    </xsl:template>

    <!-- Преобразование списка автомобилей -->
    <xsl:template match="vehicles">
        <div class="cars">
            <xsl:choose>
                <xsl:when test="$count > 0">
                    <h3>Количество автомобилей: <xsl:value-of select="$count" /></h3>
                    <xsl:apply-templates select="/response/vehicles/vehicle[position()>(($page - 1)*$rows) and ($page*$rows)>=position()]" />
                </xsl:when>
                <xsl:otherwise>
                    <p>Не найдено ни одного автомобиля</p>
                </xsl:otherwise>
            </xsl:choose>
        </div>
    </xsl:template>

    <!-- Преобразование для конкретного автомобиля -->
    <xsl:template match="vehicle">
        <a href="/{@vehicle_id}">
            <div class="car">
                <img class="photo" width="120" height="90">
                    <xsl:attribute name="src">
                        <xsl:choose>
                            <!-- Если есть фото, выводим его -->
                            <xsl:when test="./photo/thumbnail">
                                <xsl:value-of select="./photo/thumbnail" />
                            </xsl:when>
                            <!-- Если фото у автомобиля нет, выводим заглушку -->
                            <xsl:otherwise>
                                <xsl:text>/css/img/nophoto.png</xsl:text>
                            </xsl:otherwise>
                        </xsl:choose>
                    </xsl:attribute>
                </img>
                <div class="price">
                    <span>Цена: </span>
                    <div>
                        <!-- Цены в разных валютах выводятся по разным правилам -->
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
                <!-- Название авто формируется из трех значений: Марка, модель, год -->
                <h3>
                    <xsl:value-of select="./mark" />
                    <xsl:text> </xsl:text>
                    <xsl:value-of select="./model" />
                    <xsl:text>, </xsl:text>
                    <xsl:value-of select="./year" />
                    <xsl:text> г.в.</xsl:text>
                </h3>
                <!-- Характеристики авто: указываем явно что и в какой последовательности выводить -->
                <span>Кузов: </span>
                <xsl:value-of select="./body/type" />
                <xsl:text> </xsl:text>
                <span>Пробег: </span>
                <xsl:value-of select="./mileage/value" />
                <xsl:choose>
                    <xsl:when test="./mileage/value/@unit = 'km'">
                        <xsl:text> км.</xsl:text>
                    </xsl:when>
                    <xsl:when test="./mileage/value/@unit = 'mile'">
                        <xsl:text> миль</xsl:text>
                    </xsl:when>
                </xsl:choose>
                <br />
                <span>Привод: </span>
                <xsl:value-of select="./drive/type" />
                <xsl:text> </xsl:text>
                <span>КПП: </span>
                <xsl:value-of select="./gearbox/type" />
                <xsl:text> </xsl:text>
                <br />
                <span>Двигатель: </span>
                <xsl:value-of select="./engine/type" />
                <xsl:text>, </xsl:text>
                <xsl:value-of select="./engine/volume " />
                <xsl:text> см3</xsl:text>
                <br />
                <span>Состояние: </span>
                <xsl:value-of select="./condition" />
                <xsl:text> </xsl:text>
            </div>
            <div class="clear"></div>
        </a>
    </xsl:template>
</xsl:stylesheet>
