# SSDT-xh_cmvd4.aml

The stock `xh_cmvd4` table is incomplete and contains unsupported module-level `StoreOp` opcodes. It has been patched for proper macOS compatibility.

The table may be further optimized, disabling unused USB ports and satisfying the macOS 15 ports requirement. For changes to the port map in `xh_cmvd4`  to be effective, `USBPorts.kext` or similar kernel extensions must *not* be loaded.

### Field Translation

| Field | ACPI                 |
|:------|:---------------------|
| xxCN  | _UPC connectable     |
| xxCT  | _UPC connector type  |
| xxVS  | _PLD user visible    |
| xxGP  | _PLD group position  |

## Disabling Ports

A port will be disabled when both `_UPC` `connectable` and `_PLD` `user visible` field values are `Zero`.

```
DefinitionBlock ("", "SSDT", 1, "vulgo", "xh_cmvd4", 1)
    ...
    Scope (\_SB.PCI0.XHC.RHUB)
    {
        ...
        /* port HS14 is disabled */
        Name (HECN, Zero) /* connectable is zero */
        Name (HECT, 0xFF)
        Name (HEVS, Zero) /* user visible is zero */
        Name (HEGP, Zero)
        ...        
        /* port SS10 is disabled */
        Name (SACN, Zero) /* connectable is zero */
        Name (SACT, 0xFF)
        Name (SAVS, Zero) /* user visible is zero */
        Name (SAGP, Zero)
        ...
    }
    ...
}
```

## Intel Wireless Cards

<details><summary>Code specific to the following devices was moved from <code>SSDT-xh_cmvd4</code> to a separate SSDT <code>SSDT-AC-WIRELESS-INTEL</code></summary><br />

- 0x095A Wireless-AC 7265
- 0x095B Wireless-AC 7265
- 0x3165 Wireless-AC 3165
- 0x3166 Wireless-AC 3165
- 0x08B1 Wireless-AC 7260
- 0x08B2 Wireless-AC 7260
- 0x08B3 Wireless-AC 3160
- 0x08B4 Wireless-AC 3160
- 0x24F3 Wireless-AC 8260
- 0x24F4 Wireless-AC 8260
- 0x24F5 Wireless-AC 4165
- 0x24F6 Wireless-AC 4165
- 0x24FD Wireless-AC 8265/8275
- 0x24FB Wireless-AC 3168
- 0x2526 Wireless-AC 9260
- 0x2723 Wi-Fi 6 AX200

The DSL is in the `Source` ACPI sub-directory. macOS support for these devices is `out-of-scope` here.

For macOS support refer to the [OpenIntelWireless](https://github.com/OpenIntelWireless) project.
</details>
