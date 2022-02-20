/*
 *  May be useful with certain Intel wireless
 *  hardware on certain OS drivers
 *
 *  List of devices in README-SSDT-xh_cmvd4
 */

DefinitionBlock ("", "SSDT", 1, "vulgo", "IntWfiBt", 1)
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

    If ((CondRefOf (\_SB.PCI0.RP11.PXSX) && CondRefOf (\_SB.PCI0.XHC.RHUB.HS12)))
    {
        If (\_SB.PCI0.RP11.PXSX.WIST ())
        {
            Scope (\_SB.PCI0.XHC.RHUB.HS12)
            {
                Name (SADX, Package (0x03)
                {
                    Zero, 
                    Package (0x02)
                    {
                        0x07, 
                        0x80000000
                    }, 

                    Package (0x02)
                    {
                        0x12, 
                        0x80000000
                    }
                })

                Method (SADS, 0, Serialized)
                {
                    DerefOf (SADX [One]) [One] = ATDV
                    DerefOf (SADX [0x02]) [One] = ATDV
                    Return (SADX)
                }

                Name (BRDY, Package (0x02)
                {
                    Zero, 
                    Package (0x08)
                    {
                        0x12, 
                        0x80, 
                        0x80, 
                        0x80, 
                        0x80, 
                        0x80, 
                        0x80, 
                        0x80
                    }
                })

                Method (BRDS, 0, Serialized)
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

                Name (ECKY, Package (0x02)
                {
                    Zero, 
                    Package (0x02)
                    {
                        0x12, 
                        Zero
                    }
                })

                Method (ECKV, 0, Serialized)
                {
                    DerefOf (ECKY [One]) [One] = CECV
                    Return (ECKY)
                }

                Name (GPCX, Package (0x03)
                {
                    Zero, 
                    Package (0x02)
                    {
                        0x07, 
                        Package (0x03)
                        {
                            Zero, 
                            Zero, 
                            Zero
                        }
                    }, 

                    Package (0x02)
                    {
                        0x12, 
                        Package (0x03)
                        {
                            Zero, 
                            Zero, 
                            Zero
                        }
                    }
                })

                Method (GPC, 0, Serialized)
                {
                    Return (GPCX)
                }
            }
        }
    }
}

