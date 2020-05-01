# Hass.io Add-on: FTP Sync
Back up your Hass.io snapshots to FTP Server.

### About
This add-on allows you to upload your Hass.io snapshots to your FTP Server, keeping your snapshots safe and available in case of hardware failure. Uploads are triggered via a service call, making it easy to automate periodic backups or trigger uploads to FTP Server via script as you would with any other Home Assistant service.

### Installation
1. Add the add-ons repository to your Hass.io instance: `https://github.com/neopilou/hassio-addons`
2. Install the FTP Sync add-on
3. Configure the add-on with your FTP Server URL, Path, Login, Password

### Usage

FTP Sync uploads all snapshot files (specifically, all `.tar` files) in the Hass.io `/backup` directory to a specified path in your FTP Server. This target path is specified via the `ftpbackupfolder` option. Once the add-on is started, it is listening for service calls.

After the add-on is configured and started, trigger an upload by calling the `hassio.addon_stdin` service with the following service data:

```json
{"addon":"f32ef7e5_ftp_sync","input":{"command":"upload"}}
```

You can use Home Assistant automations or scripts to run uploads at certain time intervals, under certain conditions, etc.

The `keep last` option allows the add-on to clean up the local backup directory, deleting the local copies of the snapshots after they have been uploaded to your FTP Server. If `keep_last` is set to some integer `x`, only the latest `x` snapshots will be stored locally; all other (older) snapshots will be deleted from local storage. All snapshots are always uploaded to your FTP Server, regardless of this option.

### Configuration

|Parameter|Required|Description|
|---------|--------|-----------|
|`ftpprotocol`|Yes|FTP protocol to use|
|`ftpserver`|Yes|URL of your FTP Server.|
|`ftpport`|Yes|Port of your FTP Server|
|`ftpbackupfolder`|Yes|Path on your FTP server where backups will be synchronized|
|`ftpusername`|Yes|Your FTP Username|
|`ftppassword`|Yes|Your FTP Password|
|`addftpflags`|No|Add flags|
|`keep_last`|No|If set, the number of snapshots to keep locally. If there are more than this number of snapshots stored locally, the older snapshots will be deleted from local storage after being uploaded to your FTP Server. If not set, no snapshots are deleted from local storage|

Example Configuration:
```json
{
  "ftpprotocol": "ftp",
  "ftpserver": "192.168.0.1",
  "ftpport": "'21'",
  "ftpbackupfolder": "HomeAssistant_Backups",
  "ftpusername": "username",
  "ftppassword": "password",
  "addftpflags": "'flags'",
  "keep_last":"1"
}
```
