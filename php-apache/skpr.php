<?php
/**
 * Gets skipper config.
 */
function skpr_config($key) {
  static $confs;
  if (empty($confs)) {
    $confs = array();
    // This is a consistent directory set by the Skipper project.
    $dir = '/etc/skpr';
    // Here is an adventure into how PHP caches stat data on the filesystem.
    // Kubernetes ConfigMaps structure mounted configuration as follows:
    //   /etc/skpr/var.foo -> /etc/skpr/..data/var.foo -> /etc/skpr/..4984_21_04_13_51_28.237024315/var.foo
    // The issue is here is when values are updated there is a short TTL of time where PHP will
    // keep looking at a non existant timestamped directory.
    // After looking into opcache and apc it turns out core php has a cache for this as well.
    // These lines ensure that our Skipper configuration is always fresh and readily available for
    // the remaing config lookups by the application.
    foreach (realpath_cache_get() as $path => $cache) {
      if (strpos($path, $dir) === 0) {
        clearstatcache(TRUE, $path);
      }
    }
    foreach (glob($dir . '/*') as $file) {
      $confs[basename($file)] = str_replace("\n", '', file_get_contents(realpath($file)));
    }
    if (empty($confs)) {
      // On environments with no skpr, this will run every time because conf is empty.
      // Flag that we've done this dance once, and don't need to do it again.
      $confs['no_skpr_for_you'] = TRUE;
    }
  }
  return !empty($confs[$key]) ? $confs[$key] : FALSE;
}
