kubectl apply -f operator.yaml
sleep 30s
kubectl apply -f cluster.yaml
sleep 60s
kubectl apply -f dashboard-external.yaml
echo kubectl apply -f storageclass.yaml