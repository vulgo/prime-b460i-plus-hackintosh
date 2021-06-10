DefinitionBlock ("", "SSDT", 1, "vulgo", "xh_cmvd4", 1)
{
    External (_SB_.PCI0.XHC_.RHUB, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS01, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS02, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS03, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS04, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS05, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS06, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS07, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS08, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS09, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS10, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS11, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS12, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS13, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.HS14, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS01, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS02, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS03, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS04, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS05, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS06, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS07, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS08, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS09, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.SS10, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.USR1, DeviceObj)
    External (_SB_.PCI0.XHC_.RHUB.USR2, DeviceObj)

    Scope (\_SB.PCI0.XHC.RHUB)
    {
        /* HS01 */
        Name (H1CN, One)
        Name (H1CT, 0x03)
        Name (H1VS, One)
        Name (H1GP, One)
        
        /* HS02 */
        Name (H2CN, One)
        Name (H2CT, 0x03)
        Name (H2VS, One)
        Name (H2GP, 0x02)
        
        /* HS03 */
        Name (H3CN, One)
        Name (H3CT, 0x03)
        Name (H3VS, One)
        Name (H3GP, 0x03)
        
        /* HS04 */
        Name (H4CN, One)
        Name (H4CT, 0x03)
        Name (H4VS, One)
        Name (H4GP, 0x04)
        
        /* HS05 */
        Name (H5CN, One)
        Name (H5CT, 0x03)
        Name (H5VS, One)
        Name (H5GP, 0x05)
        
        /* HS06 */
        Name (H6CN, One)
        Name (H6CT, 0x03)
        Name (H6VS, One)
        Name (H6GP, 0x06)
        
        /* HS07 */
        Name (H7CN, One)
        Name (H7CT, Zero)
        Name (H7VS, One)
        Name (H7GP, 0x07)
        
        /* HS08 */
        Name (H8CN, One)
        Name (H8CT, Zero)
        Name (H8VS, One)
        Name (H8GP, 0x08)
        
        /* HS09 */
        Name (H9CN, One)
        Name (H9CT, Zero)
        Name (H9VS, One)
        Name (H9GP, 0x09)
        
        /* HS10 */
        Name (HACN, One)
        Name (HACT, Zero)
        Name (HAVS, One)
        Name (HAGP, 0x0A)
        
        /* HS12 */
        Name (HCCN, One)
        Name (HCCT, 0xFF)
        Name (HCVS, Zero)
        Name (HCGP, 0x0B)
        
        /* SS01 */
        Name (S1CN, One)
        Name (S1CT, 0x03)
        Name (S1VS, One)
        Name (S1GP, One)
        
        /* SS02 */
        Name (S2CN, One)
        Name (S2CT, 0x03)
        Name (S2VS, One)
        Name (S2GP, 0x02)
        
        /* SS03 */
        Name (S3CN, One)
        Name (S3CT, 0x03)
        Name (S3VS, One)
        Name (S3GP, 0x03)
        
        /* SS04 */
        Name (S4CN, One)
        Name (S4CT, 0x03)
        Name (S4VS, One)
        Name (S4GP, 0x04)
        
        /* SS05 */
        Name (S5CN, One)
        Name (S5CT, 0x03)
        Name (S5VS, One)
        Name (S5GP, 0x05)
        
        /* SS06 */
        Name (S6CN, One)
        Name (S6CT, 0x03)
        Name (S6VS, One)
        Name (S6GP, 0x06)
        
        Method (GPLD, 2, NotSerialized)
        {
            Local0 = Package () {
                Buffer (0x10) {}
            }
                        
            CreateField (DerefOf (Local0 [Zero]), Zero, 0x07, REV)
            REV = One
            CreateField (DerefOf (Local0 [Zero]), 0x40, One, VISI)
            VISI = Arg0
            CreateField (DerefOf (Local0 [Zero]), 0x57, 0x08, GPOS)
            GPOS = Arg1
            
            Return (Local0)
        }

        Method (GUPC, 2, NotSerialized)
        {
            Local0 = Package () {
                Zero, Zero, Zero, Zero
            }
            
            Local0 [Zero] = Arg0
            Local0 [One] = Arg1
            Return (Local0)
        }

        Scope (HS01)
        {
            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (H1CN, H1CT))
            }

            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (H1VS, H1GP))
            }
        }

        Scope (HS02)
        {
            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (H2CN, H2CT))
            }

            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (H2VS, H2GP))
            }
        }

        Scope (HS03)
        {
            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (H3CN, H3CT))
            }

            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (H3VS, H3GP))
            }
        }

        Scope (HS04)
        {
            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (H4CN, H4CT))
            }

            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (H4VS, H4GP))
            }
        }

        Scope (HS05)
        {
            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (H5CN, H5CT))
            }

            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (H5VS, H5GP))
            }
        }

        Scope (HS06)
        {
            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (H6CN, H6CT))
            }

            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (H6VS, H6GP))
            }
        }

        Scope (HS07)
        {
            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (H7CN, H7CT))
            }

            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (H7VS, H7GP))
            }
        }

        Scope (HS08)
        {
            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (H8CN, H8CT))
            }

            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (H8VS, H8GP))
            }
        }

        Scope (HS09)
        {
            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (H9CN, H9CT))
            }

            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (H9VS, H9GP))
            }
        }

        Scope (HS10)
        {
            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (HACN, HACT))
            }

            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (HAVS, HAGP))
            }
        }

        Scope (USR1)
        {
            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (Zero, 0xFF))
            }

            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (Zero, Zero))
            }
        }

        Scope (USR2)
        {
            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (Zero, 0xFF))
            }

            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (Zero, Zero))
            }
        }

        Scope (SS01)
        {
            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (S1CN, S1CT))
            }

            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (S1VS, S1GP))
            }
        }

        Scope (SS02)
        {
            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (S2CN, S2CT))
            }

            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (S2VS, S2GP))
            }
        }

        Scope (SS03)
        {
            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (S3CN, S3CT))
            }

            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (S3VS, S3GP))
            }
        }

        Scope (SS04)
        {
            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (S4CN, S4CT))
            }

            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (S4VS, S4GP))
            }
        }

        Scope (SS05)
        {
            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (S5CN, S5CT))
            }

            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (S5VS, S5GP))
            }
        }

        Scope (SS06)
        {
            Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (S6CN, S6CT))
            }

            Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (S6VS, S6GP))
            }
        }

        If (CondRefOf (HS11))
        {
            Scope (HS11)
            {
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    Return (GUPC (Zero, 0xFF))
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    Return (GPLD (Zero, Zero))
                }
            }
        }

        If (CondRefOf (HS12))
        {
            Scope (HS12)
            {
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    Return (GUPC (HCCN, HCCT))
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    Return (GPLD (HCVS, HCGP))
                }
            }
        }

        If (CondRefOf (HS13))
        {
            Scope (HS13)
            {
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    Return (GUPC (Zero, 0xFF))
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    Return (GPLD (Zero, Zero))
                }
            }
        }

        If (CondRefOf (HS14))
        {
            Scope (HS14)
            {
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    Return (GUPC (Zero, 0xFF))
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    Return (GPLD (Zero, Zero))
                }
            }
        }

        If (CondRefOf (SS07))
        {
            Scope (SS07)
            {
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    Return (GUPC (Zero, 0xFF))
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    Return (GPLD (Zero, Zero))
                }
            }
        }

        If (CondRefOf (SS08))
        {
            Scope (SS08)
            {
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    Return (GUPC (Zero, 0xFF))
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    Return (GPLD (Zero, Zero))
                }
            }
        }

        If (CondRefOf (SS09))
        {
            Scope (SS09)
            {
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    Return (GUPC (Zero, 0xFF))
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    Return (GPLD (Zero, Zero))
                }
            }
        }

        If (CondRefOf (SS10))
        {
            Scope (SS10)
            {
                Method (_UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
                {
                    Return (GUPC (Zero, 0xFF))
                }

                Method (_PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
                {
                    Return (GPLD (Zero, Zero))
                }
            }
        }
    }
}
