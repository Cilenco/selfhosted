<?php

$CONFIG = [
    "trusted_domains" => [getenv("DOMAIN")],

    "default_language" => "de",
    "default_phone_region" => "DE",
    "default_locale" => "de_DE",

    "default_timezone" => "Europe/Berlin",

    //"skeletondirectory" => "/path/to/nextcloud/core/skeleton",
    //"templatedirectory" => "/path/to/nextcloud/templates",

    "hide_login_form" => false,
    "updatechecker" => false,

    "defaultapp" => "files",

    "files.chunked_upload.max_size" => 4 * 1024 * 1024 * 1024, // 4 GB
];
