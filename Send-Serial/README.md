# Hass.io Add-on: Send Serial
Send text over Serial port

### About
This add-on allows you to send text over Serial port

### Installation
1. Add the add-ons repository to your Hass.io instance: `https://github.com/neopilou/hassio-addons`
2. Install the Send Serial add-on
3. Configure the add-on with serial port

### Usage

After the add-on is configured and started, trigger an upload by calling the `hassio.addon_stdin` service with the following service data:

```json
{"addon":"f32ef7e5_send_serial","input":{"command":"text_to_send"}}
```

You can use Home Assistant automations or scripts to run uploads at certain time intervals, under certain conditions, etc.

### Configuration

|Parameter|Required|Description|
|---------|--------|-----------|
|`port`|Yes|Serial Port|

Example Configuration:
```json
{
  "port": "/dev/ttyUSB0"
}
```
