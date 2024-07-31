

create file and waiting upload
```
# chmod whole folder to 777
sudo chmod -R 777 /private/tftpboot
cd /private/tftpboot/
touch mmcblk0p_GPT.bin
touch mmcblk0p1_0SBL1.bin
touch mmcblk0p2_0BOOTCONFIG.bin
touch mmcblk0p3_0BOOTCONFIG1.bin
touch mmcblk0p4_0QSEE.bin
touch mmcblk0p5_0QSEE_1.bin
touch mmcblk0p6_0DEVCFG.bin
touch mmcblk0p7_0DEVCFG_1.bin
touch mmcblk0p8_0RPM.bin
touch mmcblk0p9_0RPM_1.bin
touch mmcblk0p10_0CDT.bin
touch mmcblk0p11_0CDT_1.bin
touch mmcblk0p12_0APPSBLENV.bin
touch mmcblk0p13_0APPSBL.bin
touch mmcblk0p14_0APPSBL_1.bin
touch mmcblk0p15_0ART.bin
touch mmcblk0p16_0HLOS.bin
touch mmcblk0p17_0HLOS_1.bin
touch mmcblk0p18_rootfs.bin
touch mmcblk0p19_0WIFIFW.bin
touch mmcblk0p20_rootfs_1.bin
touch mmcblk0p21_0WIFIFW_1.bin
touch mmcblk0p22_rootfs_data.bin
touch mmcblk0p23_0ETHPHYFW.bin
touch mmcblk0p24_plugin.bin
touch mmcblk0p25_log1.bin
touch mmcblk0p25_log2.bin
touch mmcblk0p25_log3.bin
touch mmcblk0p25_log4.bin
touch mmcblk0p25_log5.bin
touch mmcblk0p26_swap1.bin
touch mmcblk0p26_swap2.bin
touch mmcblk0p26_swap3.bin
touch mmcblk0p26_swap4.bin
touch mmcblk0p26_swap5.bin
touch mmcblk0p26_swap6.bin
touch mmcblk0p26_swap7.bin
touch mmcblk0p26_swap8.bin
chmod 777 *

# prepare file and enable tftp server
cd ~/downloads
cp gpt-JDC_AX1800_Pro_dual-boot_rootfs2048M_no-last-partition.bin /private/tftpboot/
cp uboot-JDC_AX1800_Pro-AX6600_Athena-20240510.bin /private/tftpboot/
sudo launchctl load -F /System/Library/LaunchDaemons/tftp.plist
```


Disammble the router, connect to it with usbtty
Connect laptop and router lan port with RJ45 cable, assign IP `192.168.10.1/24` at PC

