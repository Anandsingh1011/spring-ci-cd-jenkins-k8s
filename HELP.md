#!/bin/bash
version=`date +%y-%m-%d-%H-%M-%S`

echo "$version"





mvn clean install

echo "============> Create Docker Image backend <============"
docker build --tag spring-ci-cd-jenkins-k8s:1 .
docker tag spring-ci-cd-jenkins-k8s:1 gcr.io/kf-gcp12449/spring-ci-cd-jenkins-k8s:1
docker push gcr.io/kf-gcp12449/spring-ci-cd-jenkins-k8s:1


# kubectl apply -f portal-backend-deployment.yaml

kubectl delete -f portal-backend-deployment.yaml

cat portal-backend-deployment.yaml  | sed "s/{{version}}/$version/g" | kubectl apply -f -




