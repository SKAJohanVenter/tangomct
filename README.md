# tangomct
Plugin for OpenMCT to  monitor a Tango Controls system

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
**Contents**  *generated with [DocToc](https://github.com/thlorenz/doctoc)*

- [Development](#development)
  - [Start a tango controls test environment](#start-a-tango-controls-test-environment)
    - [Requirements](#requirements)
    - [Add a docker network if required](#add-a-docker-network-if-required)
    - [Bring up the environment](#bring-up-the-environment)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

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
*[http://localhost:5004/graphiql/](http://localhost:5004/graphiql/)*.

Query example

```console
query{
    devices(pattern: "sys/tg_test/1") {
      attributes(pattern: "*") {
        name
      }
      name
      state
      connected
      alias
      deviceClass
      pid
      startedDate
      stoppedDate
      exported
    }
}
```



