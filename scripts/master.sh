#!/bin/bash
#
# Setup for Control Plane (Master) servers

set -euxo pipefail

# Change this if you want external access to API server
PUBLIC_IP_ACCESS="false"
NODENAME=$(hostname -s)
POD_CIDR="192.168.0.0/16"

# Pull required images
sudo kubeadm config images pull

# Initialize kubeadm based on PUBLIC_IP_ACCESS
if [[ "$PUBLIC_IP_ACCESS" == "false" ]]; then
    MASTER_PRIVATE_IP=$(hostname -I | awk '{print $1}')
    sudo kubeadm init \
      --apiserver-advertise-address="$MASTER_PRIVATE_IP" \
      --apiserver-cert-extra-sans="$MASTER_PRIVATE_IP" \
      --pod-network-cidr="$POD_CIDR" \
      --node-name "$NODENAME" \
      --ignore-preflight-errors Swap

elif [[ "$PUBLIC_IP_ACCESS" == "true" ]]; then
    MASTER_PUBLIC_IP=$(curl -s ifconfig.me)
    sudo kubeadm init \
      --control-plane-endpoint="$MASTER_PUBLIC_IP" \
      --apiserver-cert-extra-sans="$MASTER_PUBLIC_IP" \
      --pod-network-cidr="$POD_CIDR" \
      --node-name "$NODENAME" \
      --ignore-preflight-errors Swap
else
    echo "Error: PUBLIC_IP_ACCESS has an invalid value: $PUBLIC_IP_ACCESS"
    exit 1
fi

# Configure kubeconfig
mkdir -p "$HOME/.kube"
sudo cp -i /etc/kubernetes/admin.conf "$HOME/.kube/config"
sudo chown "$(id -u)":"$(id -g)" "$HOME/.kube/config"

# Install Calico CNI plugin
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.27.2/manifests/calico.yaml
