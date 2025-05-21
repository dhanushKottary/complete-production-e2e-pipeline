pipeline{
    agent{
        label "jenkins-agent"
    }
    tools {
        jdk 'Java17'
        maven 'Maven3'
    }
    stages{
        stage("Cleanup Workspace"){
            steps {
                cleanWs()
            }

        }
    
        stage("Checkout from SCM"){
            steps {
                git branch: 'dev', credentialsId: 'github', url: 'https://github.com/dhanushKottary/complete-production-e2e-pipeline.git'
            }

        }
    }
}
