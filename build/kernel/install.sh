#!/sbin/sh

fstrim -v /cache
fstrim -v /data

dd if=/dev/block/bootdevice/by-name/boot of=/tmp/boot.img
/tmp/unpackbootimg -i /tmp/boot.img -o /tmp/

mkdir /tmp/ramdisk
cp /tmp/boot.img-ramdisk.gz /tmp/ramdisk/
cd /tmp/ramdisk/
gunzip -c /tmp/ramdisk/boot.img-ramdisk.gz | cpio -i
rm /tmp/boot.img-ramdisk.gz
rm /tmp/ramdisk/boot.img-ramdisk.gz
rm /tmp/ramdisk/init.blu_spark.rc

if ! grep -q 'bg_apps' /tmp/ramdisk/default.prop; then
   echo "ro.vendor.qti.sys.fw.bg_apps_limit=60" >> /tmp/ramdisk/default.prop
   echo "ro.vendor.qti.config.swap=false" >> /tmp/ramdisk/default.prop
   echo "ro.vendor.qti.config.zram=false" >> /tmp/ramdisk/default.prop
fi;

find . | cpio -o -H newc | gzip > /tmp/boot.img-ramdisk.gz
rm -r /tmp/ramdisk

/tmp/mkbootimg --kernel /tmp/Image.gz-dtb --ramdisk /tmp/boot.img-ramdisk.gz --cmdline "$(cat /tmp/boot.img-cmdline)" --base 0x80000000 --pagesize 4096 --ramdisk_offset 0x01000000 --tags_offset 0x00000100 -o /tmp/newboot.img
dd if=/tmp/newboot.img of=/dev/block/bootdevice/by-name/boot
