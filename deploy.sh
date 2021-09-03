docker build -t odisseuss/multi-client-k8s:latest -f ./client/Dockerfile ./client
docker build -t odisseuss/multi-server-k8s-pgfix:latest -f ./server/Dockerfile ./server
docker build -t odisseuss/multi-worker-k8s:latest -f ./worker/Dockerfile ./worker

docker push odisseuss/multi-client-k8s:latest
docker push odisseuss/multi-server-k8s-pgfix:latest
docker push odisseuss/multi-worker-k8s:latest

docker push odisseuss/multi-client-k8s:$SHA
docker push odisseuss/multi-server-k8s-pgfix:$SHA
docker push odisseuss/multi-worker-k8s:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=odisseuss/multi-server-k8s-pgfix:$SHA
kubectl set image deployments/client-deployment client=odisseuss/multi-client-k8s:$SHA
kubectl set image deployments/worker-deployment worker=odisseuss/multi-worker-k8s:$SHA