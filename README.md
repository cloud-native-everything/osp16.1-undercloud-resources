# osp16.1-undercloud-resources
You can get XML KVM instances files, configuration files (i.e. yaml) and other used on the different posts in the blog site
Check my post "Director OSP 16.1 install short version" at  https://www.cloud-native-everything.com/director-osp-16-…ll-short-version

## overview
Red Hat have been pushing its automated installation of OpenStack with Director based on TripleO concept over the last years. Many Telcos are adopting this concept for the flexibility and agility that automation brings. This is a sort of summary of what I did in my lab installing director and can help you out as a reference for your installation.
TripleO is an OpenStack project that aims to utilize OpenStack itself as the foundations for deploying OpenStack. To clarify, TripleO advocates the use of native OpenStack components, and their respective API’s to configure, deploy, and manage OpenStack environments itself. Undercloud is the OpenStack component that install the actual OpenStack called Overcloud. Containers are also a key component of this architecture.

I have also uploaded my ansible.og (https://github.com/cloud-native-everything/osp16.1-undercloud-resources/blob/main/ansible.log) file when I got an issue to authenticate to the image repo. Check the last part of the blog post for the solution.

See ya!
