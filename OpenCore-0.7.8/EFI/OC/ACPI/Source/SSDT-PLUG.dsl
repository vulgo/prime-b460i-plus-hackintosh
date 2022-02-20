/*
 *  Enables X86PlatformPlugin
 *  Conflicts with certain CPUFriend SSDTs but not CPUFriendDataProvider.kext
 */

DefinitionBlock ("", "SSDT", 1, "vulgo", "PlugSsdt", 1)
{        
    External (_SB_.PR00, DeviceObj)
    
    If (_OSI ("Darwin"))
    {    
        Method (_SB.PR00._DSM, 4, NotSerialized)
        { 
            If (!Arg2)
            {
                Return (Buffer (One) { 0x3 })
            }

            Return (Package ()
            {
                "plugin-type", One
            })
        }
    }
}
