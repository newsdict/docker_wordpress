<?php
/**
 * Front to the WordPress application. This file doesn't do anything, but loads
 * wp-blog-header.php which does and tells WordPress to load the theme.
 *
 * @package WordPress
 */
 
/**
 * require composer
 */
if(file_exists('/usr/local/src/vendor/autoload.php')) {
  require_once '/usr/local/src/vendor/autoload.php';
  $dotenv = Dotenv\Dotenv::createImmutable('/');
  $dotenv->load();
}

/**
 * Tells WordPress to load the WordPress theme and output it.
 *
 * @var bool
 */
define( 'WP_USE_THEMES', true );

/** Loads the WordPress Environment and Template */
require( dirname( __FILE__ ) . '/' . $_ENV['WP_SUFFIX'] . '/wp-blog-header.php' );
