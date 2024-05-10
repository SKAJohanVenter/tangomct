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
### Subscribe to a Tango attribute

Make use of a websocket client.

Server location:

```console
ws://127.0.0.1:5004/socket
```

Request:

```console
{"type":"start","payload":{"query":"\nsubscription Attributes($fullNames: [String]!) {\n  attributes(fullNames: $fullNames) {\n    device\n    attribute\n    value\n    writeValue\n    timestamp\n  }\n}","variables":{"fullNames":["sys/tg_test/1/double_scalar"]}}}
```
Sample responses:

```console
{"type": "data", "payload": {"data": {"attributes": {"device": "sys/tg_test/1", "attribute": "double_scalar", "value": -53.224684076613265, "writeValue": 0.0, "timestamp": 1715268758.152865}}}}
{"type": "data", "payload": {"data": {"attributes": {"device": "sys/tg_test/1", "attribute": "double_scalar", "value": -61.93129486648311, "writeValue": 0.0, "timestamp": 1715268761.160854}}}}
{"type": "data", "payload": {"data": {"attributes": {"device": "sys/tg_test/1", "attribute": "double_scalar", "value": -66.2569646932381, "writeValue": 0.0, "timestamp": 1715268764.170845}}}}
{"type": "data", "payload": {"data": {"attributes": {"device": "sys/tg_test/1", "attribute": "double_scalar", "value": -70.5624520407959, "writeValue": 0.0, "timestamp": 1715268767.184561}}}}
```

## Install and run openMCT

Follow the instructions from *[https://github.com/nasa/openmct](https://github.com/nasa/openmct)*.

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

Browse to *[http://localhost:8080/](http://localhost:8080/)*
