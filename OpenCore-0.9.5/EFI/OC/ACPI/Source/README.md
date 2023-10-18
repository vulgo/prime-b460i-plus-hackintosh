## ACPI Files in this directory

**Taken from Issue #15**

### SSDT-AC-WIRELESS-INTEL

Maybe useful for Windows or Linux users with certain Intel wireless cards. Maybe useful for macOS users using Intel wireless cards. I have no idea. I removed a lot of code from stock table xh_cmvd4 so this is an option to restore possible lost driver functionality for cards listed at the bottom of /README/README-SSDT-xh_cmvd4.md. I have no idea if it does anything useful as I don't have one of these cards. I know it does nothing if you don't.

### SSDT-AWAC-DISABLE

This is the standard SSDT-AWAC but does nothing if method _SB._INI already exists, it lets all OS use RTC

### SSDT-AWAC-HPET-DISABLE

Same as above but stops using the High Precision Event Timer like Apple did around when Kaby Lake rolled out. Again does nothing if method _SB._INI already exists by prior SSDT creating one

### SSDT-PLUG

Standard SSDT-PLUG for enabling CPU power management incompatible with the SSDT method for providing CPUFriend data, i think it is originally by RehabMan

### SSDT-SBUS-MCHC

Standard SMBUSPCI loading, AppleSMBUSController loading and Memory Controller device creating SSDT maybe originally devised by MasterChief, OpenCore has it so here it is as well

### SSDT-SLTP

Sets an SLTP value when we go to sleep, it is from [here](https://pikeralpha.wordpress.com/2017/01/12/debugging-sleep-issues/) where there is more, maybe for laptops with S0 low power states. I once found it to resolve a sleep issue so since then always include it, as the blog post says it is read by various drivers and I prefer they read normal S3 sleep if that is the sleep state being entered. On the other hand it may do nothing.

### SSDT-USBX

This is documented at /README/README-usbtool.command.md in the spoiler

### SSDT-xh_cmvd4

This is documented in /README/README-SSDT-xh_cmvd4.md
