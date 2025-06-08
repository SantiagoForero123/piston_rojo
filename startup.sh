#!/bin/bash
echo "Iniciando despliegue Laravel en Azure..."

cd /home/site/wwwroot || exit

echo "Dando permisos a storage y bootstrap/cache..."
chmod -R 775 storage bootstrap/cache

echo "Ejecutando optimize y cache config..."
php artisan optimize

echo "Despliegue listo."
