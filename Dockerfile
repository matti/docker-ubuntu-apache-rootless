FROM ubuntu:22.04

RUN apt-get update && apt-get install -y \
  apache2 \
  nano curl wget

RUN useradd app

ENV APACHE_RUN_USER=app
ENV APACHE_RUN_GROUP=app
ENV APACHE_RUN_DIR=/apache/run
ENV APACHE_LOG_DIR=/apache/log
ENV APACHE_PID_FILE=/apache/pid

RUN mkdir -p /apache/run /apache/log
RUN chown -R app:app /apache

# /etc/apache2/envvars hardcodes user to www-data overriding any APACHE_RUN_USER set
RUN mv /etc/apache2/envvars /etc/apache2/envvars.disabled

WORKDIR /app
COPY app .

USER app
ENTRYPOINT [ "/app/entrypoint.sh" ]