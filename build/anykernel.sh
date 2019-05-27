# AnyKernel2 Ramdisk Mod Script
# osm0sis @ xda-developers
# blu_spark changes by eng.stk

## AnyKernel setup
# begin properties
properties() { '
kernel.string=### HolyDragon Kernel for OnePlus 3/3T ###
do.devicecheck=1
do.modules=0
do.cleanup=1
do.cleanuponabort=0
device.name1=OnePlus3
device.name2=oneplus3
device.name3=OnePlus3T
device.name4=oneplus3t
'; } # end properties

# shell variables
block=boot;
is_slot_device=0;
ramdisk_compression=auto;

## AnyKernel methods (DO NOT CHANGE)
# import patching functions/variables - see for reference
. /tmp/anykernel/tools/ak2-core.sh;

## Trim partitions
fstrim -v /cache;
fstrim -v /data;

## AnyKernel file attributes
# set permissions/ownership for included ramdisk files
chmod -R 750 $ramdisk/*;
chown -R root:root $ramdisk/*;

## AnyKernel install
dump_boot;
# begin ramdisk changes
if [ -d $ramdisk/.backup ]; then
  patch_cmdline "skip_override" "skip_override";
else
  patch_cmdline "skip_override" "";
fi;
# end ramdisk changes
write_boot;

## end install

