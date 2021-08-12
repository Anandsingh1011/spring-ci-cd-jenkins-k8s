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
    JENK_INT_IT_CRED_ID = "${PROJECT}"
    PROD_CLUSTER = "jenkins-cd"
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
          // sh "mvn verify"

          // bundle the generated artifact    
          sh "cp target/${APP_NAME}-*.jar $APP_JAR"

          // archive the build context for kaniko			    
          sh "tar --exclude='./.git' -zcvf /tmp/$BUILD_CONTEXT ."
          sh "mv /tmp/$BUILD_CONTEXT ."
          step([$class: 'ClassicUploadStep', credentialsId: "${JENK_INT_IT_CRED_ID}", bucket: "gs://${BUILD_CONTEXT_BUCKET}", pattern: env.BUILD_CONTEXT])

        }
      }
    }
    
    
    
    
    
    
    stage("Update Image") {
      agent {
        kubernetes {
          cloud 'kubernetes'
          label 'tool-pod'
          yamlFile 'jenkins/tool-pod.yaml'
        }
      }
      steps {
        container('tools') {
          // sh "mkdir -p /home/jenkins/agent/delme && cd /home/jenkins/agent/delme"
          
            sh "pwd"
            sh "ls -ltr"
            // sh "git clone https://github.com/Anandsingh1011/spring-ci-cd-jenkins-k8s.git -b main"
            sh "git checkout -b main"
            sh "git config --global user.email 'anandsingh1011@gmail.com'"
            // sh "git remote add origin https://github.com/Anandsingh1011/spring-ci-cd-jenkins-k8s.git"
             sh "git remote set-url origin git@github.com/Anandsingh1011/spring-ci-cd-jenkins-k8s.git"
            
            sh "git branch"
            //dir("spring-ci-cd-jenkins-k8s"){
              sh "cd kubernetes/prod && kustomize edit set image ${GCR_IMAGE}"
              sh "pwd"
              sh "ls -ltr"
              sh "cat kubernetes/prod/kustomization.yaml"
              sh "git status && git show-ref"
              sh "git add . "
              // sh "git add kubernetes/prod/kustomization.yaml"
              sh "git commit -m 'Publish new version' && git push --set-upstream origin main || echo 'no changes'"
              //sh "git commit -m 'Publish new version'"
              //sh "git push -u origin head"
          
              // sh "git push --set-upstream origin main"
              // sh "git status && git push || echo 'no changes'"
          //}
        }
      }
    }
  }
}
