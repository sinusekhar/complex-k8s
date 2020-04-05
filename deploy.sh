docker build -t sinusekhar/multi-client:latest -t sinusekhar/multi-client:$GIT_SHA -f ./client/Dockerfile ./client
docker build -t sinusekhar/multi-server:latest -t sinusekhar/multi-server:$GIT_SHA -f ./server/Dockerfile ./server
docker build -t sinusekhar/multi-worker:latest -t sinusekhar/multi-worker:$GIT_SHA -f ./worker/Dockerfile ./worker

docker push sinusekhar/multi-client:latest
docker push sinusekhar/multi-server:latest
docker push sinusekhar/multi-worker:latest
docker push sinusekhar/multi-client:$GIT_SHA
docker push sinusekhar/multi-server:$GIT_SHA
docker push sinusekhar/multi-worker:$GIT_SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=sinusekhar/multi-server:$GIT_SHA
kubectl set image deployments/client-deployment client=sinusekhar/multi-client:$GIT_SHA
kubectl set image deployments/worker-deployment worker=sinusekhar/multi-worker:$GIT_SHA
