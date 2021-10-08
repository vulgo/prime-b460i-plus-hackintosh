## Intel HD630 Graphics

This needs to be written

### Device Properties

Some additional ```WhateverGreen.kext``` device properties

- ```framebuffer-unifiedmem``` increases unified memory limit to 2G (from 1.5G)
- ```force-online``` and ```force-online-framebuffers``` works around HDMI connection failure after waking from sleep

```xml
...
<key>DeviceProperties</key>
<dict>
    <key>Add</key>
    <dict>
        ...
        <key>PciRoot(0x0)/Pci(0x2,0x0)</key>
        <dict>
            ...
            <key>framebuffer-unifiedmem</key>
            <data>AAAAgA==</data>
            ...
            <key>force-online</key>
            <data>AQAAAA==</data>
            <key>force-online-framebuffers</key>
            <data>Af////////8=</data>
            ....
        </dict>
        ...
    </dict>
</dict>
...
```


### Graphics failure booting with two displays

This needs to be written

- boot with the first display connected, connect the second after the login window has presented
- boot with both displays connnected, it is then necessary to reconnect the display(s)
