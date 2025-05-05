ARG POSTGRES_MAJOR_VERSION=17
ARG POSTGIS_VERSION=3.5
ARG FROM_TAG=${POSTGRES_MAJOR_VERSION}-${POSTGIS_VERSION}

FROM postgis/postgis:${FROM_TAG}
ARG POSTGRES_MAJOR_VERSION

# install pg_cron
RUN echo | sh /usr/share/postgresql-common/pgdg/apt.postgresql.org.sh && \
    apt-get -y install postgresql-${POSTGRES_MAJOR_VERSION}-cron && \
    echo "\nshared_preload_libraries='pg_cron,pg_stat_statements'\n" >> /usr/share/postgresql/postgresql.conf.sample

# configure pg_cron
COPY initdb.sh /docker-entrypoint-initdb.d/initdb.sh
