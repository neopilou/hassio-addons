# Hass.io Add-on: Netgear Sensors
Publish txbs and rxbs of Netgear router on Mosquitto

### About
This add-on allows you to publish txbs and rxbs traffic of you netgear router on Mosquitto

### Installation
1. Add the add-ons repository to your Hass.io instance: `https://github.com/neopilou/hassio-addons`
2. Install the FTP Sync add-on
3. Configure the add-on 

### Configuration

|Parameter|Required|Description|
|---------|--------|-----------|
|`mosquitto_server`|Yes|URL of your Mosquitto Server.|
|`mosquitto_port`|Yes|Port of your Mosquitto Server|
|`mosquitto_username`|Yes|Your Mosquitto Username|
|`mosquitto_password`|Yes|Your Mosquitto Password|
|`topic`|Yes|Topic on your Mosquitto server where txbs and rxbs will be published|
|`netgear_url`|Yes|Your Netgear Router URL|
|`netgear_username`|Yes|Your Netgear Router Username|
|`netgear_password`|Yes|Your Netgear Router Password|

Example Configuration:
```json
{
  "mosquitto_server": "localhost",
  "port": "'1883'",
  "mosquitto_username": "username",
  "mosquitto_password": "password",
  "topic": "sensors/netgear",
  "netgear_url": "192.168.0.1",
  "netgear_username": "username",
  "netgear_password": "password"
}
```
