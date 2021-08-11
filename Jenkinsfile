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

    stage("tag the commit with datetime") {
      steps {
        withCredentials([usernamePassword(credentialsId: '${env.JenkinsArgoCD}', usernameVariable: 'Anandsingh1011', passwordVariable: 'GIT_PASSWORD')]) {

          // use date for tag
          def tag = new Date().format("yyyyMMddHHmm")

          // configure the git credentials, these are cached in RAM for several minutes to use
          // this is required until https://issues.jenkins-ci.org/browse/JENKINS-28335 is resolved upstream
          sh "echo 'protocol=https\nhost=<git-host-goes-here>\nusername=${GIT_USERNAME}\npassword=${GIT_PASSWORD}\n\n' | git credential approve "

          sh "git tag -a ${tag} -m '${USER} tagging'"
          sh "git push --tags"
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

            sh "git clone https://Anandsingh1011:${env.JenkinsArgoCD}@github.com/Anandsingh1011/spring-ci-cd-jenkins-k8s.git -b main"
            sh "git checkout -b main"
            sh "git config --global user.email 'anandsingh1011@gmail.com'"
            sh "git branch"
            sh "cd kubernetes/prod && kustomize edit set image ${GCR_IMAGE}"
            sh "pwd"
            sh "ls -ltr"
            sh "cat kubernetes/prod/kustomization.yaml"
            sh "git status"
            sh "git add kubernetes/prod/kustomization.yaml"
            sh "git commit -m 'Publish new version'"
            sh "git status && git push origin HEAD:main || echo 'no changes'"

          }
        }
      }
    }
  }
