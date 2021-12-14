# Prime B460i-PLUS hackintosh

OpenCore configuration for running macOS 12 on the ASUS Prime B460i-PLUS motherboard.

## Firmware Settings

Use ASUS firmware version 1003 or newer.

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

Source: [dortania.github.io/OpenCore-Install-Guide/config.plist/comet-lake.html#intel-bios-settings](https://dortania.github.io/OpenCore-Install-Guide/config.plist/comet-lake.html#intel-bios-settings)

## Intel Graphics

Edit the ```DeviceProperties``` section of your config.plist according to your configuration.

#### Connectorless (using PCIe AMD GPU)

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

Source: [dortania.github.io/OpenCore-Install-Guide/config.plist/comet-lake.html#deviceproperties](https://dortania.github.io/OpenCore-Install-Guide/config.plist/comet-lake.html#deviceproperties)

#### Attached Display

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
            <data>BwCbPg==</data>
            <key>framebuffer-patch-enable</key>
            <data>AQAAAA==</data>
            <key>framebuffer-pipecount</key>
            <data>AgAAAA==</data>
            <key>framebuffer-portcount</key>
            <data>AgAAAA==</data>
            <key>framebuffer-con1-enable</key>
            <data>AQAAAA==</data>
            <key>framebuffer-con1-type</key>
            <data>AAgAAA==</data>
        </dict>
        ...
    </dict>
</dict>
...
```

Refer to [README-Intel-Graphics.md](/README/README-Intel-Graphics.md)

## SMBIOS

Edit the `PlatformInfo` section of your config.plist so that the `MLB`, `ROM`, `SystemSerialNumber` and `SystemUUID` values are unique to your machine.

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
| ROM                          | \**Apple ROM*             |
| SystemSerialNumber           | \**Serial*                |
| SystemUUID                   | \**SmUUID*                |

\* *GenSMBIOS output, iMac20,1*

Source: [dortania.github.io/OpenCore-Install-Guide/config.plist/comet-lake.html#platforminfo](https://dortania.github.io/OpenCore-Install-Guide/config.plist/comet-lake.html#platforminfo)

GenSMBIOS: [github.com/corpnewt/GenSMBIOS](https://github.com/corpnewt/GenSMBIOS)

## Reset NVRAM

At the picker, **press space**, choose `Reset NVRAM`.

Reset NVRAM at first boot and **whenever the bootloader files have changed**.

## Post-Install

### USB

Generate a valid `USBPorts.kext`.

Refer to [README-usbtool.command.md](/README/README-usbtool.command.md)

### Dortania Post-Install

Refer to [dortania.github.io/OpenCore-Post-Install/](https://dortania.github.io/OpenCore-Post-Install/)

## Credits

- [acidanthera](https://github.com/acidanthera)
- [apple](https://github.com/apple)
- [corpnewt](https://github.com/corpnewt)
- [dortania](https://github.com/dortania)
- [mieze](https://github.com/Mieze)
- [Piker-Alpha](https://github.com/Piker-Alpha)
- [RehabMan](https://github.com/RehabMan)

