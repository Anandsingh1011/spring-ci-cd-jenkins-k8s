pipeline {

  environment {
    PROJECT = "kf-gcp12449"
    APP_NAME = "gceme"
    FE_SVC_NAME = "${APP_NAME}-frontend"
    CLUSTER = "jenkins-cd"
    CLUSTER_ZONE = "us-east1-d"
    IMAGE_TAG = "gcr.io/${PROJECT}/${APP_NAME}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"
    JENKINS_CRED = "${PROJECT}"
  }

  agent any
  
  stages {
    stage('Checkout') {
      echo 'Checkout application...'
    }
    stage('Test ') {
      echo 'Test application...'
    }
    stage('Build ') {
      echo 'Build application...'
    }
    
    stage('push image') {
      echo 'Push application image...'
    }
  }
}
