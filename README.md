# tangomct
Plugin for OpenMCT to  monitor a Tango Controls system

# Development

## Start a tango controls test environment

### Requirements

- docker-compose

### Add a docker network if required

> **_NOTE:_**
 You can chage the `.env` setting for network mode if you want to use something else

```console
docker network create tango
```

### Bring up the environment

```console
cd docker-compose
docker compose -f tango-db.yml  -f  tango-test.yml -f tangogql.yml  up
```

The Graphql endpoint should be available at:
*[http://0.0.0.0:5004/graphiql/](http://0.0.0.0:5004/graphiql/)*.



