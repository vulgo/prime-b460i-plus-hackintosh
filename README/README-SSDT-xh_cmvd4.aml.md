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
