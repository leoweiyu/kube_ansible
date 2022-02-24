# Kube_ansible
![](https://assets.website-files.com/610cc7a5a58576a806711235/61371028773d7e7f92976edc_60884e8987a12fc2eda2f50b_logo_cka_whitetext-2.png)
The purpose of this repo is to setup a fully functional kubernetes cluster easily with Ansible (within 30-60mins time, including environment prepairation)
so that you can prepair you CKA/CKS exam locally using VMs (either VirtualBox/Vmware.. etc) instead of buying a environment.

## NOTE:
Do NOT update to 1.23.4 if you are using Calico CNI , p2p traffic will fail which throw the following error message, and the fix might be shipped until Calico:v3.22.1
```
ipset v7.1: Kernel and userspace incompatible: settype hash:ip,port with revision 6 not supported by userspace
```

## features:
1. HA (keepalived and haproxy)
2. Allows you to specify CNI, either Calico CNI or Flannel (use Calico if you want to play with NetworkPolicies)
3. Allows you to specify controller plugins
4. Allow you to specify container runtime (Docker/Containerd)
5. Allow to you setup a fully functional k8s cluster without having in depth knowledge of kubernetes


## prerequisites:


a) **3+ ubuntu 18/20 servers, with proper ip/hostname configured**
for example
```
hostnamectl set-hostname xansible1.192.168.1.171.nip.io
hostnamectl set-hostname xansible2.192.168.1.172.nip.io
hostnamectl set-hostname xansible3.192.168.1.173.nip.io
hostnamectl set-hostname xansible4.192.168.1.174.nip.io
```

b) **upgrade all servers before proceed**
```
apt update
apt upgrade
```

c) **setup hostname in /etc/hosts file**
```
192.168.1.171    xansible1.192.168.1.171.nip.io
192.168.1.172    xansible1.192.168.1.171.nip.io
192.168.1.173    xansible1.192.168.1.171.nip.io
192.168.1.174    xansible1.192.168.1.171.nip.io
```

d) **permit root ssh login**
on all servers, sudo to root and change the default password to whatever you want
```
passwd
```
edit file /etc/ssh/sshd_config, search for PermitRootLogin and change it to
```
PermitRootLogin yes
```
restart sshd server
```
systemctl restart ssh.service
```

e) **setup password free login for api server 1 onto all other servers**
on api server1 (xansible1.192.168.1.171.nip.io for example)
```
ssh-keygen
ssh-copy-id root@xansible1.192.168.1.171.nip.io
ssh-copy-id root@xansible2.192.168.1.172.nip.io
ssh-copy-id root@xansible3.192.168.1.173.nip.io
ssh-copy-id root@xansible4.192.168.1.174.nip.io
```

f) **install python3 and pip3 on api server 1 (xansible1.192.168.1.171.nip.io for example)**
```
apt-get install python3 python3-pip
```

g) **make sure you have python3 installed on api server 1 (xansible1.192.168.1.171.nip.io for example)**
```
apt install software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt install ansible python3-pip
```



## how to use ?
**you will need to git clone this repo**

```
git clone git@github.com:leoweiyu/kube_ansible.git
```

**install requirements for this playbook**
```
pip install -r kube_ansible/requirement.yaml
```

**examine kube_ansible/vars/main.yaml and making changes base on your environment and requirement**

**examine kube_ansible/inventory.yaml and making changes base on your environment and requirement**

**once you made above change, you can now draf a play book file (leo-kube-playbook.yaml for example) something like following**
```
- hosts: all
  remote_user: root
  roles:
    - kube_ansible
  vars_files:
    - kube_ansible/vars/main.yaml
```

**you can now run following command to install your cluster**
```
ansible-playbook -i kube_ansible/inventory.yaml leo-kube-playbook.yaml
```

