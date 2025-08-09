<?php
// Moodle 4 compliant theme settings
defined('MOODLE_INTERNAL') || die();

if ($ADMIN->fulltree) {
    // General settings heading
    $name = 'theme_manfree/generalsettings';
    $title = get_string('generalsettings', 'theme_manfree');
    $description = get_string('generalsettings', 'theme_manfree');
    $setting = new admin_setting_heading($name, $title, $description);
    $settings->add($setting);

    // Raw SCSS setting
    $name = 'theme_manfree/scss';
    $title = get_string('rawscss', 'theme_manfree');
    $description = get_string('rawscss_desc', 'theme_manfree');
    $setting = new admin_setting_configtextarea($name, $title, $description, '', PARAM_RAW);
    $setting->set_updatedcallback('theme_reset_all_caches');
    $settings->add($setting);
}