/*
 *  May be useful with certain Intel wireless
 *  hardware on certain OS drivers
 *
 *  List of devices in README-SSDT-xh_cmvd4
 */

DefinitionBlock ("", "SSDT", 1, "vulgo", "ACWIntel", 1)
{
    External (_SB_.PCI0.RP11.PXSX.WIST, MethodObj)
    External (_SB_.PCI0.XHC_.RHUB.HS12, DeviceObj)
    External (ATDV, IntObj)
    External (BED2, IntObj)
    External (BED3, IntObj)
    External (BTBR, IntObj)
    External (BTL2, IntObj)
    External (BTLE, IntObj)
    External (BTLL, IntObj)
    External (BTSE, IntObj)
    External (CECV, IntObj)

    If (CondRefOf (_SB.PCI0.RP11.PXSX) && CondRefOf (_SB.PCI0.XHC.RHUB.HS12) && _SB.PCI0.RP11.PXSX.WIST ())
    {
        Name (_SB.PCI0.XHC.RHUB.HS12.SADX, Package ()
        {
            Zero, 
            Package () { 0x07, 0x80000000 }, 
            Package () { 0x12, 0x80000000 }
        })

        Method (_SB.PCI0.XHC.RHUB.HS12.SADS, 0, Serialized)
        {
            DerefOf (SADX [One]) [One] = ATDV
            DerefOf (SADX [0x02]) [One] = ATDV
            Return (SADX)
        }

        Name (_SB.PCI0.XHC.RHUB.HS12.BRDY, Package ()
        {
            Zero, 
            Package () { 0x12, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80, 0x80 }
        })

        Method (_SB.PCI0.XHC.RHUB.HS12.BRDS, 0, Serialized)
        {
            DerefOf (BRDY [One]) [One] = BTSE
            DerefOf (BRDY [One]) [0x02] = BTBR
            DerefOf (BRDY [One]) [0x03] = BED2
            DerefOf (BRDY [One]) [0x04] = BED3
            DerefOf (BRDY [One]) [0x05] = BTLE
            DerefOf (BRDY [One]) [0x06] = BTL2
            DerefOf (BRDY [One]) [0x07] = BTLL
            Return (BRDY)
        }

        Name (_SB.PCI0.XHC.RHUB.HS12.ECKY, Package ()
        {
            Zero, 
            Package () { 0x12, Zero }
        })

        Method (_SB.PCI0.XHC.RHUB.HS12.ECKV, 0, Serialized)
        {
            DerefOf (ECKY [One]) [One] = CECV
            Return (ECKY)
        }

        Name (_SB.PCI0.XHC.RHUB.HS12.GPCX, Package ()
        {
            Zero, 
            Package () { 0x07, Package () { Zero, Zero, Zero } }, 
            Package () { 0x12, Package () { Zero, Zero, Zero } }
        })

        Method (_SB.PCI0.XHC.RHUB.HS12.GPC, 0, Serialized)
        {
            Return (GPCX)
        }
    }
}

