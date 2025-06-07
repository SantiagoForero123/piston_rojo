#!/bin/bash

echo "Iniciando despliegue Laravel en Azure..."

cd /home/site/wwwroot || exit

echo "Instalando dependencias composer..."
if [ ! -d "vendor" ]; then
    composer install --no-dev --optimize-autoloader
fi

echo "Dando permisos a storage y bootstrap/cache..."
chmod -R 775 storage bootstrap/cache

echo "Generando APP_KEY si no existe..."
php artisan key:generate

echo "Ejecutando migraciones (opcional, comenta si no quieres)..."
# php artisan migrate --force

echo "Iniciando servidor PHP en puerto 8080..."
php -S 0.0.0.0:8080 -t public
