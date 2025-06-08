#!/bin/bash
echo "Iniciando despliegue Laravel en Azure..."

cd /home/site/wwwroot || exit

# Permisos necesarios para Laravel
echo "Dando permisos a storage y bootstrap/cache..."
chmod -R 775 storage bootstrap/cache

# Cachear configuración y rutas
echo "Ejecutando optimize y cache config..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

# Ejecutar migraciones forzadas
echo "Ejecutando migraciones..."
php artisan migrate --force

# Eliminar la página predeterminada de Azure para que Laravel se muestre
echo "Eliminando hostingstart.html..."
rm -f /home/site/wwwroot/hostingstart.html

# Iniciar servidor web en public/
echo "Iniciando servidor PHP..."
php -S 0.0.0.0:80 -t public
