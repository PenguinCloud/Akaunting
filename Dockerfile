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
ARG APP_LINK=""https://github.com/akaunting/akaunting/releases/download/3.0.4/Akaunting_3.0.4-Stable.zip

# BUILD IT!
RUN ansible-playbook build.yml -c local

# PUT YER ENVS in here
ENV DATABASE_NAME="akaunting"
ENV DATABASE_USER="akaunting"
ENV DATABASE_PASSWORD="p@ssword"
ENV DATABASE_HOST="mariadb"
ENV DATABASE_PORT="3306"
ENV ORGANIZATION_NAME="name"
ENV ORGANIZATION_COUNTRY="US"
ENV ORGANIZATION_EMAIL="admin@localhost"
ENV ORGANISATION_HOSTNAME="ptg.org"
ENV SSL_KEY="nokey"
ENV SSL_CERT="nocert"
ENV URL="https://102.65.85.37"

# Switch to non-root user
# USER ptg-user

# Entrypoint time (aka runtime)
ENTRYPOINT ["/bin/bash","/opt/manager/entrypoint.sh"]