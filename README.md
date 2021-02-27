# Prime B460i-PLUS hackintosh

OpenCore configuration for running macOS on the ASUS Prime B460i-PLUS motherboard.

## Firmware Settings

ASUS firmware version 1003.

#### Advanced &#8594; System Agent (SA) Configuration

| Field                                             | Value     |
|:--------------------------------------------------|----------:|
| VT-d                                              | Enabled   |
| Graphics Configuration &#8594; DVMT Pre-Allocated | 64M       |
| USB Configuration &#8594; Legacy USB Support      | Disabled  |
| USB Configuration &#8594; XHCI Handoff            | Enabled   |
| Onboard Devices Configuration &#8594; Serial Port | Off       |

###### Advanced &#8594; System Agent (SA) Configuration - using discrete graphics

| Field                                             | Value   |
|:--------------------------------------------------|--------:|
| Graphics Configuration &#8594; Primary Display    | PEG     |
| Graphics Configuration &#8594; IGPU Multi-Monitor | Enabled |

#### Boot

| Field                                               | Value    |
|:----------------------------------------------------|---------:|
| CSM (Compatibility Support Mode) &#8594; Launch CSM | Disabled |
| Secure Boot &#8594; OS Type                         | Other OS |
| Boot Configuration &#8594; Fast Boot                | Disabled |

Source: [https://dortania.github.io/OpenCore-Install-Guide/config.plist/comet-lake.html#intel-bios-settings](https://dortania.github.io/OpenCore-Install-Guide/config.plist/comet-lake.html#intel-bios-settings)
  
## OpenCore Sanity Checker

[https://opencore.slowgeek.com/](https://opencore.slowgeek.com/)

## Graphics

Edit the ```DeviceProperties``` section of your config.plist so that the value for ```AAPL,ig-platform-id``` matches your configuration.

```xml
...
<key>DeviceProperties</key>
<dict>
    <key>Add</key>
    <dict>
        ...
        <key>PciRoot(0x0)/Pci(0x2,0x0)</key>
        <dict>
            <key>AAPL,ig-platform-id</key>
            <data>AwDImw==</data>
        </dict>
        ...
    </dict>
</dict>
...
```

| AAPL,ig-platform-id | Base64   | IGPU Configuration                    |
|:--------------------|:---------|--------------------------------------:|
| 07009B3E *          | BwCbPg== | Attached display                      |
| 0300C89B            | AwDImw== | Headless (discrete GPU)               |

\* use `00009B3E` `AACbPg==` if `07009B3E` fails

Source: [https://dortania.github.io/OpenCore-Install-Guide/config.plist/comet-lake.html#deviceproperties](https://dortania.github.io/OpenCore-Install-Guide/config.plist/comet-lake.html#deviceproperties)

## SMBIOS

Edit the ```PlatformInfo``` section of your config.plist so that the ```MLB```, ```ROM```, ```SystemSerialNumber``` and ```SystemUUID``` values are unique to your machine.

```xml
...
<key>PlatformInfo</key>
<dict>
    ...
    <key>Generic</key>
    <dict>
        ...
        <key>MLB</key>
        <string>M0000000000000001</string>
        ...
        <key>ROM</key>
        <data>ESIzRFVm</data>
        ...
        <key>SystemSerialNumber</key>
        <string>W00000000001</string>
        <key>SystemUUID</key>
        <string>00000000-0000-0000-0000-000000000000</string>
    </dict>
    ...
</dict>
...
````

| PlatformInfo &#8594; Generic | Source                    |
|:-----------------------------|--------------------------:|
| MLB                          | \**Board Serial*          |
| ROM                          | 6 bytes, e.g. MAC address |
| SystemSerialNumber           | \**Serial*                |
| SystemUUID                   | \**SmUUID*                |

\* *GenSMBIOS output, iMac20,1*

Source: [https://dortania.github.io/OpenCore-Install-Guide/config.plist/comet-lake.html#platforminfo](https://dortania.github.io/OpenCore-Install-Guide/config.plist/comet-lake.html#platforminfo)

GenSMBIOS: [https://github.com/corpnewt/GenSMBIOS](https://github.com/corpnewt/GenSMBIOS)

## USB

Edit the USBPortInjector.kext ```Info.plist```. See [README-USBPortInjector.kext.md](https://github.com/vulgo/prime-b460i-plus-hackintosh/blob/main/README-USBPortInjector.kext.md)

## First boot

At the picker, **press space**, choose **Reset NVRAM**.

## Post-Install

[https://dortania.github.io/OpenCore-Post-Install/](https://dortania.github.io/OpenCore-Post-Install/)
