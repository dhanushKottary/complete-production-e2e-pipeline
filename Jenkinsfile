pipeline{
    agent{
        label "jenkins-agent"
    }
    tools {
        jdk 'Java17'
        maven 'Maven3'
    }
    environment {
        APP_NAME = "complete-production-e2e-pipeline"
        RELEASE = "1.0.0"
        DOCKER_USER = "dhaprako"
        DOCKER_PSWD = "dockerhub" //Name of the secret
        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
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
           // environment {
               // _JAVA_OPTIONS = "-Djdk.internal.httpclient.disableHostnameVerification=true"
   			 //}
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
        stage("SonarQube Analysis"){
            steps {
                script {
                    docker.withRegistry('',DOCKER_PSWD){
                        docker_image = docker.build "${IMAGE_NAME}"
                    }
                    docker.withRegistry('',DOCKER_PSWD){
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push("latest")
                    }
                }
            }
        }                  
    }
}
