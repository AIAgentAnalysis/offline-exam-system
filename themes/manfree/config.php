<?php
// Theme config for Manfree Technologies custom Moodle theme
$THEME = new stdClass();
$THEME->name = 'manfree';
$THEME->parents = ['boost'];
$THEME->sheets = ['custom'];
$THEME->editor_sheets = [];
$THEME->scss = function($theme) {
    return file_get_contents(__DIR__ . '/custom.scss');
};
$THEME->layouts = [
    'base' => array(
        'file' => 'default.php',
        'regions' => array('side-pre'),
        'defaultregion' => 'side-pre',
    ),
    'frontpage' => array(
        'file' => 'frontpage.php',
        'regions' => array('side-pre'),
        'defaultregion' => 'side-pre',
    ),
    'login' => array(
        'file' => 'login.php',
        'regions' => array(),
        'defaultregion' => '',
    ),
];
$THEME->enable_dock = false;
$THEME->rendererfactory = 'theme_overridden_renderer_factory';
$THEME->csspostprocess = 'theme_manfree_csspostprocess';
