<?php
/**
 * Autoloading of maxAPI classes
 */

function maxAPIAutoload($className)
{
    if (class_exists($className, false) || interface_exists($className, false)) {
        return;
    }

    include_once($className . '.php');
}

set_include_path(
    get_include_path()
    . PATH_SEPARATOR
    . dirname(__FILE__)
    . PATH_SEPARATOR
    . dirname(dirname(__FILE__)) . '/php'
);

spl_autoload_register('maxAPIAutoload');
