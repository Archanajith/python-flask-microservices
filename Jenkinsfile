pipeline {
	agent any
	options {
        datadog(collectLogs: true)
    }
	environment {
		//once you sign up for Docker hub, use that user_id here
		registryFrontend = "ajitha1234/frontend"
		registryUserService = "ajitha1234/userservice"
		registryOrderService = "ajitha1234/orderservice"
		registryProductService = "ajitha1234/productservice"
		registryCredential = 'DOCKER_HUB_ID'
		dockerImagefrontend = ''
		dockerImageuserService = ''
		dockerImageorderService = ''
		dockerImageproductService = ''
		loginPEMFILE='Login'
		APP_KEY='APP_KEY'
		API_KEY='API_KEY'
	}
	stages {
        	stage('Clone') {
            		steps {
                		git credentialsId: 'GIT_HUB_CREDENTIALS', url: 'https://github.com/Archanajith/python-flask-microservices.git'
			}
		}
		stage('Terraform Infrastructure Setup') {
                         steps {
				echo 'Starting terraform initialization for S3 bucket creation.'
 				dir('deployment_infrastructure/backend'){
 					sh ' sudo terraform init -reconfigure'
 				}
				 echo 'Starting terraform apply.'
				 dir('deployment_infrastructure/backend'){
 					sh ' sudo terraform apply -input=false -auto-approve=true '
 				}
 			}	
		}
		stage('Building Docker Image') {
			steps {
				echo 'Starting to build docker image of frontend'
				dir('frontend'){
					script {
						dockerImagefrontend = docker.build registryFrontend
					}	
				}
				echo 'Starting to build docker image of order-service'
				dir('order-service'){
					script {
          					dockerImageorderService = docker.build registryOrderService
                                 	}	
				}
				echo 'Starting to build docker image of product-service'
				dir('product-service'){
					script {
          					dockerImageproductService = docker.build registryProductService
                                 	}
				}
				echo 'Starting to build docker image of user-service'
				dir('user-service'){
					script {
          					dockerImageuserService = docker.build registryUserService
                                 	}
				}
			}
        	}
		//Uploading Docker images into Docker Hub
		stage('Upload Docker Image') {
			steps {
				echo 'Uploading image to frontend repository'
				dir('frontend'){
					script {
						 docker.withRegistry( '', registryCredential ) {
            						dockerImagefrontend.push()
            					 }
					}	
				}
				echo 'Uploading image to orderservice repository'
				dir('order-service'){
					script {
          					docker.withRegistry( '', registryCredential ) {
            						dockerImageorderService.push()
            					 }
                                 	}	
				}
				echo 'Uploading image to productservice repository'
				dir('product-service'){
					script {
          					docker.withRegistry( '', registryCredential ) {
            						dockerImageproductService.push()
            					 }
                                 	}
				}
				echo 'Uploading image to userservice repository'
				dir('user-service'){
					script {
          					docker.withRegistry( '', registryCredential ) {
            						dockerImageuserService.push()
            					 }
                                 	}
				}
			}
        	}
		stage('Deployment Infrastructure Setup and Docker-Compose Deployment') {
                         steps {
				echo 'Starting terraform initialization for S3 bucket creation.'
 				dir('deployment_infrastructure'){
 					sh ' sudo terraform init -input=false  -reconfigure'
 				}
				 echo 'Starting terraform apply.'
				 dir('deployment_infrastructure'){
 					sh ' sudo TF_LOG=TRACE terraform apply -input=false -auto-approve=true'
 				}
 			}	
		}
		stage('Dashboard Monitoring Infrastructure Setup') {
                         steps {
				echo 'Starting terraform initialization for S3 bucket creation.'
 				dir('monitoring/backend'){
 					sh ' sudo  TF_LOG=TRACE terraform init -input=false  -reconfigure'
 				}
				 echo 'Starting terraform apply for S3 and dynamoDB creation.'
				 dir('monitoring/backend'){
 					sh ' sudo  TF_LOG=TRACE terraform apply -input=false -auto-approve=true '
 				}
				 echo 'Starting terraform initialization.'
				 dir('monitoring'){
 					sh ' sudo  TF_LOG=TRACE terraform init -input=false -reconfigure'
 				}
				 echo 'Starting terraform apply.'
				 dir('monitoring'){
 					withCredentials([string(credentialsId: 'APP_KEY', variable: 'APP_KEY')]) {
						withCredentials([string(credentialsId: 'API_KEY', variable: 'API_KEY')]) {
   						sh " sudo terraform apply -var 'APP_KEY=${APP_KEY}' -var 'API_KEY=${API_KEY}' -input=false -auto-approve=true" 
								}
							}
 					}
 				}	
		}
		stage('Synthetic Test Infrastructure Setup') {
                         steps {
				echo 'Starting terraform initialization for S3 bucket creation.'
 				dir('synthetic-test/backend'){
 					sh ' sudo terraform init -input=false  -reconfigure'
 				}
				 echo 'Starting terraform apply for S3 and dynamoDB creation.'
				 dir('synthetic-test/backend'){
 					sh ' sudo terraform apply -input=false -auto-approve=true '
 				}
				 echo 'Starting terraform initialization.'
				 dir('synthetic-test'){
 					sh ' sudo terraform init -input=false -reconfigure'
 				}
				 echo 'Starting terraform apply.'
				 dir('synthetic-test'){
 					withCredentials([string(credentialsId: 'APP_KEY', variable: 'APP_KEY')]) {
						withCredentials([string(credentialsId: 'API_KEY', variable: 'API_KEY')]) {
   						sh " sudo terraform apply -var 'APP_KEY=${APP_KEY}' -var 'API_KEY=${API_KEY}' -input=false -auto-approve=true" 
								}
							}
 					}
 				}	
		}
		
    	}
}
