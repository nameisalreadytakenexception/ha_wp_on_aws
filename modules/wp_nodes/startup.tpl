#!/bin/bash
echo "userdata-start"
sudo apt update -y
sudo apt install -y apache2 nfs-common
MOUNT_LOCATION="/var/www/html"
MOUNT_TARGET=${mount_target}
sudo mkdir -p /var/www/html
sudo mount \
    -t nfs4 \
    -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2 \
    $MOUNT_TARGET:/ $MOUNT_LOCATION
echo $MOUNT_TARGET:/ /var/www/html nfs4 defaults,_netdev 0 0  | sudo cat >> /etc/fstab
sudo chmod go+rw /var/www/html
sudo systemctl start apache2
sudo systemctl enable apache2
# echo "<h1>Deployed via Terraform</h1>" | sudo tee /var/www/html/index.html
sudo echo "<h1>Deployed via Terraform!!!</h1>" > /var/www/html/index.html
echo "userdata-end"