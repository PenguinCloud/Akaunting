FROM code-dal1.penguintech.group:5050/ptg/standards/docker-ansible-image:stable
LABEL company="Penguin Tech Group LLC"
LABEL org.opencontainers.image.authors="info@penguintech.group"
LABEL license="GNU AGPL3"

# GET THE FILES WHERE WE NEED THEM!
COPY . /opt/manager/
WORKDIR /opt/manager

# UPDATE as needed
RUN apt update && apt dist-upgrade -y && apt auto-remove -y && apt clean -y

# PUT YER ARGS in here
ARG APP_TITLE="Akaunting"
ARG APP_LINK="https://akaunting.com/download.php?version=latest"
ARG APP_VERSION="Akaunting_3.0.6-Stable.zip"

# BUILD IT!
RUN ansible-playbook build.yml -c local

# PUT YER ENVS in here
ENV DATABASE_TYPE="mariadb"
ENV DATABASE_NAME="akaunting"
ENV DATABASE_USER="akaunting"
ENV DATABASE_PASSWORD="p@ssword"
ENV DATABASE_HOST="mariadb"
ENV DATABASE_PORT="3306"
ENV URL="example.penguintech.group"

# Switch to non-root user
USER www-data

EXPOSE 8080

# Entrypoint time (aka runtime)
ENTRYPOINT ["/bin/bash","/opt/manager/entrypoint.sh"]