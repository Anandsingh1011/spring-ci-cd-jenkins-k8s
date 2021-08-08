pipeline {

  environment {
    PROJECT = "kf-gcp12449"
    APP_NAME = "spring-ci-cd-jenkins-k8s"
    FE_SVC_NAME = "${APP_NAME}-frontend"
    CLUSTER = "jenkins-cd"
    CLUSTER_ZONE = "us-east1-d"
    IMAGE_TAG = "gcr.io/${PROJECT}/${APP_NAME}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"
    JENKINS_CRED = "${PROJECT}"
  }

  agent {
    kubernetes {
      label 'pring-ci-cd-jenkins-k8s'
      defaultContainer 'jnlp'
      yaml """
apiVersion: v1
kind: Pod
metadata:
labels:
  component: ci
spec:
  # Use service account that can deploy to all namespaces
  serviceAccountName: cd-jenkins
  containers:
  - name: golang
    image: golang:1.10
    command:
    - cat
    tty: true
  - name: openjdk
    image: openjdk:11
    command:
    - cat
    tty: true
  - name: gcloud
    image: gcr.io/cloud-builders/gcloud
    command:
    - cat
    tty: true
  - name: docker
    image: gcr.io/cloud-builders/docker
    command:
    - cat
    tty: true
  - name: kubectl
    image: gcr.io/cloud-builders/kubectl
    command:
    - cat
    tty: true
"""
}
  }
    
  tools {
        maven 'Maven 3.5.0'
   }
  
  stages {
    stage ('Initialize') {
            steps {
                sh '''
                    echo "PATH = ${PATH}"
                    echo "M2_HOME = ${M2_HOME}"
                '''
            }
    }
    stage('Build and push image with Container Builder') {
      steps {
        container('gcloud') {
          sh "PYTHONUNBUFFERED=1 gcloud builds submit -t ${IMAGE_TAG} ."
        }
      }
    }
    stage("build") {
            steps {
                echo 'build application...'
                sh 'mvn -Dmaven.test.failure.ignore=true install'
            }
    }
    stage("test") {
            steps {
                echo 'build image ...'
                sh 'docker build --tag spring-ci-cd-jenkins-k8s:1 .'
            }
    }
    stage("deploy") {
            steps {
                echo 'deploy application...'
            }
    }
  }
}
