/*
 *  Enables RTC
 *  Conflicts with SSDT-AWAC-HPET-DISABLE, one is required
 */

DefinitionBlock ("", "SSDT", 1, "vulgo", "AwacSsdt", 1)
{
    External (STAS, IntObj)
    
    If (_OSI ("Darwin"))
    {
        If (!CondRefOf (_SB.INI))
        {
            Method (_SB._INI, 0, NotSerialized)
            {
                STAS = One
            }
        }
    }
}
