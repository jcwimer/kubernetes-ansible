#!/bin/bash 

# https://blog.heptio.com/on-securing-the-kubernetes-dashboard-16b09b1b7aca
# kubectl -n kube-system edit service kubernetes-dashboard

# Change dashboard to node port
kubectl -n kube-system get service kubernetes-dashboard -o yaml | \
  sed 's/type: ClusterIP/type: NodePort/g' | \
  kubectl apply -f -

# Create the service account in the current namespace 
# (we assume default)
kubectl create serviceaccount my-dashboard-sa

# Give that service account root on the cluster
kubectl create clusterrolebinding my-dashboard-sa \
  --clusterrole=cluster-admin \
  --serviceaccount=default:my-dashboard-sa

# Get secret token
kubectl describe secret $(kubectl get secret | grep my-dashboard-sa | awk '{print $1}') | grep 'token:' | awk {'print $2'}
