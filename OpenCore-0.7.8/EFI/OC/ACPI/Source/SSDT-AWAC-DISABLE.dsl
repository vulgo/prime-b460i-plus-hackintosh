/*
 *  Enables RTC
 *  Conflicts with SSDT-AWAC-HPET-DISABLE, one is required
 */

DefinitionBlock ("", "SSDT", 1, "vulgo", "AwacSsdt", 1)
{
    External (STAS, IntObj)
    
    Method (_SB._INI, 0, NotSerialized)
    {
        If (_OSI ("Darwin"))
        {
            STAS = One
        }
    }
}
