<?php
/**
 * La configuration de base de votre installation WordPress.
 *
 * Ce fichier contient les réglages de configuration suivants : réglages MySQL,
 * préfixe de table, clés secrètes, langue utilisée, et ABSPATH.
 * Vous pouvez en savoir plus à leur sujet en allant sur
 * {@link http://codex.wordpress.org/fr:Modifier_wp-config.php Modifier
 * wp-config.php}. C’est votre hébergeur qui doit vous donner vos
 * codes MySQL.
 *
 * Ce fichier est utilisé par le script de création de wp-config.php pendant
 * le processus d’installation. Vous n’avez pas à utiliser le site web, vous
 * pouvez simplement renommer ce fichier en "wp-config.php" et remplir les
 * valeurs.
 *
 * @package WordPress
 */

// ** Réglages MySQL - Votre hébergeur doit vous fournir ces informations. ** //
/** Nom de la base de données de WordPress. */
define('DB_NAME', 'wordpress');

/** Utilisateur de la base de données MySQL. */
define('DB_USER', 'mchardin');

/** Mot de passe de la base de données MySQL. */
define('DB_PASSWORD', 'psw');

/** Adresse de l’hébergement MySQL. */
define('DB_HOST', 'mysql');

/** Jeu de caractères à utiliser par la base de données lors de la création des tables. */
define('DB_CHARSET', 'utf8');

/** Type de collation de la base de données.
  * N’y touchez que si vous savez ce que vous faites.
  */
define('DB_COLLATE', '');

/**#@+
 * Clés uniques d’authentification et salage.
 *
 * Remplacez les valeurs par défaut par des phrases uniques !
 * Vous pouvez générer des phrases aléatoires en utilisant
 * {@link https://api.wordpress.org/secret-key/1.1/salt/ le service de clefs secrètes de WordPress.org}.
 * Vous pouvez modifier ces phrases à n’importe quel moment, afin d’invalider tous les cookies existants.
 * Cela forcera également tous les utilisateurs à se reconnecter.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '}6!Ky739,-~|F_C?&0bV!-_& vA*.2>B$&0sB.n(A7.R4mrSzVkY>Xf059o|iiI+');
define('SECURE_AUTH_KEY',  ' 2E@xw+7DtT2^ln=3q=1OvI?UH#ddvaI~+R^-s#~^BRPc_+J>&<&TxM=]{d#iqN;');
define('LOGGED_IN_KEY',    'Ed+W*+(0Su+Z& 7>T&ByrQkK](-{52cv22sFMd-de%A_BOMiZmE)`U[&vw3|>Zz{');
define('NONCE_KEY',        'w$O>D$H4L&ac|9|Qi<A0ZRP+4Ov&5cjFp~:x$]D$g>6ot;=S@)*JXKb>l,41W)qU');
define('AUTH_SALT',        'CW^w/)jH+`X?[Vu2&5t!sf!sNt-DCZG80R4;9~^O:f`Xu!OwjT gh$Y`5.NyJZ%e');
define('SECURE_AUTH_SALT', '-`ntueBP70#Uk$ZX19a|zOYZtQ3XaT)%cpUyc!o `%yVrj{@ek)sNfD;ko|OR+1%');
define('LOGGED_IN_SALT',   '+tFN|J>o=/E-.Zc|>_pF#w},Ks+|KF[qbt_@[z?D$L9Y*!}m>7TAu}n:#b&l>]- ');
define('NONCE_SALT',       '6Vmel~0ohbh/GKCA/>*Z[K*9 ,y-5}|;5/VV{Ov2nf}|]q/!qYsB@Is=x}|$5{+[');
/**#@-*/

/**
 * Préfixe de base de données pour les tables de WordPress.
 *
 * Vous pouvez installer plusieurs WordPress sur une seule base de données
 * si vous leur donnez chacune un préfixe unique.
 * N’utilisez que des chiffres, des lettres non-accentuées, et des caractères soulignés !
 */
$table_prefix = 'wp_';

/**
 * Pour les développeurs : le mode déboguage de WordPress.
 *
 * En passant la valeur suivante à "true", vous activez l’affichage des
 * notifications d’erreurs pendant vos essais.
 * Il est fortemment recommandé que les développeurs d’extensions et
 * de thèmes se servent de WP_DEBUG dans leur environnement de
 * développement.
 *
 * Pour plus d’information sur les autres constantes qui peuvent être utilisées
 * pour le déboguage, rendez-vous sur le Codex.
 *
 * @link https://codex.wordpress.org/Debugging_in_WordPress
 */
define('WP_DEBUG', false);

/* C’est tout, ne touchez pas à ce qui suit ! Bonne publication. */

/** Chemin absolu vers le dossier de WordPress. */
if ( !defined('ABSPATH') )
        define('ABSPATH', dirname(__FILE__) . '/');

/** Réglage des variables de WordPress et de ses fichiers inclus. */
require_once(ABSPATH . 'wp-settings.php');

define('WP_HOME', '172.0.17.2');
define('WP_SITEURL', '172.0.17.2');