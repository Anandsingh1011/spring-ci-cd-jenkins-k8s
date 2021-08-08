FROM openjdk:8-jdk-alpine


ADD target/spring-ci-cd-jenkins-k8s-0.0.1-SNAPSHOT.jar spring-ci-cd-jenkins-k8s-0.0.1-SNAPSHOT.jar

ENTRYPOINT ["java","-jar","spring-ci-cd-jenkins-k8s-0.0.1-SNAPSHOT.jar"]