```
screen /dev/tty.usbserial-130 115200
#Press enter to intrrupt the boot, get the shell

# Backup the firmware. Multiple execution are not supported, must execute line by line
mmc read 0x50000000 0x00000000 0x00000022 && tftpput 0x50000000 0x00004400 mmcblk0p_GPT.bin
mmc read 0x50000000 0x00000022 0x00000600 && tftpput 0x50000000 0x000c0000 mmcblk0p1_0SBL1.bin
mmc read 0x50000000 0x00000622 0x00000200 && tftpput 0x50000000 0x00040000 mmcblk0p2_0BOOTCONFIG.bin
mmc read 0x50000000 0x00000822 0x00000200 && tftpput 0x50000000 0x00040000 mmcblk0p3_0BOOTCONFIG1.bin
mmc read 0x50000000 0x00000a22 0x00000e00 && tftpput 0x50000000 0x001c0000 mmcblk0p4_0QSEE.bin
mmc read 0x50000000 0x00001822 0x00000e00 && tftpput 0x50000000 0x001c0000 mmcblk0p5_0QSEE_1.bin
mmc read 0x50000000 0x00002622 0x00000200 && tftpput 0x50000000 0x00040000 mmcblk0p6_0DEVCFG.bin
mmc read 0x50000000 0x00002822 0x00000200 && tftpput 0x50000000 0x00040000 mmcblk0p7_0DEVCFG_1.bin
mmc read 0x50000000 0x00002a22 0x00000200 && tftpput 0x50000000 0x00040000 mmcblk0p8_0RPM.bin
mmc read 0x50000000 0x00002c22 0x00000200 && tftpput 0x50000000 0x00040000 mmcblk0p9_0RPM_1.bin
mmc read 0x50000000 0x00002e22 0x00000200 && tftpput 0x50000000 0x00040000 mmcblk0p10_0CDT.bin
mmc read 0x50000000 0x00003022 0x00000200 && tftpput 0x50000000 0x00040000 mmcblk0p11_0CDT_1.bin
mmc read 0x50000000 0x00003222 0x00000200 && tftpput 0x50000000 0x00040000 mmcblk0p12_0APPSBLENV.bin
mmc read 0x50000000 0x00003422 0x00000500 && tftpput 0x50000000 0x000a0000 mmcblk0p13_0APPSBL.bin
mmc read 0x50000000 0x00003922 0x00000500 && tftpput 0x50000000 0x000a0000 mmcblk0p14_0APPSBL_1.bin

mmc read 0x50000000 0x00003e22 0x00000200 && tftpput 0x50000000 0x00040000 mmcblk0p15_0ART.bin
mmc read 0x50000000 0x00004022 0x00003000 && tftpput 0x50000000 0x00600000 mmcblk0p16_0HLOS.bin
mmc read 0x50000000 0x00007022 0x00003000 && tftpput 0x50000000 0x00600000 mmcblk0p17_0HLOS_1.bin
mmc read 0x50000000 0x0000a022 0x0001e000 && tftpput 0x50000000 0x03c00000 mmcblk0p18_rootfs.bin
mmc read 0x50000000 0x00028022 0x00002000 && tftpput 0x50000000 0x00400000 mmcblk0p19_0WIFIFW.bin
mmc read 0x50000000 0x0002a022 0x0001e000 && tftpput 0x50000000 0x03c00000 mmcblk0p20_rootfs_1.bin
mmc read 0x50000000 0x00048022 0x00002000 && tftpput 0x50000000 0x00400000 mmcblk0p21_0WIFIFW_1.bin
mmc read 0x50000000 0x0004a022 0x0000a000 && tftpput 0x50000000 0x01400000 mmcblk0p22_rootfs_data.bin
mmc read 0x50000000 0x00054022 0x00000400 && tftpput 0x50000000 0x00080000 mmcblk0p23_0ETHPHYFW.bin
mmc read 0x50000000 0x00054422 0x0002bc00 && tftpput 0x50000000 0x05780000 mmcblk0p24_plugin.bin

mmc read 0x50000000 0x00080022 0x00020000 && tftpput 0x50000000 0x04000000 mmcblk0p25_log1.bin
mmc read 0x50000000 0x000a0022 0x00020000 && tftpput 0x50000000 0x04000000 mmcblk0p25_log2.bin
mmc read 0x50000000 0x000c0022 0x00020000 && tftpput 0x50000000 0x04000000 mmcblk0p25_log3.bin
mmc read 0x50000000 0x000e0022 0x00020000 && tftpput 0x50000000 0x04000000 mmcblk0p25_log4.bin
mmc read 0x50000000 0x00100022 0x00016000 && tftpput 0x50000000 0x02c00000 mmcblk0p25_log5.bin

mmc read 0x50000000 0x00116022 0x00020000 && tftpput 0x50000000 0x04000000 mmcblk0p26_swap1.bin
mmc read 0x50000000 0x00136022 0x00020000 && tftpput 0x50000000 0x04000000 mmcblk0p26_swap2.bin
mmc read 0x50000000 0x00156022 0x00020000 && tftpput 0x50000000 0x04000000 mmcblk0p26_swap3.bin
mmc read 0x50000000 0x00176022 0x00020000 && tftpput 0x50000000 0x04000000 mmcblk0p26_swap4.bin
mmc read 0x50000000 0x00196022 0x00020000 && tftpput 0x50000000 0x04000000 mmcblk0p26_swap5.bin
mmc read 0x50000000 0x001b6022 0x00020000 && tftpput 0x50000000 0x04000000 mmcblk0p26_swap6.bin
mmc read 0x50000000 0x001d6022 0x00020000 && tftpput 0x50000000 0x04000000 mmcblk0p26_swap7.bin
mmc read 0x50000000 0x001f6022 0x00020000 && tftpput 0x50000000 0x04000000 mmcblk0p26_swap8.bin

# flashing uboot
tftpboot uboot-JDC_AX1800_Pro-AX6600_Athena-20240510.bin && flash 0:APPSBL && flash 0:APPSBL_1

mmc read 0x50000000 0x00003422 0x500 && crc32 0x50000000 0xA0000
## MMC read: dev # 0, block # 13346, count 1280 ... 1280 blocks read: OK
## crc32 for 50000000 ... 5009ffff ==> 3ab2f8a6
mmc read 0x51000000 0x00003922 0x500 && crc32 0x51000000 0xA0000
## MMC read: dev # 0, block # 14626, count 1280 ... 1280 blocks read: OK
## crc32 for 51000000 ... 5109ffff ==> 3ab2f8a6

# flashing gpt
tftpboot gpt-JDC_AX1800_Pro_dual-boot_rootfs2048M_no-last-partition.bin && mmc write $fileaddr 0x0 0x22

# Verifying hash
mmc read 0x50000000 0x0 0x22 && && crc32 0x50000000 0x4400
## MMC read: dev # 0, block # 0, count 34 ... 34 blocks read: OK
## crc32 for 50000000 ... 500043ff ==> be66a69f
```

Back to PC, change the IP from `192.168.10.1/24` to `192.168.1.10/24`
Hole reset button(near the power slot), and wait the led turn into blue

Access `192.168.1.1` at browser, upload the frimware
```
QWRT-R24.05.05-ipq60xx-generic-jdcloud_ax1800-pro-squashfs-factory.bin
```

create partition mmcblk0p27 and format it
```
fdisk -l # Get the GPT GUID

opkg update && opkg install sgdisk
sgdisk -e -n 0:0:0 -c 0:storage -t 0:98101B32-BBE2-4BF2-A06E-2BB33D000C20 -p /dev/mmcblk0
mkfs.ext4 -E nodiscard -F /dev/mmcblk0p27
```
