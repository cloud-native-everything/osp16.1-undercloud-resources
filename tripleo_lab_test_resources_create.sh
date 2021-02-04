# Prepare env to play

## Create projects

for i in texas california florida; do openstack project create $i-project  --quiet ; done
openstack user create tmobile  --password tmobile
for i in texas california florida; do openstack user set tmobile --project $i-project ; done
for i in texas california florida; do openstack role add --user tmobile --project $i-project admin; done


## Creating routers (layer3 domains)
for i in texas california florida; do openstack router create $i-router --project $i-project --quiet ; done

## Creating networks and subnets
for i in dallas houston austin; do openstack network create $i-net  --project texas-project --quiet ; done
for i in dallas houston austin; do openstack subnet create --network $i-net --subnet-range `printf "172.16.%d.1/24" "'$i"` $i-subnet --project texas-project --quiet; done
for i in destin orlando; do openstack network create $i-net --project florida-project --quiet; done
for i in destin orlando; do openstack subnet create --network $i-net --subnet-range `printf "172.16.%d.1/24" "'$i"` $i-subnet  --project florida-project --quiet; done
for i in sacramento mountainview; do openstack network create $i-net  --project california-project --quiet; done
for i in sacramento mountainview; do openstack subnet create --network $i-net --subnet-range `printf "172.16.%d.1/24" "'$i"` $i-subnet  --project california-project  --quiet; done

## Attach networks to routers
for i in dallas houston austin; do openstack router add subnet texas-router $i-subnet  ; done
for i in destin orlando; do openstack router add subnet florida-router $i-subnet ; done
for i in sacramento mountainview; do openstack router add subnet california-router $i-subnet ; done

## Create ports
for i in dallas houston ; do for j in 0 1 ; do openstack port create --network $i-net $i-port$j --project texas-project; done; done
for i in destin orlando; do for j in 0 1 ; do openstack port create --network $i-net $i-port$j --project florida-project; done; done
for i in sacramento mountainview; do for j in 0 1 ; do openstack port create --network $i-net $i-port$j --project california-project; done; done


## Create servers
source tmobilerc
for i in dallas houston ; do for j in 0 1 ; do OS_PROJECT_NAME=texas-project; openstack server create --image CentOS-7-nuagenet --flavor small-1 --port $i-port$j $i-centos-vm$j --availability-zone nova:overcloud-novacompute-$j.localdomain ; done; done
for i in destin orlando ; do for j in 0 1 ; do OS_PROJECT_NAME=florida-project; openstack server create --image CentOS-7-nuagenet --flavor small-1 --port $i-port$j $i-centos-vm$j --availability-zone nova:overcloud-novacompute-$j.localdomain ; done; done
for i in sacramento mountainview ; do for j in 0 1 ; do OS_PROJECT_NAME=california-project; openstack server create --image CentOS-7-nuagenet --flavor small-1 --port $i-port$j $i-centos-vm$j --availability-zone nova:overcloud-novacompute-$j.localdomain ; done; done

## Security groups
source overcloudrc
for i in texas california florida; do openstack security group create $i-sg --project $i-project ; done
for i in texas california florida; do for j in `openstack security group rule list $i-sg | awk '/([A-Fa-f0-9]+-){3}/ {print $2}'`; do openstack security group rule delete $j; done; done
for i in texas california florida; do openstack security group rule create $i-sg --protocol tcp --dst-port 80:80 --remote-ip 0.0.0.0/0; done
openstack server add security group dallas-centos-vm0 texas-sg
openstack server add security group destin-centos-vm0 florida-sg


## Prepare images
#wget https://cloud.centos.org/centos/7/images/CentOS-7-x86_64-GenericCloud.qcow2 -o CentOS-7-x86_64-GenericCloud.qcow2
#openstack image create --file CentOS-7-x86_64-GenericCloud.qcow2 --public CentOS-7-x86_64-GenericCloud


## Start a http service with python:
## python -m SimpleHTTPServer 80 &
