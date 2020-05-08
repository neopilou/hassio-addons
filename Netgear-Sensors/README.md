# Hass.io Add-on: Netgear Sensors
Publish txbs and rxbs in Mb/s of Netgear router on MQTT

### About
This add-on allows you to publish txbs and rxbs traffic of you netgear router on MQTT, work with Netgear R7800 (other models are not tested yet)

### Installation
1. Add the add-ons repository to your Hass.io instance: `https://github.com/neopilou/hassio-addons`
2. Install the FTP Sync add-on
3. Configure the add-on 

### Configuration

|Parameter|Required|Description|
|---------|--------|-----------|
|`mqtt_server`|Yes|URL of your MQTT Server.|
|`mqtt_port`|Yes|Port of your MQTT Server|
|`mqtt_username`|Yes|Your MQTT Username|
|`mqtt_password`|Yes|Your MQTT Password|
|`topic`|Yes|Topic on your MQTT server where txbs and rxbs will be published|
|`netgear_url`|Yes|Your Netgear Router URL|
|`netgear_username`|Yes|Your Netgear Router Username|
|`netgear_password`|Yes|Your Netgear Router Password|

Example Configuration:
```json
{
  "mqtt_server": "192.168.0.26",
  "port": "'1883'",
  "mqtt_username": "username",
  "mqtt_password": "password",
  "topic": "sensors/netgear",
  "netgear_url": "192.168.0.1",
  "netgear_username": "username",
  "netgear_password": "password"
}
```
