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
    stage("init") {
            steps {
                echo 'Checkout application...'
            }
    }
    stage("build") {
            steps {
                echo 'build application...'
                sh 'mvn clean install'
            }
    }
    stage("test") {
            steps {
                echo 'test application...'
            }
    }
    stage("deploy") {
            steps {
                echo 'deploy application...'
            }
    }
  }
}
