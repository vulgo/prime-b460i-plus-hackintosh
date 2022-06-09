/*
 *  Enables RTC and also disables HPET
 *  Conflicts with SSDT-AWAC-DISABLE, one is required
 */

DefinitionBlock ("", "SSDT", 1, "vulgo", "AwacHpet", 1)
{
    External (STAS, IntObj)
    External (HPTE, IntObj)
    
    Method (_SB._INI, 0, NotSerialized)
    {
        If (_OSI ("Darwin"))
        {
            STAS = One
            HPTE = Zero
        }
    }
}
