<?php
class demoClient extends maxCacheHtmlClient
{
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
        }
        // Если описание авто
        elseif (preg_match('/^\/([0-9]{1,6})$/', $requestURI, $params)) {
            // Устанавливаем тему запроса равную коду объявления
            $this->setRequestThemeName($params[1]);
        }

        return $this;
    }
}
