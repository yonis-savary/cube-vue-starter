<?php

use Cube\Console\Args;
use Cube\Console\Command;
use Cube\Console\Commands\Help;
use Cube\Core\Autoloader;
use Cube\Data\Bunch;
use Cube\Utils\Console;
use Cube\Utils\Shell;

set_time_limit(0);

include_once "./vendor/autoload.php";

Autoloader::initialize();

$identifier = $argv[1] ?? "";
$commands = Shell::findCommand($identifier);

if (!count($commands))
{
    Console::print(Console::withYellowColor("No command found with identifier [$identifier]"));
    Help::call();
    exit(1);
}
else if (count($commands) > 1)
{
    Console::print(
        "Multiple commands found with identifier [$identifier]",
        "please call the desired command with its full identifier",
        ""
    );
    Console::table(
        Bunch::of($commands)
        ->map(fn($class) => new $class)
        ->map(fn(Command $command) => [$command->getFullIdentifier(), $command->getHelp()])
        ->get(),
        ["Full Identifier", "Description"],
        false
    );

    exit(1);
}

/** @var Command $command */
$command = $commands[0];

// Remove 'php do'
array_shift($argv);
array_shift($argv);

$args = Args::fromArgv($argv);
$status = $command->execute($args);

exit($status);