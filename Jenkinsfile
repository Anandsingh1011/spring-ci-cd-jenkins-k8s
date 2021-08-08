pipeline {

  environment {
    PROJECT = "kf-gcp12449"
	  
    PROJECT_ZONE = "us-east1-d"
    PROJECT_ID = "kf-gcp12449"
	  
    APP_NAME = "spring-ci-cd-jenkins-k8s"
    CLUSTER = "jenkins-cd"
    CLUSTER_ZONE = "us-east1-d"
    IMAGE_TAG = "gcr.io/${PROJECT}/${APP_NAME}:${env.BRANCH_NAME}.${env.BUILD_NUMBER}"
    JENKINS_CRED = "${PROJECT}"
    APP_JAR = "${APP_NAME}.jar"
    BUILD_CONTEXT_BUCKET = "kf-gcp12449_cloudbuild"
    BUILD_CONTEXT = "build-context-${BUILD_ID}.tar.gz"
    GCR_IMAGE = "gcr.io/${PROJECT_ID}/${APP_NAME}:${BUILD_ID}"
  }

  agent none
    
  
  
  stages {
      stage("Build and test") {
	    agent {
    	    	kubernetes {
      		    cloud 'kubernetes'
      		    label 'maven-pod'
      		    yamlFile 'jenkins/maven-pod.yaml'
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
                       sh "tar --exclude='./.git' -zcvf /tmp/$BUILD_CONTEXT ."
                       sh "mv /tmp/$BUILD_CONTEXT ."
                       step([$class: 'ClassicUploadStep', credentialsId: env.JENK_INT_IT_CRED_ID, bucket: "gs://${BUILD_CONTEXT_BUCKET}", pattern: env.BUILD_CONTEXT])
                    
		      }
	    }
	}
	stage("Publish Image") {
            agent {
    	    	kubernetes {
      		    cloud 'kubernetes'
      		    label 'kaniko-pod'
      		    yamlFile 'jenkins/kaniko-pod.yaml'
		}
	    }
	    environment {
                PATH = "/busybox:/kaniko:$PATH"
      	    }
	    steps {
	        container(name: 'kaniko', shell: '/busybox/sh') {
		    sh '''#!/busybox/sh
		    /kaniko/executor -f `pwd`/Dockerfile -c `pwd` --context="gs://${BUILD_CONTEXT_BUCKET}/${BUILD_CONTEXT}" --destination="${GCR_IMAGE}" --build-arg JAR_FILE="${APP_JAR}"
		    '''
		}
	    }
	}  
  }
}
