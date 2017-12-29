#!/usr/bin/env groovy

pipeline {
  agent {
    node {
      label 'docker'
    }
  }

  triggers {
    pollSCM('* * * * *')
  }

  stages {
    stage('Build') {
      steps {
        sh './docker-node.sh'
      }
    }
    stage('Integration Test') {
      steps {
        sh './docker-node.sh xvfb-run -a -e xvfb.err -s "\'-screen 0 2560x1440x8\'" -- npm run e2e_firefox'
      }
    }
  }
  post {
    failure {
      // notify users when the Pipeline fails
      mail to: 'gerd@aschemann.net',
        subject: "Failed PWA Pipeline: ${currentBuild.fullDisplayName}",
        body: "Something is wrong with ${env.BUILD_URL}"
    }
  }
}
