#!/bin/bash
echo "Iniciando despliegue Laravel en Azure..."

cd /home/site/wwwroot || exit

echo "Instalando dependencias composer..."
composer install --no-dev --optimize-autoloader

echo "Dando permisos a storage y bootstrap/cache..."
chmod -R 775 storage bootstrap/cache

# Elimina esta sección porque Azure ya usa APP_KEY desde las variables
# echo "Generando APP_KEY si no existe..."
# php artisan key:generate

echo "Ejecutando optimize y cache config..."
php artisan optimize

# No iniciar servidor manualmente, Azure ya lo hace
# php -S 0.0.0.0:8080 -t public

echo "Despliegue listo."
