#!/bin/bash

# Create master VM
multipass launch ubuntu --name k8s-master --cpus 2 --mem 2G --disk 8G

# Install microk8s
multipass exec k8s-master -- bash -c 'sudo apt-get update | sudo apt-get upgrade -y'
multipass exec k8s-master -- bash -c 'sudo snap install microk8s --classic --channel=1.21'
multipass exec k8s-master -- bash -c 'mkdir ~/.kube'
multipass exec k8s-master -- bash -c 'sudo usermod -a -G microk8s $USER'
multipass exec k8s-master -- bash -c 'microk8s status --wait-ready'
multipass exec k8s-master -- bash -c 'microk8s config > ~/.kube/config'
multipass exec k8s-master -- bash -c 'sudo chown -f -R $USER ~/.kube'
mkdir -p ~/.kube 
multipass exec k8s-master -- bash -c 'cat ~/.kube/config' > ~/.kube/config