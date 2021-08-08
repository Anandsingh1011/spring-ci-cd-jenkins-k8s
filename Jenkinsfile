pipeline {

  environment {
    PROJECT = "kf-gcp12449"
    APP_NAME = "spring-ci-cd-jenkins-k8s"
    CLUSTER = "jenkins-cd"
    CLUSTER_ZONE = "us-east1-d"
    IMAGE_TAG = "gcr.io/${PROJECT}/${APP_NAME}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"
    JENKINS_CRED = "${PROJECT}"
  }

  agent none
    
  
  
  stages {
      stage("Build and test") {
	    agent {
    	    	kubernetes {
      		    cloud 'kubernetes'
      		    label 'maven-pod'
      		    yamlFile 'gke/jenkins/maven-pod.yaml'
		}
	    }
	    steps {
	    	container('maven') {
               
                      // build
                      sh "mvn clean package"

                      // run tests
                      sh "mvn verify"

                      // bundle the generated artifact    
                      sh "cp target/${APP_NAME}-*.jar $APP_JAR"

                      // archive the build context for kaniko			    
                      // sh "tar --exclude='./.git' -zcvf /tmp/$BUILD_CONTEXT ."
                      // sh "mv /tmp/$BUILD_CONTEXT ."
                      // step([$class: 'ClassicUploadStep', credentialsId: env.JENK_INT_IT_CRED_ID, bucket: "gs://${BUILD_CONTEXT_BUCKET}", pattern: env.BUILD_CONTEXT])
                    
		      }
	    }
	}
  }
}
