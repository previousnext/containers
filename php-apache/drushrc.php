<?php

/**
 * @file
 * Allows for system wide access to the drupal site.
 */

if (file_exists('/data/app')) {
  $options['r'] = '/data/app';
}
