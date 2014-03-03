# install needed tools
yum -y install gcc make kernel-devel perl fuse-libs

# mount the iso uploaded and unpack
mkdir -pv /mnt/iso
mount /tmp/vmware-tools.iso /mnt/iso -t iso9660 -o ro,loop=/dev/loop0
tar zxf /mnt/iso/VMwareTools*.tar.gz -C /tmp
umount /mnt/iso

# perform install
/tmp/vmware-tools-distrib/vmware-install.pl --default

# cleanup
rm -rf /tmp/vmware-*
yum -y erase gcc make kernel-devel perl
# explicitly leave fuse-libs install, vmware block device needs it

