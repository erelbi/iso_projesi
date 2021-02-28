#!/bin/bash
rm -rf  deneme.iso
cp preseed.cfg  initrdfiles/
echo "#### yeni init oluşturuluyor###"
cd initrdfiles/ 
find . | cpio --create --format='newc' > ../initrdnew
cd ..
echo "##oluşturuldu##"
gzip initrdnew

echo "#iso ayarı#"
chmod -R +w  change-iso/install/
rm -rf change-iso/install/initrd.gz
echo "#eski init silindi#"
mv initrdnew.gz change-iso/install/initrd.gz
chmod -R -w  change-iso/install/
cd change-iso/
find -follow -type f ! -name change-iso/md5sum.txt  -print0 | xargs -0 md5sum > md5sum.txt
echo "#değişikler tamam#"

echo "


       Başlıyor



"

xorriso -as mkisofs -R -r -J -joliet-long -l -cache-inodes -iso-level 4 -isohybrid-mbr /usr/lib/ISOLINUX/isohdpfx.bin -partition_offset 16 -A Pardus -p live-build  -publisher Pardus -V "Pardus"  -b isolinux/isolinux.bin -c isolinux/boot.cat -no-emul-boot -boot-load-size 4 -boot-info-table -eltorito-alt-boot -e boot/grub/efi.img -no-emul-boot -isohybrid-gpt-basdat -isohybrid-apm-hfsplus -o ../deneme.iso .

