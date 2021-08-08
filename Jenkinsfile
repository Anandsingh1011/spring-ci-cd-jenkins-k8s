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
  tools {
        maven 'Maven 3.3.9'
        jdk 'jdk8'
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
    
    stage("build") {
            steps {
                echo 'build application...'
                sh 'mvn -Dmaven.test.failure.ignore=true install'
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
