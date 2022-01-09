# Kube_ansible

The purpose of this repo is to setup a fully functional kubernetes cluster easily with Ansible (within 30-60mins time, including environment prepairation)

## features:
1. HA (keepalived and haproxy)
2. Allows you to specify CNI, either Calico CNI or Flannel (use Calico if you want to play with NetworkPolicies)
3. Allows you to specify controller plugins
4. Allow you to specify container runtime (Docker/Containerd)


## prerequisites:


a) 3+ ubuntu 18/20 servers, with proper ip/hostname configured
for example
```
hostnamectl set-hostname xansible1.192.168.1.171.nip.io
hostnamectl set-hostname xansible2.192.168.1.172.nip.io
hostnamectl set-hostname xansible3.192.168.1.173.nip.io
hostnamectl set-hostname xansible4.192.168.1.174.nip.io
```

b) upgrade all servers before proceed
```
apt update
apt upgrade
```

c) setup hostname in /etc/hosts file
```
192.168.1.171    xansible1.192.168.1.171.nip.io
192.168.1.172    xansible1.192.168.1.171.nip.io
192.168.1.173    xansible1.192.168.1.171.nip.io
192.168.1.174    xansible1.192.168.1.171.nip.io
```

d) permit root ssh login
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

e) setup password free login for api server 1 onto all other servers
on api server1 (xansible1.192.168.1.171.nip.io for example)
```
ssh-keygen
ssh-copy-id root@xansible1.192.168.1.171.nip.io
ssh-copy-id root@xansible2.192.168.1.172.nip.io
ssh-copy-id root@xansible3.192.168.1.173.nip.io
ssh-copy-id root@xansible4.192.168.1.174.nip.io
```

f) install python3 and pip3 on api server 1 (xansible1.192.168.1.171.nip.io for example)
```
apt-get install python3 python3-pip
```

g) make sure you have python3 installed on api server 1 (xansible1.192.168.1.171.nip.io for example)
```
apt install software-properties-common
apt-add-repository --yes --update ppa:ansible/ansible
apt install ansible python3-pip
```



## how to use ?
you will need to git clone this repo

```
git clone git@github.com:leoweiyu/kube_ansible.git
pip install -r kube_ansible/requirement.yaml
```


examine kube_ansible/vars/main.yaml and making changes base on your environment and requirement

examine kube_ansible/inventory.yaml and making changes base on your environment and requirement

once you made above change, you can now draf a play book file (leo-kube-playbook.yaml for example) something like following
```
- hosts: all
  remote_user: root
  roles:
    - kube_ansible
  vars_files:
    - kube_ansible/vars/main.yaml
```
you can now run following command to install your cluster
```
ansible-playbook -i kube_ansible/inventory.yaml leo-kube-playbook.yaml
```

