docker build -t jmahumada/multi_client:latest -t jmahumada/multi_client:$SHA -f ./client/Dockerfile ./client
docker build -t jmahumada/multi_api:latest -t jmahumada/multi_api:$SHA -f ./api/Dockerfile ./api
docker build -t jmahumada/multi_worker:latest -t jmahumada/multi_worker:$SHA -f ./worker/Dockerfile ./worker

docker push jmahumada/multi_client:latest
docker push jmahumada/multi_api:latest
docker push jmahumada/multi_worker:latest

docker push jmahumada/multi_client:$SHA
docker push jmahumada/multi_api:$SHA
docker push jmahumada/multi_worker:$SHA

kubectl apply -f k8s

kubectl set image deployments/multi-client-deployment client=jmahumada/multi_client:$SHA
kubectl set image deployments/multi-server-deployment server=jmahumada/multi_api:$SHA
kubectl set image deployments/multi-worker-deployment worker=jmahumada/multi_worker:$SHA