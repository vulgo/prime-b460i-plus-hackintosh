DefinitionBlock ("", "SSDT", 1, "vulgo", "iMacSsdt", 0x00000001)
{
    External (_SB_.PCI0, DeviceObj)
    External (_SB_.PCI0.PEG0, DeviceObj)
    External (_SB_.PCI0.SBUS, DeviceObj)
    External (_SB_.PR00, DeviceObj)
    External (SBRG, IntObj)
    External (STAS, IntObj)

    Name (SLTP, Zero)


    Method (_SB.PR00._DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
    {
        if (!_OSI("Darwin"))
        {
            Return (Buffer (){ Zero })
        }
        
        if (Arg2 == Zero)
        {
            Return (Buffer (){ 0x3 })
        }        
        
        Return (Package (0x02)
        {
            "plugin-type", 
            One
        })
    }

    Method (_TTS, 1, NotSerialized)  // _TTS: Transition To State
    {
        SLTP = Arg0
    }

    Method (_SB._INI, 0, NotSerialized)  // _INI: Initialize
    {
        If (_OSI ("Darwin"))
        {
            STAS = One
            SBRG = Zero
        }
    }

    Device (_SB.PCI0.MCHC)
    {
        Name (_ADR, Zero)  // _ADR: Address
        Name (_STA, 0x0F)  // _STA: Status
    }

    Device (_SB.PCI0.PEG0.HDAU)
    {
        Name (_ADR, One)  // _ADR: Address
    }

    Device (_SB.PCI0.SBUS.BUS0)
    {
        Name (_CID, "smbus")  // _CID: Compatible ID
        Name (_ADR, Zero)  // _ADR: Address
        Name (_STA, 0x0F)  // _STA: Status
    }

    Device (_SB.USBX)
    {
        Name (_ADR, Zero)  // _ADR: Address
    }

    Method (_SB.USBX._DSM, 4, NotSerialized)  // _DSM: Device-Specific Method
    {
        if (!_OSI("Darwin"))
        {
            Return (Buffer (){ Zero })
        }
               
        if (Arg2 == Zero)
        {
            Return (Buffer (){ 0x3 })
        }        
        
        Return(Package (0x08)
        {
            "kUSBSleepPortCurrentLimit", 
            0x0834, 
            "kUSBSleepPowerSupply", 
            0x13EC, 
            "kUSBWakePortCurrentLimit", 
            0x0834, 
            "kUSBWakePowerSupply", 
            0x13EC
        })
    }
}

