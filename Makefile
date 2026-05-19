.PHONY: help up start setup down stop restart logs ps shell db-shell clean

COMPOSE ?= docker compose
WORDPRESS_SERVICE ?= wordpress
DB_SERVICE ?= db
ARCHIVE ?= /var/www/html/20230818_dienmayxanhmauwebdienmay_9123f00451d228c27048_20230818032219_archive.daf
SQL_BACKUP ?= src/nongsanviet/dup-installer/dup-database__9123f00-18032219.sql
OLD_URL ?= http://dienmayxanh.giaodienwebmau.com
SITE_URL ?= http://localhost:8080

help:
	@printf "Available commands:\n"
	@printf "  make up        Start the project in the background\n"
	@printf "  make setup     Start and restore the demo website\n"
	@printf "  make start     Alias for make up\n"
	@printf "  make down      Stop and remove containers\n"
	@printf "  make stop      Stop containers without removing them\n"
	@printf "  make restart   Restart all services\n"
	@printf "  make logs      Follow container logs\n"
	@printf "  make ps        Show service status\n"
	@printf "  make shell     Open a shell in the WordPress container\n"
	@printf "  make db-shell  Open a MySQL shell\n"
	@printf "  make clean     Stop containers and remove volumes\n"

up:
	$(COMPOSE) up -d

setup: up
	$(COMPOSE) exec $(WORDPRESS_SERVICE) php -r "class DUPX_Bootstrap { public static function mkdir(\$$path, \$$mode = 0777, \$$recursive = false, \$$context = null) { return is_dir(\$$path) || mkdir(\$$path, 0777, \$$recursive); } public static function chmod(\$$path, \$$mode) { return true; } } define('DUPXABSPATH', '/var/www/html'); require '/var/www/html/dup-installer/lib/dup_archive/classes/class.duparchive.mini.expander.php'; DupArchiveMiniExpander::init(function(\$$s) { fwrite(STDERR, \$$s . PHP_EOL); }); DupArchiveMiniExpander::expandDirectory('$(ARCHIVE)', '', '/var/www/html');"
	$(COMPOSE) exec $(WORDPRESS_SERVICE) php -r "\$$file = '/var/www/html/wp-content/themes/web-khoi-nghiep/functions.php'; \$$code = file_get_contents(\$$file); \$$code = str_replace('create_function( \'\$$a\', \"remove_action( \'init\', \'wp_version_check\' );\" )', 'function() { remove_action( \'init\', \'wp_version_check\' ); }', \$$code); \$$code = str_replace('create_function( \'\$$a\', \"return null;\" )', 'function() { return null; }', \$$code); file_put_contents(\$$file, \$$code);"
	$(COMPOSE) exec -T $(DB_SERVICE) mysql --default-character-set=utf8mb4 -u root -prootpassword -e "DROP DATABASE IF EXISTS wordpress; CREATE DATABASE wordpress CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci; GRANT ALL PRIVILEGES ON wordpress.* TO 'wordpress'@'%'; FLUSH PRIVILEGES;"
	$(COMPOSE) exec -T $(DB_SERVICE) mysql --default-character-set=utf8mb4 -u wordpress -pwordpress wordpress < $(SQL_BACKUP)
	$(COMPOSE) exec $(WORDPRESS_SERVICE) bash -lc "command -v wp >/dev/null || { curl -fsSL -o /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && chmod +x /usr/local/bin/wp; }"
	$(COMPOSE) exec $(WORDPRESS_SERVICE) wp search-replace '$(OLD_URL)' '$(SITE_URL)' --allow-root --skip-columns=guid --precise

start: up

down:
	$(COMPOSE) down

stop:
	$(COMPOSE) stop

restart:
	$(COMPOSE) restart

logs:
	$(COMPOSE) logs -f

ps:
	$(COMPOSE) ps

shell:
	$(COMPOSE) exec $(WORDPRESS_SERVICE) bash

db-shell:
	$(COMPOSE) exec $(DB_SERVICE) mysql -u wordpress -pwordpress wordpress

clean:
	$(COMPOSE) down -v
