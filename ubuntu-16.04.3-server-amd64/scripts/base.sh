
# Apt-install various things necessary for Ruby, guest additions,
# etc., and remove optional things to trim down the machine.
apt-get -y update
apt-get -y dist-upgrade
apt-get -y install curl nfs-common
