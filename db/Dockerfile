FROM postgres
ENV POSTGRES_PASSWORD postgres
ENV POSTGRES_DB pregnapp
COPY 00_create.sql /docker-entrypoint-initdb.d/
COPY 01_users.sql /docker-entrypoint-initdb.d/
COPY 02_calendar.sql /docker-entrypoint-initdb.d/
COPY 03_navigation.sql /docker-entrypoint-initdb.d/
COPY 04_pregnancy_stages.sql /docker-entrypoint-initdb.d/
COPY 05_article.sql /docker-entrypoint-initdb.d/
COPY 06_user_images.sql /docker-entrypoint-initdb.d/
COPY 07_pages.sql /docker-entrypoint-initdb.d/
