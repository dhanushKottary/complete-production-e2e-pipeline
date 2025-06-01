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
        
        stage("Build Application"){
            steps {
                sh "mvn clean package"
            }

        }
        stage("Test Application"){
            steps {
                sh "mvn test"
            }

        } 
        stage("SonarQube Analysis"){
            environment {
                _JAVA_OPTIONS = "-Djdk.internal.httpclient.disableHostnameVerification=true"
   			 }
            steps {
                script {
                    withSonarQubeEnv(credentialsId: 'jenkins-sonarqube-token'){
				    sh   '''
                   			 mvn sonar:sonar
                         '''
                    }

                }
            }
        }       
    }
}
