<?php
class demoClient extends maxCacheHtmlClient
{
    // Параметры, не влияющие на запрос XML
    protected $xslParams = array();


    /**
     * Удаление из URI GET-параметров запроса
     *
     * @return string
     */
    protected function getRequestURI()
    {
        $questionMarkPosition = strpos($_SERVER['REQUEST_URI'], '?');

        return false !== $questionMarkPosition
            ? substr($_SERVER['REQUEST_URI'], 0, $questionMarkPosition)
            : $_SERVER['REQUEST_URI']
            ;
    }


    /**
     * Определение по URI темы запроса и парметров
     *
     * @return this
     */
    public function setRequest()
    {
        $requestURI = $this->getRequestURI();
        // Если список авто
        if (preg_match('/^\/$/', $requestURI)) {
            // Устанавливаем тему запроса vehicles
            $this->setRequestThemeName('vehicles');

            // Получение номера страницы и валидация на минимальное значение
            $this->xslParams['page'] = isset($_GET['page']) ? intval($_GET['page']) : 1;
            if (1 > $this->xslParams['page']) {
                // При обнаружении невалидного значения выбрасываем exception, до запроса XML
                throw maxException::getException(maxException::ERR_404);
            }

            // Получение данных из формы поиска автомобиля
            if (isset($_GET['search']) && is_array($_GET['search'])) {
                $this->setRequestParams(array('search' => $_GET['search'])); // Параметры фильтрации
            }
        }
        // Если описание авто
        elseif (preg_match('/^\/([0-9]{1,6})$/', $requestURI, $params)) {
            // Устанавливаем тему запроса равную коду объявления
            $this->setRequestThemeName($params[1]);
        }

        return $this;
    }


    /**
     * Директивы по загрузке JS библиотек и их инициализации
     *
     * @return string
     */
    public function getJS()
    {
        $ret = '';
        // Если в качестве темы запроса задан числовой идентификатор объявления
        if (is_numeric($this->getRequestThemeName())) {
            $ret = <<<EOD
<script type="text/javascript" src="http://yandex.st/mootools/1.2.4/mootools.min.js"></script>
<script type="text/javascript" src="/js/mootools-1.2-more.js"></script>
<script type="text/javascript" src="/js/galery.js"></script>
<script type="text/javascript">
//<![CDATA[
window.addEvent('domready', function(){
var galery = new Gallery();
});
//]]>
</script>
EOD;
        }

        return $ret;
    }


    /**
     * Добавление параметров класаа
     *
     * @return array Параметры класса по умолчанию
     */
    protected function getDefaultOptions()
    {
        return array_merge(
            parent::getDefaultOptions(),
            array(
                // Количество объявлений на странице со списком авто
                'rows_by_page' => 10,
            )
        );
    }


    /**
     * Метод перекрыт для валидации значений запроса в максимально ранний момент
     */
    protected function loadXml()
    {
        parent::loadXml();

        // Валидация значений, используемых при XSLT-преобразовании ответа
        switch ($this->getResponseThemeName()) {
            case 'vehicles':
                // Валидация номера страницы на максимальное значение
                $vehicles = $this->xml->getElementsByTagName('vehicle');
                $maxPage = ceil($vehicles->length/$this->getOption('rows_by_page'));
                $maxPage = ($maxPage < 1) ? 1 : $maxPage;
                if ($maxPage < $this->xslParams['page']) {
                    throw maxException::getException(maxException::ERR_404);
                }
                break;
        }
    }


    /**
     * Метод перекрыт для добавления параметров, используемых при XSL-преобразовании
     *
     * @param unknown_type $_xstlName
     * @return unknown
     */
    protected function getXslDom($_xstlName)
    {
        $xsl = parent::getXslDom($_xstlName);
        // Корневой элемент, в который добавляются переменные
        $root = $xsl->getElementsByTagName('stylesheet')->item(0);
        switch ($this->getResponseThemeName()) {
            case 'vehicles':
                // Добавление номера страницы и количество авто на странице
                $xsl = $this->appendVariable($xsl, $root, 'page', $this->xslParams['page']);
                $xsl = $this->appendVariable($xsl, $root, 'rows', $this->getOption('rows_by_page'));
                break;
        }

        return $xsl;
    }


    /**
     * Добавление переменной в XSLT шаблон
     *
     * @param DOMDocument $_xsl
     * @param DOMNode $_root
     * @param string $_name
     * @param string $_value
     * @return DOMDocument
     */
    protected function appendVariable(DOMDocument $_xsl, DOMNode $_root, $_name, $_value)
    {
        $newNode = $_xsl->createElementNS('http://www.w3.org/1999/XSL/Transform', 'xsl:variable', $_value);
        $attr = $_xsl->createAttribute('name');
        $attr->appendChild($_xsl->createTextNode($_name));
        $newNode->appendChild($attr);
        $_root->appendChild($newNode);

        return $_xsl;
    }


    /**
     * Добавление к хэшу xsl-параметров, чтобы кэш страницы 1 отличался от кэша
     * страницы No2 и кэш описния авто с активным фото No1 отличался от кэша
     * с активным фото 2 при отключенном JS
     *
     * @param unknown_type $_themeName
     * @return unknown
     */
    protected function getHtmlCacheHashKey($_themeName)
    {
        return parent::getHtmlCacheHashKey($_themeName).$this->getRequestParamsAsString($this->xslParams);
    }
}
