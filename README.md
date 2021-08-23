# Kube_ansible

The purpose of this repo is to setup a fully functioning kubernetes cluster easily with Ansible (within 5-10mins time)

features:
1. HA (keepalived and haproxy)
2. Calico CNI
3. Allows you to specify controller plugins
4. Allow you to specify container runtime


# prerequisites:
a) 3+ ubuntu 18/20 servers, with proper ip/hostname configured

b) have keybased ssh connection configured from the master 0 server to all other servers

c) make sure you have python3 installed on server master 0

d) make sure you have ansible installed on server master 0



## how to use ?
you will need to git clone this repo

```
pip install -r kube_ansible/requirement.yaml
```


examine kube_ansible/vars/main.yaml and making changes base on your situation

examine kube_ansible/inventory.yaml and making changes base on your situation

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

