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
}
