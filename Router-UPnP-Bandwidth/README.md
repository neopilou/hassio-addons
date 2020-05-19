# Hass.io Add-on: Router UPnP Bandwidth
Publish bandwidth txbs and rxbs in Mb/s of your UPnP router on MQTT

### About
This add-on allows you to publish bandwidth txbs and rxbs traffic in Mb/s of your UPnP router on MQTT, work with Netgear R7800 and FritzBox (other models are not tested yet)

### Installation
1. Add the add-ons repository to your Hass.io instance: `https://github.com/neopilou/hassio-addons`
2. Install the Router UPnP Bandwidth add-on
3. Configure the add-on 

### Router UPnP XML URL

#### URL known to the following routers:
- Netgear R7800 : http://192.168.0.1:5555/rootDesc.xml
- FritzBox : http://fritz.box:49000/igddesc.xml

#### How to get UPnP XML URL
You can use "upnp_info.py" in this repository

### Does not work with these routers:
- Freebox V6 (Revolution)

### Configuration

|Parameter|Required|Description|
|---------|--------|-----------|
|`mqtt_protocol`|Yes|Protocol of your MQTT Server.|
|`mqtt_server`|Yes|URL of your MQTT Server.|
|`mqtt_port`|Yes|Port of your MQTT Server|
|`mqtt_username`|Yes|Your MQTT Username|
|`mqtt_password`|Yes|Your MQTT Password|
|`topic`|Yes|Topic on your MQTT server where txbs and rxbs will be published|
|`router_url`|Yes|Your Router UPnP XML URL|

Example Configuration:
```json
{
  "mqtt_protocol": "tcp",
  "mqtt_server": "192.168.0.2",
  "mqtt_port": "'1883'",
  "mqtt_username": "username",
  "mqtt_password": "password",
  "topic": "sensors/netgear",
  "router_url": "http://192.168.0.1:5555/rootDesc.xml"
}
```
