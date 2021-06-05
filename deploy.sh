docker build -t shubhjha/multi-client-k8s:latest -t shubhjha/multi-client-k8s:$SHA -f ./client/Dockerfile ./client
docker build -t shubhjha/multi-server-k8s-pgfix:latest -t shubhjha/multi-server-k8s-pgfix:$SHA -f ./server/Dockerfile ./server
docker build -t shubhjha/multi-worker-k8s:latest -t shubhjha/multi-worker-k8s:$SHA -f ./worker/Dockerfile ./worker

docker push shubhjha/multi-client-k8s:latest
docker push shubhjha/multi-server-k8s-pgfix:latest
docker push shubhjha/multi-worker-k8s:latest

docker push shubhjha/multi-client-k8s:$SHA
docker push shubhjha/multi-server-k8s-pgfix:$SHA
docker push shubhjha/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=shubhjha/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=shubhjha/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=shubhjha/multi-worker-k8s:$SHA