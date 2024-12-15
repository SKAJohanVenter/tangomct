# Expose a REST interface to the Tango Archiver HDBPP-TIMESCALE

## Deployment

### Archiver

#### Build the archiver docker image

- Build the docker image as instructed [here](https://gitlab.com/tango-controls/hdbpp/hdbpp-timescale-project)
- This should create a image named `hdbpp-timescale-full`

### Postgrest

Use [Postgrest](https://docs.postgrest.org/en/v12/) to expose a REST interface to the tables

- ```docker run --rm --net=host \
  -e PGRST_DB_URI="postgres://<username:password>@localhost/hdb" \
  postgrest/postgrest```

## Docker Compose

You can deploy HDBPP, Postgrest Swagger from docker compose

- `cd docker-compose`
- `docker compose -f hdbpp.yml -f postgrest.yml -f swagger.yml`

Swagger interface available at: http://localhost:8080/
