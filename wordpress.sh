kubectl run wordpress --image=tutum/wordpress --port=80
wordpress_pod=$(kubectl get pods | grep wordpress | awk {'print $1'})
kubectl expose pod ${wordpress_pod} --name=wordpress --type=NodePort
