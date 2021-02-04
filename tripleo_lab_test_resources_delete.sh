## Delete lab resources


## Delete security groups, rules and remove servers from those
source tmobilerc
OS_PROJECT_NAME=texas-project; openstack server remove security group dallas-centos-vm0 texas-sg
OS_PROJECT_NAME=florida-project; openstack server remove security group destin-centos-vm0 florida-sg
for i in texas california florida; do openstack security group delete $i-sg ; done

## Delete servers

for i in dallas houston ; do for j in 0 1 ; do openstack server delete $i-centos-vm$j ; done; done
OS_PROJECT_NAME=florida-project; for i in destin orlando ; do for j in 0 1 ; do openstack server delete $i-centos-vm$j ; done; done
OS_PROJECT_NAME=california-project; for i in sacramento mountainview ; do for j in 0 1 ; do openstack server delete $i-centos-vm$j ; done; done


## Delete ports
source overcloudrc
for i in dallas houston ; do for j in 0 1 ; do openstack port delete $i-port$j; done; done
for i in destin orlando; do for j in 0 1 ; do openstack port delete $i-port$j; done; done
for i in sacramento mountainview; do for j in 0 1 ; do openstack port delete $i-port$j; done; done


## Remove networks from routers
for i in dallas houston austin; do openstack router remove subnet texas-router $i-subnet ; done
for i in destin orlando; do openstack router remove subnet florida-router $i-subnet ; done
for i in sacramento mountainview; do openstack router remove subnet california-router $i-subnet ; done

## Delete networks and subnets
for i in dallas houston austin; do openstack subnet delete $i-subnet --quiet; done
for i in dallas houston austin; do openstack network delete $i-net --quiet ; done
for i in destin orlando; do openstack subnet delete $i-subnet --quiet; done
for i in destin orlando; do openstack network delete $i-net --quiet; done
for i in sacramento mountainview; do openstack subnet delete $i-subnet --quiet; done
for i in sacramento mountainview; do openstack network delete $i-net --quiet; done

## Delete router routers (layer3 domains)
for i in texas california florida; do openstack router delete $i-router --quiet ; done

## Delete user
openstack user delete tmobile

## Delete projects
for i in texas california florida; do openstack project delete $i-project  --quiet ; done
