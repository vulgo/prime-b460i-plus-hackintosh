# Prime B460i-PLUS hackintosh

OpenCore configuration for running macOS 15 on the ASUS Prime B460i-PLUS motherboard. Without obsolete or cosmetic patches, the goal is simply macOS 15 working well on compatible hardware


<details><summary><strong>Notes</strong></summary><br>

- For features listed as `in-scope` that are not working as expected, it may be beneficial for all to open an issue here
- Where something is listed as `out-of-scope` more explicit information will surely be found in various places across the internet, or in the OpenCore documentation
- [TextMate](https://macromates.com/) ([github.com/textmate/textmate](https://github.com/textmate/textmate)) is free software useful for editing `config.plist`
- WiFi and Bluetooth work natively in macOS 14 with m.2 Broadcom BCM94360NG
- VirtualSMC plug-ins for this board have been moved into the `PlugIns` directory of `VirtualSMC.kext` and `config.plist` reflects that choice
- Using more than one display with Intel HD 630 has issues

</details>

<details><summary><strong><code>in-scope</code></strong></summary><br>

- Accelerated graphics on supported Intel and AMD GPUs
- Built-in audio
- Built-in ethernet
- Airport and Bluetooth using a natively supported device
- USB
- CPU power management
- PCIe active-state power management
- System wake, sleep, and shutdown
- macOS installation and updates
- OC\_ATTR\_USE\_VOLUME\_ICON | OC\_ATTR\_USE\_DISK\_LABEL\_FILE | OC\_ATTR\_USE\_POINTER\_CONTROL | OC\_ATTR\_USE\_FLAVOUR\_ICON
- System stability

</details>
    
<details><summary><strong><code>out-of-scope</code></strong></summary><br>

- [Apple ID problems](https://dortania.github.io/OpenCore-Post-Install/universal/iservices.html)
- UEFI Secure Boot
- [OpenCore Security and FileVault](https://dortania.github.io/OpenCore-Post-Install/universal/security.html)
- Airport and Bluetooth using a device that is not natively supported
    - [BrcmPatchRam](https://github.com/acidanthera/BrcmPatchRAM)
    - [AirportBrcmFixup](https://github.com/acidanthera/AirportBrcmFixup)
    - [OpenIntelWireless](https://github.com/OpenIntelWireless)
- [DRM and hardware video decoding or encoding](https://github.com/acidanthera/WhateverGreen/blob/master/Manual/FAQ.Shiki.en.md)
- [NVMe problems](https://github.com/acidanthera/NVMeFix)

</details>

<details><summary><strong>Credits</strong></summary><br>

- [acidanthera](https://github.com/acidanthera)
- [apple](https://github.com/apple)
- [corpnewt](https://github.com/corpnewt)
- [dortania](https://github.com/dortania)
- [mieze](https://github.com/Mieze)
- [Piker-Alpha](https://github.com/Piker-Alpha)
- [RehabMan](https://github.com/RehabMan)

</details>

## Firmware Settings

Use ASUS firmware version 1003 or newer.

#### Advanced &#8594; System Agent (SA) Configuration

| Field                                             | Value     |
|:--------------------------------------------------|----------:|
| VT-d                                              | Enabled   |
| Graphics Configuration &#8594; DVMT Pre-Allocated | *64M\**   |
| USB Configuration &#8594; Legacy USB Support      | Disabled  |
| USB Configuration &#8594; XHCI Handoff            | Enabled   |
| Onboard Devices Configuration &#8594; Serial Port | Off       |

*\* 64M HD 630 Graphics, 32M connectorless*

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

Edit the ```DeviceProperties``` section of your config.plist according to your configuration

<details><summary><strong>Connectorless (using PCIe AMD GPU)</strong></summary><br>

The default `config.plist` in this repo is configured in this way

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
            <data>AwCYPg==</data>
        </dict>
        ...
    </dict>
</dict>
...
```

</details>

<details><summary><strong>Attached Display</strong></summary><br>

Intel graphics should work well with a single display. Prefer DisplayPort instead of HDMI where possible

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

</details>

## SMBIOS

<details><summary><strong>What's this?</strong></summary>

OpenCore will generate a complete [SMBIOS](https://en.wikipedia.org/wiki/System_Management_BIOS) for your system according to information provided in the `PlatformInfo` section of `config.plist` and a dataset derived from Apple firmwares. `GenSMBIOS` is a python script that uses acidanthera's `macserial` to generate required serials and unique identifiers

</details>

Edit the `PlatformInfo` section of your config.plist so that the `MLB`, `ROM`, `SystemSerialNumber` and `SystemUUID` values are unique to your machine

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

GenSMBIOS: [github.com/corpnewt/GenSMBIOS](https://github.com/corpnewt/GenSMBIOS)

## Reset NVRAM

At the picker, **press space**, choose `Reset NVRAM`

Reset NVRAM at first boot and **whenever the bootloader files have changed**

# Post-Install

### System Integrity Protection

The `csrutil` EFI command from `AcidAnthera/OpenCorePkg` is available from the EFI shell. System Integrity Protection can be enabled/disabled with `csrutil toggle` 

### USB

Generate a valid `USBPorts.kext`

Refer to [README-usbtool.command.md](/README/README-usbtool.command.md)

### NVMe

> NVMeFix is a set of patches for the Apple NVMe storage driver, IONVMeFamily. Its goal is to improve compatibility with non-Apple SSDs

Refer to [github.com/acidanthera/NVMeFix](https://github.com/acidanthera/NVMeFix)

### Dortania Post-Install

Refer to [dortania.github.io/OpenCore-Post-Install/](https://dortania.github.io/OpenCore-Post-Install/)
