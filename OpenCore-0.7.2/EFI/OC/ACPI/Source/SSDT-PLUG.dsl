DefinitionBlock ("", "SSDT", 1, "vulgo", "PlugSsdt", 1)
{        
    External (_SB_.PR00, DeviceObj)
    
    Scope (\_SB.PR00)
    {

        Method (_DSM, 4, NotSerialized)
        {            
            Local0 = _OSI ("Darwin")
            
            If (!Local0)
            {
                Return (Buffer ()
                {
                    Zero
                })
            }
            
            If (!Arg2)
            {
                Return (Buffer ()
                {
                    0x03
                })
            }

            Return (Package ()
            {
                "plugin-type", 
                One
            })
        }
    }
}
