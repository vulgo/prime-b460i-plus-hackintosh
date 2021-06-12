DefinitionBlock ("", "SSDT", 1, "vulgo", "AwacSsdt", 1)
{
    External (STAS, IntObj)
    
    Scope (_SB)
    {
        Method (_INI, 0, NotSerialized)
        {
            If (_OSI ("Darwin"))
            {
                STAS = One
            }
        }
    }
}
