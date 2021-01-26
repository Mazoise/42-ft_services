if ! $(su -c 'wp core is-installed --path="/var/www/wordpress"' - www); then
    su -c 'wp core install --path="/var/www/wordpress" --url="172.17.0.2:5050" --title="my wp" --admin_user="mchardin" --admin_password="psw" --admin_email="mchardin@student.42.fr"' - www
    su -c 'wp user create --path="/var/www/wordpress" "roalvare" "roalvare@student.42.fr" --user_pass="roalvare" --role="editor"' - www
    su -c 'wp user create --path="/var/www/wordpress" "cdai" "cdai@student.42.fr" --user_pass="cdai" --role="author"' - www
    su -c 'wp user create --path="/var/www/wordpress" "adda-sil" "adda-sil@student.42.fr" --user_pass="adda-sil" --role="contributor"' - www
fi
