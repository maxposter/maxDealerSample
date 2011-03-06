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

    <xsl:template name="car_options">
        <div class="car_options">
            <h3>Комплектация</h3>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Антиблокировочная система (АБС)'" />
                <xsl:with-param name="element" select="./abs" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Антипробуксовочная система'" />
                <xsl:with-param name="element" select="./asr" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Система курсовой стабилизации'" />
                <xsl:with-param name="element" select="./esp" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Парктроник'" />
                <xsl:with-param name="element" select="./parktronic" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Подушки безопасности: '" />
                <xsl:with-param name="element" select="./airbag" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Охранная система'" />
                <xsl:with-param name="element" select="./alarm_system" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Центральный замок'" />
                <xsl:with-param name="element" select="./central_lock" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Навигационная система'" />
                <xsl:with-param name="element" select="./nav_system" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Легкосплавные диски'" />
                <xsl:with-param name="element" select="./light_alloy_wheels" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Датчик дождя'" />
                <xsl:with-param name="element" select="./sensors/rain" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Датчик света'" />
                <xsl:with-param name="element" select="./sensors/light" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Омыватель фар'" />
                <xsl:with-param name="element" select="./headlights/washer" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Ксеноновые фары'" />
                <xsl:with-param name="element" select="./headlights/xenon" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Салон: '" />
                <xsl:with-param name="element" select="./compartment" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Тонированные стекла'" />
                <xsl:with-param name="element" select="./windows/tinted" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Люк'" />
                <xsl:with-param name="element" select="./hatch" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Газобалонное оборудование'" />
                <xsl:with-param name="element" select="./engine/gas_equipment" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Круиз-контроль'" />
                <xsl:with-param name="element" select="./cruise_control" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Бортовой компьютер'" />
                <xsl:with-param name="element" select="./trip_computer" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Усилитель рулевого управления: '" />
                <xsl:with-param name="element" select="./steering_wheel/power" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Регулировка руля: '" />
                <xsl:with-param name="element" select="./steering_wheel/adjustment" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Обогрев руля'" />
                <xsl:with-param name="element" select="./steering_wheel/heater" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Электрозеркала'" />
                <xsl:with-param name="element" select="./mirrors/power" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Обогрев зеркал'" />
                <xsl:with-param name="element" select="./mirrors/defroster" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Электростеклоподъемники: '" />
                <xsl:with-param name="element" select="./windows/power" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Обогрев сидений'" />
                <xsl:with-param name="element" select="./seats/heater" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Регулировка сиденья водителя: '" />
                <xsl:with-param name="element" select="./seats/driver_adjustment" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Электропривод сиденья пассажира'" />
                <xsl:with-param name="element" select="./seats/passanger_adjustment" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Управление климатом: '" />
                <xsl:with-param name="element" select="./climate_control" />
            </xsl:call-template>
            <xsl:call-template name="option">
                <xsl:with-param name="label" select="'Стереосистема: '" />
                <xsl:with-param name="element" select="./audio" />
            </xsl:call-template>
        </div>
        <div class="clear"></div>
    </xsl:template>

    <xsl:template name="option">
        <xsl:param name="label" />
        <xsl:param name="element"/>
        <xsl:if test="$element">
            <div class="span-8">
                <span>
                    <xsl:value-of select="$label" />
                </span>
                <xsl:apply-templates select="$element" />
            </div>
        </xsl:if>
    </xsl:template>

    <xsl:template match="photos"></xsl:template>
    <xsl:template match="description"></xsl:template>
    <xsl:template name="car_contact"></xsl:template>
</xsl:stylesheet>
