#!/bin/sh

if [ "$DATABASE"="postgres" ]
then
    echo "Waiting for postgreSQL..."

    while ! nc -z $SQL_HOST $SQL_PORT; do
        sleep 0.1
    done

    echo "PostgreSQL started"
fi
python manage.py flush --no-input
python manage.py migrate
gunicorn hello_django.wsgi:application --bind 0.0.0.0:8000
exec "$@"