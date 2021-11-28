# Intel Graphics

Intel graphics should work well with a single display. Prefer DisplayPort instead of HDMI where possible.

#### Sources

- [acidanthera/WhateverGreen/README](https://github.com/acidanthera/WhateverGreen/blob/master/README.md)
- [acidanthera/WhateverGreen/FAQ/IntelHD](https://github.com/acidanthera/WhateverGreen/blob/master/Manual/FAQ.IntelHD.en.md)
- [acidanthera/WhateverGreen/FAQ/Shiki](https://github.com/acidanthera/WhateverGreen/blob/master/Manual/FAQ.Shiki.en.md)

### Workarounds for graphics failures after booting with two displays

- boot with the first display connected, connect the second after the login window has presented
- boot with both displays connnected, it is then necessary to reconnect the display(s)

### WhateverGreen.kext

#### Boot arguments

- ```igfxfw=2``` optionally forces WEG to load Apple's graphics microcode (GuC)

#### Device Properties

Some ```WhateverGreen.kext``` device properties not mentioned in `README.md`

- `framebuffer-unifiedmem` optionally increases the unified memory limit from `1.5G` to `2G`
- `force-online` and `force-online-framebuffers` works around HDMI black screen issues after waking from sleep

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


