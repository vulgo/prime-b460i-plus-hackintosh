## USBPortInjector.kext

This codeless kext injects a port map for the XHC on our B460i-PLUS.

```Info.plist``` will require edits and should have:
* no more than **15** ports in the ```ports``` dictionary
* a ```model``` that matches ```PlatformInfo```&#8594;```SystemProductName```  in the OC config.plist e.g. ```iMac20,1```
* a ```port-count``` that corresponds not to the total number of ports, but to the highest ```port``` address value present in in the ```ports``` dictionary e.g. ```0x16000000``` or ```FgAAAA==```

### Port Physical Locations

#### USB 2

| Port | Location                   |
|:-----|:---------------------------|
| HS01 | USB 3 Header               |
| HS02 | USB 3 Header               |
| HS03 | Rear Panel USB 3 Connector |
| HS04 | Rear Panel USB 3 Connector |
| HS05 | Rear Panel USB 3 Connector |
| HS06 | Rear Panel USB 3 Connector |
| HS07 | Rear Panel USB 2 Connector |
| HS08 | Rear Panel USB 2 Connector |
| HS09 | USB 2 Header               |
| HS10 | USB 2 Header               |
| HS12 | m.2 E Key                  |

#### USB 3

| Port | Location                   |
|:-----|:---------------------------|
| SS01 | USB 3 Header               |
| SS02 | USB 3 Header               |
| SS03 | Rear Panel USB 3 Connector |
| SS04 | Rear Panel USB 3 Connector |
| SS05 | Rear Panel USB 3 Connector |
| SS06 | Rear Panel USB 3 Connector |

## 15 Port Limit

Disable the ports you aren't using by removing them from USBPortInjector.kext/Contents/Info.plist

**Example:** If you are not using the USB 2 header ports, then removing HS09,HS10 = 15 ports

## Sunrise Point

Note that this B460 board wants AppleUSBXHCIPCI loading with class AppleUSBXHCISPT, otherwise USB will not work. PCI device ID injection in the OC config.plist:

```xml
...
<key>DeviceProperties</key>
<dict>
    <key>Add</key>
    <dict>
        ...
	<!-- XHC: inject supported device ID -->
	<key>PciRoot(0x0)/Pci(0x14,0x0)</key>
	<dict>
		<key>device-id</key>
		<data>
		r6IAAA==
		</data>
	</dict>
        ...
    </dict>
</dict>
...

```
