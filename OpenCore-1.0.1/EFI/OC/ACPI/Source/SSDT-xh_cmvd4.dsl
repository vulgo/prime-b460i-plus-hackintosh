#define REV			0x01
#define NOT_CONNECTABLE		Zero
#define NO_CONNECTOR_TYPE	0xFF
#define RESERVED		Zero
#define HS01_CONNECTABLE	One
#define HS01_CONNECTOR_TYPE	0x03
#define HS01_USER_VISIBLE	0x01
#define HS01_GROUP_POSITION	0x01
#define HS02_CONNECTABLE	One
#define HS02_CONNECTOR_TYPE	0x03
#define HS02_USER_VISIBLE	0x01
#define HS02_GROUP_POSITION	0x02
#define HS03_CONNECTABLE	One
#define HS03_CONNECTOR_TYPE	0x03
#define HS03_USER_VISIBLE	0x01
#define HS03_GROUP_POSITION	0x03
#define HS04_CONNECTABLE	One
#define HS04_CONNECTOR_TYPE	0x03
#define HS04_USER_VISIBLE	0x01
#define HS04_GROUP_POSITION	0x04
#define HS05_CONNECTABLE	One
#define HS05_CONNECTOR_TYPE	0x03
#define HS05_USER_VISIBLE	0x01
#define HS05_GROUP_POSITION	0x05
#define HS06_CONNECTABLE	One
#define HS06_CONNECTOR_TYPE	0x03
#define HS06_USER_VISIBLE	0x01
#define HS06_GROUP_POSITION	0x06
#define HS07_CONNECTABLE	One
#define HS07_CONNECTOR_TYPE	Zero
#define HS07_USER_VISIBLE	0x01
#define HS07_GROUP_POSITION	0x07
#define HS08_CONNECTABLE	One
#define HS08_CONNECTOR_TYPE	Zero
#define HS08_USER_VISIBLE	0x01
#define HS08_GROUP_POSITION	0x08
#define HS09_CONNECTABLE	One
#define HS09_CONNECTOR_TYPE	Zero
#define HS09_USER_VISIBLE	0x01
#define HS09_GROUP_POSITION	0x09
#define HS10_CONNECTABLE	One
#define HS10_CONNECTOR_TYPE	Zero
#define HS10_USER_VISIBLE	0x01
#define HS10_GROUP_POSITION	0x0a
#define HS12_CONNECTABLE	One
#define HS12_CONNECTOR_TYPE	0xff
#define HS12_USER_VISIBLE	0x00
#define HS12_GROUP_POSITION	0x0b
#define SS01_CONNECTABLE	One
#define SS01_CONNECTOR_TYPE	0x03
#define SS01_USER_VISIBLE	0x01
#define SS01_GROUP_POSITION	0x01
#define SS02_CONNECTABLE	One
#define SS02_CONNECTOR_TYPE	0x03
#define SS02_USER_VISIBLE	0x01
#define SS02_GROUP_POSITION	0x02
#define SS03_CONNECTABLE	One
#define SS03_CONNECTOR_TYPE	0x03
#define SS03_USER_VISIBLE	0x01
#define SS03_GROUP_POSITION	0x03
#define SS04_CONNECTABLE	One
#define SS04_CONNECTOR_TYPE	0x03
#define SS04_USER_VISIBLE	0x01
#define SS04_GROUP_POSITION	0x04
#define SS05_CONNECTABLE	One
#define SS05_CONNECTOR_TYPE	0x03
#define SS05_USER_VISIBLE	0x01
#define SS05_GROUP_POSITION	0x05
#define SS06_CONNECTABLE	One
#define SS06_CONNECTOR_TYPE	0x03
#define SS06_USER_VISIBLE	0x01
#define SS06_GROUP_POSITION	0x06

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
		Name (HS01._UPC, Package()	// _UPC: USB Port Capabilities
		{
			HS01_CONNECTABLE,
			HS01_CONNECTOR_TYPE,
			RESERVED,
			RESERVED
		})

		Name (HS01._PLD, Package()	// _PLD: Physical Location of Device
		{
			ToPLD (
				PLD_Revision = REV,
				PLD_UserVisible = HS01_USER_VISIBLE,
				PLD_GroupPosition = HS01_GROUP_POSITION)
		})

		Name (HS02._UPC, Package()	// _UPC: USB Port Capabilities
		{
			HS02_CONNECTABLE,
			HS02_CONNECTOR_TYPE,
			RESERVED,
			RESERVED
		})

		Name (HS02._PLD, Package()	// _PLD: Physical Location of Device
		{
			ToPLD (
				PLD_Revision = REV,
				PLD_UserVisible = HS02_USER_VISIBLE,
				PLD_GroupPosition = HS02_GROUP_POSITION)
		})

		Name (HS03._UPC, Package()	// _UPC: USB Port Capabilities
		{
			HS03_CONNECTABLE,
			HS03_CONNECTOR_TYPE,
			RESERVED,
			RESERVED
		})

		Name (HS03._PLD, Package ()	// _PLD: Physical Location of Device
		{
			ToPLD (
				PLD_Revision = REV,
				PLD_UserVisible = HS03_USER_VISIBLE,
				PLD_GroupPosition = HS03_GROUP_POSITION)
		})

		Name (HS04._UPC, Package()	// _UPC: USB Port Capabilities
		{
			HS04_CONNECTABLE,
			HS04_CONNECTOR_TYPE,
			RESERVED,
			RESERVED
		})

		Name (HS04._PLD, Package ()	// _PLD: Physical Location of Device
		{
			ToPLD (
				PLD_Revision = REV,
				PLD_UserVisible = HS04_USER_VISIBLE,
				PLD_GroupPosition = HS04_GROUP_POSITION)
		})

		Name (HS05._UPC, Package()	// _UPC: USB Port Capabilities
		{
			HS05_CONNECTABLE,
			HS05_CONNECTOR_TYPE,
			RESERVED,
			RESERVED
		})

		Name (HS05._PLD, Package ()	// _PLD: Physical Location of Device
		{
			ToPLD (
				PLD_Revision = REV,
				PLD_UserVisible = HS05_USER_VISIBLE,
				PLD_GroupPosition = HS05_GROUP_POSITION)
		})

		Name (HS06._UPC, Package()	// _UPC: USB Port Capabilities
		{
			HS06_CONNECTABLE,
			HS06_CONNECTOR_TYPE,
			RESERVED,
			RESERVED
		})

		Name (HS06._PLD, Package ()	// _PLD: Physical Location of Device
		{
			ToPLD (
				PLD_Revision = REV,
				PLD_UserVisible = HS06_USER_VISIBLE,
				PLD_GroupPosition = HS06_GROUP_POSITION)
		})

		Name (HS07._UPC, Package()	// _UPC: USB Port Capabilities
		{
			HS07_CONNECTABLE,
			HS07_CONNECTOR_TYPE,
			RESERVED,
			RESERVED
		})

		Name (HS07._PLD, Package ()	// _PLD: Physical Location of Device
		{
			ToPLD (
				PLD_Revision = REV,
				PLD_UserVisible = HS07_USER_VISIBLE,
				PLD_GroupPosition = HS07_GROUP_POSITION) 
		})

		Name (HS08._UPC, Package()	// _UPC: USB Port Capabilities
		{
			HS08_CONNECTABLE,
			HS08_CONNECTOR_TYPE,
			RESERVED,
			RESERVED
		})

		Name (HS08._PLD, Package ()	// _PLD: Physical Location of Device
		{
			ToPLD (
				PLD_Revision = REV,
				PLD_UserVisible = HS08_USER_VISIBLE,
				PLD_GroupPosition = HS08_GROUP_POSITION)
		})

		Name (HS09._UPC, Package()	// _UPC: USB Port Capabilities
		{
			HS09_CONNECTABLE,
			HS09_CONNECTOR_TYPE,
			RESERVED,
			RESERVED
		})

		Name (HS09._PLD, Package ()	// _PLD: Physical Location of Device
		{
			ToPLD (
				PLD_Revision = REV,
				PLD_UserVisible = HS09_USER_VISIBLE,
				PLD_GroupPosition = HS09_GROUP_POSITION)
		})

		Name (HS10._UPC, Package()	// _UPC: USB Port Capabilities
		{
			HS10_CONNECTABLE,
			HS10_CONNECTOR_TYPE,
			RESERVED,
			RESERVED
		})

		Name (HS10._PLD, Package ()	// _PLD: Physical Location of Device
		{
			ToPLD (
				PLD_Revision = REV,
				PLD_UserVisible = HS10_USER_VISIBLE,
				PLD_GroupPosition = HS10_GROUP_POSITION)
		})

		Name (USR1._UPC, Package()	// _UPC: USB Port Capabilities
		{
			NOT_CONNECTABLE,
			NO_CONNECTOR_TYPE,
			RESERVED,
			RESERVED
		})

		Name (USR2._UPC, Package()	// _UPC: USB Port Capabilities
		{
			NOT_CONNECTABLE,
			NO_CONNECTOR_TYPE,
			RESERVED,
			RESERVED
		})

		Name (SS01._UPC, Package()	// _UPC: USB Port Capabilities
		{
			SS01_CONNECTABLE,
			SS01_CONNECTOR_TYPE,
			RESERVED,
			RESERVED
		})

		Name (SS01._PLD, Package ()	// _PLD: Physical Location of Device
		{
			ToPLD (
				PLD_Revision = REV,
				PLD_UserVisible = SS01_USER_VISIBLE,
				PLD_GroupPosition = SS01_GROUP_POSITION)
		})

		Name (SS02._UPC, Package()	// _UPC: USB Port Capabilities
		{
			SS02_CONNECTABLE,
			SS02_CONNECTOR_TYPE,
			RESERVED,
			RESERVED
		})

		Name (SS02._PLD, Package ()	// _PLD: Physical Location of Device
		{
			ToPLD (
				PLD_Revision = REV,
				PLD_UserVisible = SS02_USER_VISIBLE,
				PLD_GroupPosition = SS02_GROUP_POSITION)
		})

		Name (SS03._UPC, Package()	// _UPC: USB Port Capabilities
		{
			SS03_CONNECTABLE,
			SS03_CONNECTOR_TYPE,
			RESERVED,
			RESERVED
		})

		Name (SS03._PLD, Package ()	// _PLD: Physical Location of Device
		{
			ToPLD (
				PLD_Revision = REV,
				PLD_UserVisible = SS03_USER_VISIBLE,
				PLD_GroupPosition = SS03_GROUP_POSITION)
		})

		Name (SS04._UPC, Package()	// _UPC: USB Port Capabilities
		{
			SS04_CONNECTABLE,
			SS04_CONNECTOR_TYPE,
			RESERVED,
			RESERVED
		})

		Name (SS04._PLD, Package ()	// _PLD: Physical Location of Device
		{
			ToPLD (
				PLD_Revision = REV,
				PLD_UserVisible = SS04_USER_VISIBLE,
				PLD_GroupPosition = SS04_GROUP_POSITION)
		})

		Name (SS05._UPC, Package()	// _UPC: USB Port Capabilities
		{
			SS05_CONNECTABLE,
			SS05_CONNECTOR_TYPE,
			RESERVED,
			RESERVED
		})

		Name (SS05._PLD, Package ()	// _PLD: Physical Location of Device
		{
			ToPLD (
				PLD_Revision = REV,
				PLD_UserVisible = SS05_USER_VISIBLE,
				PLD_GroupPosition = SS06_GROUP_POSITION)
		})

		Name (SS06._UPC, Package()	// _UPC: USB Port Capabilities
		{
			SS06_CONNECTABLE,
			SS06_CONNECTOR_TYPE,
			RESERVED,
			RESERVED
		})

		Name (SS06._PLD, Package ()	// _PLD: Physical Location of Device
		{
			ToPLD (
				PLD_Revision = REV,
				PLD_UserVisible = SS06_USER_VISIBLE,
				PLD_GroupPosition = SS06_GROUP_POSITION)
		})

		If (CondRefOf (HS11))
		{
			Name (HS11._UPC, Package()	// _UPC: USB Port Capabilities
			{
				NOT_CONNECTABLE,
				NO_CONNECTOR_TYPE,
				RESERVED,
				RESERVED
			})
		}

		If (CondRefOf (HS12))
		{
			Name (HS12._UPC, Package()	// _UPC: USB Port Capabilities
			{
				HS12_CONNECTABLE,
				HS12_CONNECTOR_TYPE,
				RESERVED,
				RESERVED
			})

			Name (HS12._PLD, Package ()	// _PLD: Physical Location of Device
			{
				ToPLD (
					PLD_Revision = REV,
					PLD_UserVisible = HS12_USER_VISIBLE,
					PLD_GroupPosition = HS12_GROUP_POSITION)
			})
		}

		If (CondRefOf (HS13))
		{
			Name (HS13._UPC, Package()	// _UPC: USB Port Capabilities
			{
				NOT_CONNECTABLE,
				NO_CONNECTOR_TYPE,
				RESERVED,
				RESERVED
			})
		}

		If (CondRefOf (HS14))
		{
			Name (HS14._UPC, Package()	// _UPC: USB Port Capabilities
			{
				NOT_CONNECTABLE,
				NO_CONNECTOR_TYPE,
				RESERVED,
				RESERVED
			})
		}

		If (CondRefOf (SS07))
		{
			Name (SS07._UPC, Package()	// _UPC: USB Port Capabilities
			{
				NOT_CONNECTABLE,
				NO_CONNECTOR_TYPE,
				RESERVED,
				RESERVED
			})
		}

		If (CondRefOf (SS08))
		{
			Name (SS08._UPC, Package()	// _UPC: USB Port Capabilities
			{
				NOT_CONNECTABLE,
				NO_CONNECTOR_TYPE,
				RESERVED,
				RESERVED
			})
		}

		If (CondRefOf (SS09))
		{
			Name (SS09._UPC, Package()	// _UPC: USB Port Capabilities
			{
				NOT_CONNECTABLE,
				NO_CONNECTOR_TYPE,
				RESERVED,
				RESERVED
			})
		}
	
		If (CondRefOf (SS10))
		{
			Name (SS10._UPC, Package()	// _UPC: USB Port Capabilities
			{
				NOT_CONNECTABLE,
				NO_CONNECTOR_TYPE,
				RESERVED,
				RESERVED
			})
		}
	}
}

