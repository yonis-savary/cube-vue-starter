<?php

use Cube\Utils\Path;
use Cube\Web\Helpers\StaticServer;
use Cube\Web\Router\Router;

use function Cube\env;

if (env("ENV", "debug") !== "production") {
    return;
}

$directory = Path::relative("frontend");
$server = new StaticServer($directory);
Router::getInstance()->addService($server);