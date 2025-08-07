<?php
// Minimal settings file for Manfree theme
defined('MOODLE_INTERNAL') || die();

if ($ADMIN->fulltree) {
    // Example setting: custom logo
    $name = 'theme_manfree/logo';
    $title = get_string('logo','theme_manfree');
    $description = get_string('logodesc', 'theme_manfree');
    $setting = new admin_setting_configstoredfile($name, $title, $description, 'logo');
    $settings->add($setting);
}
