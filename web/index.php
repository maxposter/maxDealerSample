<?php
    $projectDir = dirname(dirname(__FILE__));
    require_once($projectDir . '/lib/maxAPI/autoload.php');

    $client = new demoClient(array(
        // Код автосалона
        'dealer_id' => 5,

        // Пароль для доступа к данным
        'password' => 555,

        // Номер используемой версии API
        'api_version' => 1,

        // Путь к каталогу, содержащему XSLT. Путь должен заканчиваться слэшем.
        'xslt_dir' => $projectDir.'/lib/xslt/',

        /* Путь к каталогу для кэширования. У процесса, выполняющего
        скрипт должны быть права rwx на каталог и его файлы.
        Путь должен заканчиваться слэшем */
        'cache_dir' => $projectDir.'/cache/',

        // Удалим кэширование данных в формате HTML на период отладки
        'cached_html_themes' => array(),
    ));

    $client->setRequest();
?>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html lang="ru">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
        <!-- Framework CSS -->
        <link rel="stylesheet" href="/css/blueprint/screen.css" type="text/css" media="screen,projection" />
        <link rel="stylesheet" href="/css/blueprint/print.css" type="text/css" media="print" />
        <!--[if IE]><link rel="stylesheet" href="/css/blueprint/ie.css" type="text/css" media="screen, projection" /><![endif]-->
        <link rel="stylesheet" href="/css/usedcars.css" type="text/css" media="screen, projection" />
        <?php echo $client->getJS(); ?>
    </head>
    <body>
        <div class="container">
            <div class="span-16">
                <?php echo $client->getHtml(); ?>
            </div>
        </div>
    </body>
</html>
