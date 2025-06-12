FROM n8nio/n8n:next

# Instala os pacotes no contexto global e como root
USER root
RUN mkdir -p /data/nodes && \
    cd /data/nodes && \
    npm init -y && \
    npm install n8n-nodes-langchain n8n-nodes-hotmart
    RUN cd /data/nodes && ls node_modules
ENV N8N_CUSTOM_EXTENSIONS=/data/nodes
USER node


# Volta para o usuário padrão do n8n
USER node

ARG PGPASSWORD
ARG PGHOST
ARG PGPORT
ARG PGDATABASE
ARG PGUSER

ENV DB_TYPE=postgresdb
ENV DB_POSTGRESDB_DATABASE=$PGDATABASE
ENV DB_POSTGRESDB_HOST=$PGHOST
ENV DB_POSTGRESDB_PORT=$PGPORT
ENV DB_POSTGRESDB_USER=$PGUSER
ENV DB_POSTGRESDB_PASSWORD=$PGPASSWORD

ARG ENCRYPTION_KEY
ENV N8N_ENCRYPTION_KEY=$ENCRYPTION_KEY

CMD ["n8n", "start"]
