docker build -t sasimadnava/multi-client:latest -t sasimandava/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t sasimandava/multi-server:latest -t sasimandava/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t sasimandava/multi-worker:latest -t sasimandava/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push sasimandava/multi-client:latest
docker push sasimandava/multi-server:latest
docker push sasimandava/multi-worker:latest

docker push sasimandava/multi-client:$SHA
docker push sasimandava/multi-server:$SHA
docker push sasimandava/multi-worker:$SHA

kubectl apply -f k8s_config
kubectl set image deployments/server-deployment server=sasimandava/multi-server:$SHA
kubectl set image deployments/client-deployment client=sasimandava/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=sasimandava/multi-worker:$SHA
