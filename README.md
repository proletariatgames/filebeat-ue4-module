# Unreal Engine 4 Module for Filebeat

## Overview

This project adds Unreal Engine 4 log parsing to [filebeat](https://www.elastic.co/products/beats/filebeat) as a [module](https://www.elastic.co/guide/en/beats/filebeat/current/filebeat-modules-overview.html).

This module attempts to parse the timestamp, frame number, category, and verbosity, and adds them as `@timestamp`, `ue4.frame`, `ue4.category`, and `ue4.level`, repsectively.

In addition, if your log line ends with `!json{...}`, it will attempt to parse the `{...}` as a json object, and inject any fields it encounters into `fields`.

For example:

```text
[2019.02.21-16.43.30:017][ 94]LogFoo: Warning: Have some json!!! !json{"server_id":"eabc123456789","public_ip":"127.0.0.1","port":"7770"}
```

becomes:

```json
{
  "@timestamp" : "2019-02-21T16:43:30.017Z",
  "original_text" : """[2019.02.21-16.43.30:017][ 94]LogFoo: Warning: Have some json!!! !json{\"server_id\":\"eabc123456789\",\"public_ip\":\"127.0.0.1\",\"port\":\"7770\"}""",
  "message" : "Have some json!!!",
  "ue4" : {
    "category" : "LogFoo",
    "level" : "Warning",
    "frame" : 94
  },
  "fields" : {
    "public_ip" : "127.0.0.1",
    "server_id" : "eabc123456789",
    "port" : "7770",
  }
}
```

## Installing

- Grab this repo or one of the versioned [releases](https://github.com/proletariatgames/filebeat-ue4-module/releases).
- Copy the `module/ue4` folder into your `module` directory
  - ie: `cp --recursive module/ue4 /usr/share/filebeat/module/`
- Copy the module descriptor `module.d/ue4.yml.disabled` to your `modules.d` directory
  - ie: `cp modules.d/ue4.yml.disabled /etc/filebeat/modules.d/`
- Edit `module.d/ue4.yml.disabled` to set the appropriate paths
- Enable the module via `filebeat modules enable ue4`
