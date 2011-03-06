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
}
