# tangomct

Plugin for OpenMCT to monitor a Tango Controls system

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

- [Development](#development)
  - [Start a tango controls test environment](#start-a-tango-controls-test-environment)
  - [GraphiQL](#graphiql)
  - [Subscribe to a Tango attribute](#subscribe-to-a-tango-attribute)
- [Open MCT (TODO)](#open-mct-todo)
  - [Install the plugins](#install-the-plugins)
    - [Update index.html](#update-indexhtml)
    - [Update src/plugins/plugins.js](#update-srcpluginspluginsjs)
  - [Run the server](#run-the-server)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

# Development

## Start a tango controls test environment

```sh
cd docker-compose
docker network create tango
docker compose -f tango-db.yml  -f  tango-test.yml -f tangogql.yml  up
```

## GraphiQL

The Graphql endpoint should be available at:
_[http://localhost:5004/graphiql/](http://localhost:5004/graphiql/)_.

```gql
# Query a device
query {
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

# .. Or explore the schema and types
query {
  schema: __schema {
    types {
      name
    }
  }

  subscriptionFields: __type(name: "Subscription") {
    fields {
      name
    }
  }

  queryFields: __type(name: "Query") {
    fields {
      name
    }
  }
}
```

## Subscribe to a Tango attribute
For example, to consume the GraphQL API open a website and in the console:

```js
const socket = new WebSocket('ws://127.0.0.1:5004/socket')

socket.onmessage = function (event) {
  const parsed_data = JSON.parse(event.data)
  const point = {
    value: parsed_data.payload.data.attributes.value,
    timestamp: parsed_data.payload.data.attributes.timestamp * 1000,
    id: 'sys.tg_test.1.double_scalar',
  }
  console.log(point)
}

const gqlSubscriptionQuery =
  '{ "type": "start", "payload": { "query": "subscription Attributes($fullNames: [String]!) {  attributes(fullNames: $fullNames) {    device    attribute    value    writeValue    timestamp  }}", "variables": { "fullNames": ["sys/tg_test/1/double_scalar"] } } }'

socket.onopen = () => socket.send(gqlSubscriptionQuery)

// You should see logs something like
{ "value": 232.01497690132726, "timestamp": 1715785846038.907, "id": "sys.tg_test.1.double_scalar" }
```

# Open MCT (TODO)

Follow the instructions from _[https://github.com/nasa/openmct](https://github.com/nasa/openmct)_.

## Install the plugins

### Update index.html

Add the following lines

```diff
...
+openmct.install(openmct.plugins.TangoTree());
+openmct.install(openmct.plugins.TangoData());
document.addEventListener('DOMContentLoaded', function () {
  openmct.start();
});
...
```

### Update src/plugins/plugins.js

```diff
...
import WebPagePlugin from './webPage/plugin.js';
+import TangoTreePlugin from '../../../tango_plugin/TangoTreePlugin.js';
+import TangoDataPlugin from '../../../tango_plugin/TangoDataPlugin.js';

const plugins = {};
...
+plugins.TangoTree = TangoTreePlugin;
+plugins.TangoData = TangoDataPlugin

export default plugins;
```

## Run the server

```console
npm start
```

Browse to _[http://localhost:8080/](http://localhost:8080/)_
