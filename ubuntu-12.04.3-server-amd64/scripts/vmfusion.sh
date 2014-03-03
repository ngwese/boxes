mkdir -p /mnt/cdrom
mount -o loop /tmp/vmware-tools.iso /mnt/cdrom
tar zxf /mnt/cdrom/VMwareTools-*.tar.gz -C /tmp/

# hack to get around build failure
# http://askubuntu.com/questions/131351/how-to-install-vmware-tools
# http://nemgeek.blogspot.com/2013/09/vmware-tools-annoyances.html
# http://philbayfield.com/2013/05/21/patching-vmware-tools-to-fix-multiple-installation-errors-on-ubuntu-13-04/
ln -s /usr/src/linux-headers-$(uname -r)/include/generated/uapi/linux/version.h /usr/src/linux-headers-$(uname -r)/include/linux/version.h

cd /tmp/vmware-tools-distrib
wget http://blog.gnu-designs.com/downloads/vmware-tools-linux-kernel-3.8_vmci_pci_hotplug_struct.patch
tar -xvf lib/modules/source/vmci.tar
patch -p0 < vmware-tools-linux-kernel-3.8_vmci_pci_hotplug_struct.patch
tar -cf vmci.tar vmci-only/
cp vmci.tar lib/modules/source/

wget http://cdn.philbayfield.com/downloads/vmware-vmhgfs.patch
tar -xvf lib/modules/source/vmhgfs.tar
cd vmhgfs-only/shared/
patch -p1 < /tmp/vmware-tools-distrib/vmware-vmhgfs.patch
cd ../../
tar cf vmhgfs.tar vmhgfs-only/
cp vmhgfs.tar lib/modules/source/


/tmp/vmware-tools-distrib/vmware-install.pl -d
rm /tmp/vmware-tools.iso
umount /mnt/cdrom
