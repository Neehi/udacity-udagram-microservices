kubectl delete secret aws-secret --ignore-not-found=true
kubectl delete secret env-secret --ignore-not-found=true
kubectl delete configmap env-config --ignore-not-found=true

# aws-secret
echo ${AWS_CREDENTIALS} | base64 --decode - > ./credentials.txt
kubectl create secret generic aws-secret \
--from-file=credentials=./credentials.txt \
--dry-run -o yaml
# | kubectl apply -f -

# env-secret
kubectl create secret generic env-secret \
--from-literal=POSTGRESS_USERNAME=${POSTGRESS_USERNAME} \
--from-literal=POSTGRESS_PASSWORD=${POSTGRESS_PASSWORD} \
--dry-run -o yaml
# | kubectl apply -f -

# env-config
kubectl create configmap env-config \
--from-literal=AWS_BUCKET=${AWS_BUCKET} \
--from-literal=AWS_PROFILE=${AWS_PROFILE} \
--from-literal=AWS_REGION=${AWS_REGION} \
--from-literal=JWT_SECRET=${JWT_SECRET} \
--from-literal=POSTGRESS_DB=${POSTGRESS_DB} \
--from-literal=POSTGRESS_HOST=${POSTGRESS_HOST} \
--from-literal=URL=http://localhost:8100 \
--dry-run -o yaml
# | kubectl apply -f -

# # deployments
# kubectl apply -f backend-feed-deployment.yaml -f backend-user-deployment.yaml -f frontend-deployment.yaml -f reverseproxy-deployment.yaml

# # services
# kubectl apply -f backend-feed-service.yaml -f backend-user-service.yaml -f frontend-service.yaml -f reverseproxy-service.yaml
