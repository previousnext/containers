<?php

define('DRUPAL_ROOT', '/data/app');

// We set this for debugging purposes.
// This script is never exposed outside of the deployment.
ini_set('display_errors', 1);

// Suspend healthz checks
if (file_exists('/etc/skpr/healthz.skip')) {
  header('HTTP/1.1 200 OK');
  exit();
}

// This is set so realpath() has context.
chdir('/data/app');

// Build up our list of errors.
$errors = array();

// Register our shutdown function so that no other shutdown functions run before this one.
// This shutdown function calls exit(), immediately short-circuiting any other shutdown functions,
// such as those registered by the devel.module for statistics.
register_shutdown_function('status_shutdown');
function status_shutdown() {
  exit();
}

// Drupal bootstrap.
require_once DRUPAL_ROOT . '/includes/bootstrap.inc';
drupal_bootstrap(DRUPAL_BOOTSTRAP_DATABASE);

/**
 * Database.
 */

$result = db_query('SELECT * FROM {users} WHERE uid = 1');
$account = $result->fetch();
if ($account->uid != 1) {
  $errors[] = 'Database not responding.';
}

/**
 * Filesystem.
 */

$vars = array(
  'temp' => 'file_temporary_path',
  'public' => 'file_public_path',
  'private' => 'file_private_path',
);

foreach ($vars as $type => $var) {
  $dir = variable_get($var, FALSE);
  if (!$dir) {
    continue;
  }

  $real_dir = realpath($dir);

  // If we don't get a result then the directory doesn't exist.
  // This could mean the the directory has been unmounted.
  if (empty($real_dir)) {
    $errors[] = 'Could not find the directory: ' . $dir;
    continue;
  }

  $file = $real_dir . '/healthz_' . drupal_random_key(6) . '.txt';

  // Attempt to write the file to disk.
  $fp = fopen($file, 'w');
  $success = fwrite($fp, 'healthz ' . $type);
  fclose($fp);
  if (!$success) {
    $errors[] = 'Could not write to file: ' . $file;
  }

  // Cleanup the file on disk if present.
  if (!unlink($file)) {
    $errors[] = 'Could not delete file: ' . $name;
  }
}

/**
 * Results.
 */

if ($errors) {
  header('HTTP/1.1 500 Internal Server Error');
  print implode("<br />\n", $errors);
}
else {
  print 'Healthy!';
}

// Exit immediately, note the shutdown function registered at the top of the file.
exit();
