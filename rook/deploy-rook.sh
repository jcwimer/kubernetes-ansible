kubectl apply -f operator.yaml
sleep 30s
kubectl apply -f cluster.yaml
sleep 60s
echo kubectl apply -f storageclass.yaml
kubectl apply -f dashboard-external.yaml
