#!/bin/bash

# Navega al directorio de la app (Azure App Service la monta en esta ruta)
cd /home/site/wwwroot

# Instala dependencias de PHP si no existen
if [ ! -d "vendor" ]; then
    composer install --no-dev --optimize-autoloader
fi

# Da permisos adecuados para Laravel
chmod -R 775 storage bootstrap/cache

# Opcional: ejecutar migraciones automáticamente (descomenta si lo necesitas)
# php artisan migrate --force

# Inicia el servidor web desde /public
php -S 0.0.0.0:8080 -t public
