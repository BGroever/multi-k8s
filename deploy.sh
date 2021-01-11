docker build -t bengroever/multi-client:latest -t bengroever/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t bengroever/multi-server:latest -t bengroever/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t bengroever/multi-worker:latest -t bengroever/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push bengroever/multi-client:latest
docker push bengroever/multi-server:latest
docker push bengroever/multi-worker:latest

docker push bengroever/multi-client:$SHA
docker push bengroever/multi-server:$SHA
docker push bengroever/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/client-deployment client=bengroever/multi-client:$SHA
kubectl set image deployments/server-deployment server=bengroever/multi-server:$SHA
kubectl set image deployments/worker-deployment worker=bengroever/multi-worker:$SHA


