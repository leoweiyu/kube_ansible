# Kube_ansible

The purpose of this repo is to setup test kubernetes cluster easily with Ansible

## how to use ?
you will need to git clone this repo

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

