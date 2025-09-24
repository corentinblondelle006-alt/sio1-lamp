<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the website, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );

/** Database username */
define( 'DB_USER', 'wpUser' );

/** Database password */
define( 'DB_PASSWORD', 'Kiwi2027@Rostand' );

/** Database hostname */
define( 'DB_HOST', 'database' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8mb4' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define( 'AUTH_KEY',         'smdKYvxt~1!qz~H@&(g+<q7W*<MTq%-~qL8_mV[&q-IR=aN*F,6eX%~6t#ejQBFU' );
define( 'SECURE_AUTH_KEY',  'a!Pr}w e<JdEY!#~Ska{xpqlzcO&qikOqzY#=.FjXsNY3S4M#:n_j/>@z>6]=Hl%' );
define( 'LOGGED_IN_KEY',    '`dWF<DH!#}DoT3 1Z1ABRBn!wo-*>221JUFl5EiCzuW/~-h8(1G<9=toO~z^UL,P' );
define( 'NONCE_KEY',        '%HZiz]=yl#512{5w)24,4o}-pY}kPEP7d~N6/<2@`._C@*9(ovO@,1l`Tf:^lqs<' );
define( 'AUTH_SALT',        '[vnC.qeuzut;^=f|!U%vRtz!*tLP.}dYgb(*B-/nb(U]x? lEDzg&4m+ZDq@vJiq' );
define( 'SECURE_AUTH_SALT', '/!e7_r&[{med.?TY(J}R?W973 5T)E-p),HY6xJb:Dm]nA 0]9+PzZrVWNIDO9:T' );
define( 'LOGGED_IN_SALT',   '>-f}NcPdb6TGJQYKe!GjFbEg;Z0:nB=6%<herHM_?r.z_!E>HLtQ}Gl>%^|BHBYK' );
define( 'NONCE_SALT',       'F7$vc?BY`9a$cvZ_Nv`[eLqfGf.n_@1$C=qM[ss)D{UMBjrb-x7U[4)sPw_;<LeV' );

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 *
 * At the installation time, database tables are created with the specified prefix.
 * Changing this value after WordPress is installed will make your site think
 * it has not been installed.
 *
 * @link https://developer.wordpress.org/advanced-administration/wordpress/wp-config/#table-prefix
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://developer.wordpress.org/advanced-administration/debug/debug-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */

define('FS_METHOD', 'direct');

/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';
