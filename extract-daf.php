<?php
class DUPX_Bootstrap {
    public static function mkdir($path, $mode = 0777, $recursive = false, $context = null) { return is_dir($path) || mkdir($path, 0777, $recursive); }
    public static function chmod($path, $mode) { return true; }
}
define('DUPXABSPATH', '/var/www/html');
require '/var/www/html/dup-installer/lib/dup_archive/classes/class.duparchive.mini.expander.php';
DupArchiveMiniExpander::init(function($s) { fwrite(STDERR, $s . PHP_EOL); });
DupArchiveMiniExpander::expandDirectory('/var/www/html/20230818_dienmayxanhmauwebdienmay_9123f00451d228c27048_20230818032219_archive.daf', '', '/var/www/html');
