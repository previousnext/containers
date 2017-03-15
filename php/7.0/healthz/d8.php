<?php
/**
 * @file
 * Health check for D8.
 */

// Suspend healthz checks
if (file_exists('/etc/skpr/healthz.skip') == 0) {
  header('HTTP/1.1 200 OK');
  exit();
}

// Build up our list of errors.
$errors = [];

// Register our shutdown function so that no other shutdown functions run before
// this one. This shutdown function calls exit(), immediately short-circuiting
// any other shutdown functions.
register_shutdown_function('status_shutdown');

/**
 * Shutdown function to terminate immediately.
 */
function status_shutdown() {
  exit();
}

use Drupal\Component\Utility\Crypt;
use Drupal\Core\DrupalKernel;
use Drupal\Core\Database\Database;
use Drupal\Core\Site\Settings;
use Symfony\Component\HttpFoundation\Request;

// This is set so realpath() has context.
chdir('/data/app');
$autoloader = require_once '/data/vendor/autoload.php';

$kernel = DrupalKernel::createFromRequest(Request::createFromGlobals(), $autoloader, 'prod');
$kernel->loadLegacyIncludes();
$kernel->boot();

/**
 * Database.
 */

$database = Database::getConnection();
$result = $database->select('users', 'u')
  ->fields('u')
  ->condition('uid', 1)
  ->execute();
$account = $result->fetch();
if ($account->uid != 1) {
  $errors[] = 'Database not responding.';
}

/**
 * Filesystem.
 */

$schemes = [
  'temp' => 'temporary://',
  'public' => 'public://',
];

// We don't always have the private service.
if (Settings::get('file_private_path')) {
  $schemes['private'] = 'private://';
}

/* @var \Drupal\Core\File\FileSystemInterface $file_system */
$file_system = $kernel->getContainer()->get('file_system');
foreach ($schemes as $name => $scheme) {
  $real_dir = $file_system->realpath($scheme);
  // If we don't get a result then the directory doesn't exist.
  // This could mean the the directory has been unmounted.
  if (empty($real_dir)) {
    $errors[] = 'Could not find the directory: ' . $name;
    continue;
  }
  $file = $real_dir . '/healthz_' . Crypt::randomBytesBase64(6) . '.txt';

  // Attempt to write the file to disk.
  $fp = fopen($file, 'w');
  $success = fwrite($fp, 'healthz ' . $name);
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

// Exit immediately, note the shutdown function registered at the top of the
// file.
exit();
