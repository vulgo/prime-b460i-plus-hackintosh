#define CREATE_FIELD_REV CreateField (DerefOf (Local0 [Zero]), Zero, 0x07, REV)
#define CREATE_FIELD_VISI CreateField (DerefOf (Local0 [Zero]), 0x40, One, VISI)
#define CREATE_FIELD_GPOS CreateField (DerefOf (Local0 [Zero]), 0x57, 0x08, GPOS)

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
        Name (H1CN, One)
        Name (H1CT, 0x03)
        Name (H1VS, One)
        Name (H1GP, One)
        Name (H2CN, One)
        Name (H2CT, 0x03)
        Name (H2VS, One)
        Name (H2GP, 0x02)
        Name (H3CN, One)
        Name (H3CT, 0x03)
        Name (H3VS, One)
        Name (H3GP, 0x03)
        Name (H4CN, One)
        Name (H4CT, 0x03)
        Name (H4VS, One)
        Name (H4GP, 0x04)
        Name (H5CN, One)
        Name (H5CT, 0x03)
        Name (H5VS, One)
        Name (H5GP, 0x05)
        Name (H6CN, One)
        Name (H6CT, 0x03)
        Name (H6VS, One)
        Name (H6GP, 0x06)
        Name (H7CN, One)
        Name (H7CT, Zero)
        Name (H7VS, One)
        Name (H7GP, 0x07)
        Name (H8CN, One)
        Name (H8CT, Zero)
        Name (H8VS, One)
        Name (H8GP, 0x08)
        Name (H9CN, One)
        Name (H9CT, Zero)
        Name (H9VS, One)
        Name (H9GP, 0x09)
        Name (HACN, One)
        Name (HACT, Zero)
        Name (HAVS, One)
        Name (HAGP, 0x0A)
        Name (HCCN, One)
        Name (HCCT, 0xFF)
        Name (HCVS, Zero)
        Name (HCGP, 0x0B)
        Name (S1CN, One)
        Name (S1CT, 0x03)
        Name (S1VS, One)
        Name (S1GP, One)
        Name (S2CN, One)
        Name (S2CT, 0x03)
        Name (S2VS, One)
        Name (S2GP, 0x02)
        Name (S3CN, One)
        Name (S3CT, 0x03)
        Name (S3VS, One)
        Name (S3GP, 0x03)
        Name (S4CN, One)
        Name (S4CT, 0x03)
        Name (S4VS, One)
        Name (S4GP, 0x04)
        Name (S5CN, One)
        Name (S5CT, 0x03)
        Name (S5VS, One)
        Name (S5GP, 0x05)
        Name (S6CN, One)
        Name (S6CT, 0x03)
        Name (S6VS, One)
        Name (S6GP, 0x06)
        
        Method (GPLD, 2, NotSerialized)
        {
            Local0 = Package ()
            {
                Buffer (0x10){}
            }
            
            CREATE_FIELD_REV     // _PLD: Revision
            CREATE_FIELD_VISI    // _PLD: Visibility
            CREATE_FIELD_GPOS    // _PLD: Group Position
            
            REV = One      // _PLD: Revision = 1           
            VISI = Arg0    // _PLD: Visibility = Arg0          
            GPOS = Arg1    // _PLD: Group Position = Arg1
            
            Return (Local0)
        }

        Method (GUPC, 2, NotSerialized)
        {
            Local0 = Package (0x4) {}
            
            Local0 [Zero] = Arg0    // _UPC: User Connectable = Arg0
            Local0 [One] = Arg1     // _UPC: Connector Type = Arg1
            
            Return (Local0)
        }

        Method (HS01._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
        {
            Return (GUPC (H1CN, H1CT))
        }

        Method (HS01._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (H1VS, H1GP))
        }

        Method (HS02._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
        {
            Return (GUPC (H2CN, H2CT))
        }

        Method (HS02._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (H2VS, H2GP))
        }

        Method (HS03._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
        {
            Return (GUPC (H3CN, H3CT))
        }

        Method (HS03._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (H3VS, H3GP))
        }

        Method (HS04._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
        {
            Return (GUPC (H4CN, H4CT))
        }

        Method (HS04._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (H4VS, H4GP))
        }

        Method (HS05._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
        {
            Return (GUPC (H5CN, H5CT))
        }

        Method (HS05._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (H5VS, H5GP))
        }

        Method (HS06._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
        {
            Return (GUPC (H6CN, H6CT))
        }

        Method (HS06._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (H6VS, H6GP))
        }

        Method (HS07._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
        {
            Return (GUPC (H7CN, H7CT))
        }

        Method (HS07._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (H7VS, H7GP))
        }

        Method (HS08._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
        {
            Return (GUPC (H8CN, H8CT))
        }

        Method (HS08._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (H8VS, H8GP))
        }

        Method (HS09._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
        {
            Return (GUPC (H9CN, H9CT))
        }

        Method (HS09._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (H9VS, H9GP))
        }

        Method (HS10._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
        {
            Return (GUPC (HACN, HACT))
        }

        Method (HS10._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (HAVS, HAGP))
        }

        Method (USR1._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
        {
            Return (GUPC (Zero, 0xFF))
        }

        Method (USR1._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (Zero, Zero))
        }

        Method (USR2._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
        {
            Return (GUPC (Zero, 0xFF))
        }

        Method (USR2._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (Zero, Zero))
        }

        Method (SS01._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
        {
            Return (GUPC (S1CN, S1CT))
        }

        Method (SS01._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (S1VS, S1GP))
        }

        Method (SS02._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
        {
            Return (GUPC (S2CN, S2CT))
        }

        Method (SS02._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (S2VS, S2GP))
        }

        Method (SS03._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
        {
            Return (GUPC (S3CN, S3CT))
        }

        Method (SS03._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (S3VS, S3GP))
        }

        Method (SS04._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
        {
            Return (GUPC (S4CN, S4CT))
        }

        Method (SS04._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (S4VS, S4GP))
        }

        Method (SS05._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
        {
            Return (GUPC (S5CN, S5CT))
        }

        Method (SS05._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (S5VS, S5GP))
        }

        Method (SS06._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
        {
            Return (GUPC (S6CN, S6CT))
        }

        Method (SS06._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
        {
            Return (GPLD (S6VS, S6GP))
        }

        If (CondRefOf (HS11))
        {
            Method (HS11._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (Zero, 0xFF))
            }

            Method (HS11._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (Zero, Zero))
            }
        }

        If (CondRefOf (HS12))
        {
            Method (HS12._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (HCCN, HCCT))
            }

            Method (HS12._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (HCVS, HCGP))
            }
        }

        If (CondRefOf (HS13))
        {
            Method (HS13._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (Zero, 0xFF))
            }

            Method (HS13._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (Zero, Zero))
            }
        }

        If (CondRefOf (HS14))
        {
            Method (HS14._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (Zero, 0xFF))
            }

            Method (HS14._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (Zero, Zero))
            }
        }

        If (CondRefOf (SS07))
        {
            Method (SS07._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (Zero, 0xFF))
            }

            Method (SS07._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (Zero, Zero))
            }
        }

        If (CondRefOf (SS08))
        {
            Method (SS08._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (Zero, 0xFF))
            }

            Method (SS08._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (Zero, Zero))
            }
        }

        If (CondRefOf (SS09))
        {
            Method (SS09._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (Zero, 0xFF))
            }

            Method (SS09._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (Zero, Zero))
            }
        }

        If (CondRefOf (SS10))
        {
            Method (SS10._UPC, 0, NotSerialized)  // _UPC: USB Port Capabilities
            {
                Return (GUPC (Zero, 0xFF))
            }

            Method (SS10._PLD, 0, NotSerialized)  // _PLD: Physical Location of Device
            {
                Return (GPLD (Zero, Zero))
            }
        }
    }
}

