<?php
// Manfree Technologies Frontpage Layout
defined('MOODLE_INTERNAL') || die();

$bodyattributes = $OUTPUT->body_attributes();
$templatecontext = [
    'sitename' => format_string($SITE->shortname, true, ['context' => context_course::instance(SITEID), "escape" => false]),
    'output' => $OUTPUT,
    'bodyattributes' => $bodyattributes
];

echo $OUTPUT->render_from_template('theme_boost/frontpage', $templatecontext);
?>

<!-- Manfree Technologies Custom Frontpage Content -->
<div class="frontpage-hero">
    <div class="container">
        <h1><?php echo get_string('welcome', 'theme_manfree'); ?></h1>
        <p class="tagline"><?php echo get_string('tagline', 'theme_manfree'); ?></p>
        <p><?php echo get_string('aboutus', 'theme_manfree'); ?></p>
        <a href="<?php echo $CFG->wwwroot; ?>/course/" class="btn btn-primary btn-lg">
            Explore Courses
        </a>
    </div>
</div>

<div class="container my-5">
    <h2 class="text-center mb-4">Our Training Programs</h2>
    <div class="category-grid">
        <div class="category-item">
            <div class="category-icon">💻</div>
            <h4><?php echo get_string('programming', 'theme_manfree'); ?></h4>
            <p>Master programming languages like C, C++, Java, Python</p>
        </div>
        <div class="category-item">
            <div class="category-icon">🌐</div>
            <h4><?php echo get_string('webdev', 'theme_manfree'); ?></h4>
            <p>Full-stack web development with modern frameworks</p>
        </div>
        <div class="category-item">
            <div class="category-icon">📱</div>
            <h4><?php echo get_string('mobile', 'theme_manfree'); ?></h4>
            <p>iOS and Android app development</p>
        </div>
        <div class="category-item">
            <div class="category-icon">🗄️</div>
            <h4><?php echo get_string('database', 'theme_manfree'); ?></h4>
            <p>Database design and management systems</p>
        </div>
        <div class="category-item">
            <div class="category-icon">🔒</div>
            <h4><?php echo get_string('networking', 'theme_manfree'); ?></h4>
            <p>Network security and system administration</p>
        </div>
        <div class="category-item">
            <div class="category-icon">☁️</div>
            <h4><?php echo get_string('cloud', 'theme_manfree'); ?></h4>
            <p>AWS, Azure, and cloud computing platforms</p>
        </div>
    </div>
</div>