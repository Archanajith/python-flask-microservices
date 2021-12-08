# Final Project Report

* Goal of the project :

1. Goal of the project was to use an open-source multiple microservices based application and set up CI/CD pipeline using Jenkins, Terraform. 
2. It also includes monitoring all the components of the project including Github, Jenkins, AWS, Docker using Datadog.
3. Synthetic tests to monitor the application.

## Technology stack that we used and learned in this project

### Terraform:

Terraform is code as infrastructure.In our project we have used terraform for automating below
1. Setup the jenkins server as EC2 instance.
2. Setup the deployment infrastructure (EC2 instance).
3. Automate the creation of datadog dashboard for monitoring purpose.
4. Automate the synthetic test and monitor creation.


### Docker and Docker-Compose:
Docker consists of a platform as a service products that help in delivering software in packages known as containers. 
Docker Compose is a tool to define and run multi-container docker applications.
Docker Compose is a 3 step process-
1. Define your app’s environment with a Dockerfile.
2. Define the services that make up your app in docker-compose.yml.
3. Run docker compose up. 
4. You can alternatively run docker-compose up using the docker-compose binary.

### Jenkins:
The main component to facilitate our CI/CD process is Jenkins.We chose Jenkins for our project as it provides easy integration with the monitoring component of our project Datadog. The Jenkins instance is configured so that any changes made to the Git Repo would directly trigger a build for the pipeline. Our pipeline consists of multiple stages each having multiple steps. The following stages have been implemented in the Jenkins pipeline-

![image](https://github.com/vinay-sj/python-flask-microservices/blob/master/index.jpg)


### Datadog:
* Datadog is an essential monitoring and security platform for cloud applications. 
* It helps to bring together end-to-end tracing, metrics, and logs to make applications, infrastructure, and third-party services entirely observable. These capabilities help secure systems, avoid downtime and ensure the best user experience.

### AWS:
* AWS is a service that provides on-demand cloud computing platforms and APIs to individuals, companies, and governments, on a metered pay-as-you-go basis.
* It provides a variety of basic abstract technical infrastructure and distributed computing building blocks and tools.
* Few of these services include AWS EC2, EKS, ECS, etc

## Usecases of each of the technology in our project

### Terraform

* In our project we have used terraform for 
  1. Setup the Jenkins server as an EC2 instance.
  2. Setup the deployment infrastructure (EC2 instance).
* Automate the creation of Datadog dashboard for monitoring purposes.
* Automate the synthetic test and monitor creation.

### Docker:
* We have used Docker in our project in the following ways-
  1. Docker to build individual images of each of the different microservices.
  2. Docker Hub which acts as a repository for saving each of these individual images in their respective repositories.
  3. Docker Compose for deploying all of our containers in AWS using the docker-compose.yaml file.

### Datadog monitoring and synthetic test
* In our project we have used Datadog for monitoring and for running synthetic tests.
* We have used the following platforms provided by Datadog:
  * [Datadog Agent](https://docs.datadoghq.com/agent/)
    
    It is an open-source software that runs on the host which collects events and metrics from hosts and sends them to Datadog. We have used the agent on our application and the Jenkins server for monitoring.
  * [Integrations](https://docs.datadoghq.com/integrations/)
  
    Using integrations all the metrics and logs from the infrastructure can be brought together. It helps gain insights into the unified system - you can see pieces individually and also how individual pieces are impacting the whole.
    
  * [Dashboards](https://docs.datadoghq.com/dashboards/)
    
    It is Datadog's tool for visually tracking, analyzing, and displaying key performance metrics which enable infrastructure health monitoring. 

  * [Alerting](https://docs.datadoghq.com/monitors/)
  
    It gives the ability to know when critical changes occur. Datadog lets you create monitors that actively check metrics, integration availability, network endpoints, and more.
  
  * [Synthetic Monitoring](https://docs.datadoghq.com/synthetics/) 
  
    It allows you to observe how your systems and applications are performing using simulated requests and actions from around the globe. Datadog tracks the performance of your webpages and APIs from the backend to the frontend, and at various network levels in a controlled and stable way, alerting you about faulty behavior.
* We have integrated Datadog to the application, Github repository, Jenkins instance, and AWS. 
* Using Synthetic monitoring, we run tests on our application that execute every hour on 16 AWS locations on Chrome, Firefox,and Edge browsers. The results get displayed on the dashboard and alerts are sent on failure.

### AWS:
* For our project we have used AWS EC2 for the following- 
  1. To deploy our application.  
  2. Host Jenkins server. 

## The Overall picture :

![image](https://user-images.githubusercontent.com/55074591/144975886-ac0a8bee-6a15-4225-be0a-36147e6734ba.png)

## The Overview of the Jenkins pipeline integration :
![image](https://github.com/vinay-sj/python-flask-microservices/blob/master/Blank%20diagram(1).png)


## Steps for setting up Jenkins server, CICD pipeline.

### Step 1: Setup your AWS account, Datadog account.

Create your AWS account, for this project we created a backpack Datadog account. Make sure to switch the CloudWatch logs.
Login to your Datadog application and create the API key and APP key.


### Step 2: Fork the repository and clone on your local machine.
* Complete AWS configuration https://docs.aws.amazon.com/cli/latest/userguide/cli-chap-configure.html
* After cloning the repository. Currently, we have hardcoded the Datadog api key. Thus you will need to change it in the docker-compose.yml file at line 178.
* Do the mentioned changes in monitoring/backend, deployment_infrastructure/backend, synthetic-test/backend. Open the variables file edit the bucket name to something unique as AWS needs a unique bucket name globally irrespective of the account.
* Now go to the deployment_infrastructure/, monitoring/, synthetic-test folder open the state.tf file. Update the S3 name in this file.

### Step 3: Set up the manual integrations for GitHub, AWS.

#### Integrations for Github
* Login to the Datadog Dashboard using the credentials created initially.
* Navigate to the Integrations and search for Github.



* A pop-up like above will appear. Please follow these settings.

#### Integeration for AWS.
* Login to the Datadog Dashboard.
* Navigate to the Integrations and search for Amazon Web Services Integration.
* You will see a pop-up as below.

![image](https://user-images.githubusercontent.com/55074591/144971807-bd40b43e-51d0-4b7b-a4f8-e5586d971c6c.png)

* There are two ways to configure the integration. The first way is through Cloud formation which does not work. We suggest going with the second option which is manual configuration.

* Step by step follow the configurations mentioned in Manual section in this link https://docs.datadoghq.com/integrations/amazon_web_services/?tab=roledelegation


### Step 4: Create a EC2 Jenkins Server using Terraform.
1. Create an instance or use an existing instance. Make sure the pem file of the instance is included in the AWS Key pairs. Store the .pem file in a secure place. We will be using this pem file throughout. Login to EC2 instance using the following command.

ssh -i <key_pair.pem> ubuntu@<instancehostname>
  
2. Install Terraform
```
sudo apt-get update && sudo apt-get install -y gnupg software-properties-common curl
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
sudo apt-get update && sudo apt-get install terraform
```

3. Install AWS CLI and configure it(add in your access key and the password)
```
sudo apt-get update
sudo apt-get install awscli
aws configure
```
* Make sure to attach that IAM role conists of the following permissions-
  1.AdministratorAccess
  2.AmazonEC2FullAccess
  
 
  ![image](https://github.com/vinay-sj/python-flask-microservices/blob/master/Roles.PNG)

4. Copy the pem file to the ```init``` folder of the instance 
```angular2html
scp -i ./key-pair.pem ./key-pair.pem <username>@<public-ip>:/pathwhere/you/need/to/copy 

```

```forus:  scp -i cloud-project.pem ./cloud-project.pem  ubuntu@ec2-3-18-221-32.us-east-2.compute.amazonaws.com:~/init  ```
  
5. Copy the ```jenkins-init.tf``` file to the instance/machine where terraform is installed 
```angular2html
scp -i ./PEM/cloud-project.pem ./jenkins-init.tf  ubuntu@ec2-3-18-221-32.us-east-2.compute.amazonaws.com:~/jenkins
```
6. Use the ```jenkins-init.tf``` from the cloned repository make the following changes
   * at line 95, specify the directory of your private key
   * at line 56, specify the name of your AWS key pair
  
7. Navigate to the root folder and run the following
```
terraform init
```
```angular2html
terraform apply
```
  
### Step 5: To activate Jenkins instance
* Take the public IP from the AWS instance created and access it using ```<publicip>:8080```. This will open the Jenkins instance
* Now you will be prompted to enter the ```Administrator Password```. 
  
 ![image](https://github.com/vinay-sj/python-flask-microservices/blob/master/index2.png) 
  
* Run the following command in your Jenkins Instance/Machine to get the password
```
sudo cat /var/lib/jenkins/secrets/initialAdminPassword
```
* Now the initial password will be displayed on your console.  
* login using the password
* Click on ```Install Suggested Plugins```
  
   ![image](https://github.com/vinay-sj/python-flask-microservices/blob/master/index3.jpg) 
  
* Fill all the required details on the Create First Admin User form 
* Click next till you reach the Jenkins Dashboard
* Run the following commands in the Jenkins instance terminal. These commands are add to add Jenkins user to Docker group so that it gets access to push the images to Docker Hub.
```
sudo usermod -aG docker $USER
newgrp docker 
sudo systemctl start docker
sudo systemctl enable docker
sudo systemctl status docker
sudo usermod -a -G docker jenkins
sudo service jenkins restart
sudo systemctl daemon-reload
sudo service docker stop
sudo service docker start
```

* Select Manage Jenkins -> Manage Plugin and download the following Plugins
    * Docker
    * Docker Pipeline
    * DataDog
    * Terraform

.

### Step 6: Setup integration with Jenkins and Datadog.
* Login to the Datadog Dashboard.
* Navigate to the Integrations and search for Jenkins.
You will see a pop-up like below.

![image](https://user-images.githubusercontent.com/55074591/144972354-a95ddef8-d1d2-4d6b-888e-e3de6d7e755e.png)

Follow the exact steps mentioned here. Install the Datadog plugin in Jenkins. Complete the mentioned configurations.
  

### Step 7: Run the following commands in the Jenkins instance
```
sudo su -
cp /etc/sudoers /root/sudoers.bak
visudo
```
* Add the following entry at the end of the file and save and exit the file.This step is mandatory for the Jenkins pipeline to run
   jenkins ALL=(ALL) NOPASSWD:ALL
  
### Step 8: Download Datadog agent in Jenkins instance.
* Login to Datadog instance and download the following command-
  
  ![image](https://github.com/vinay-sj/python-flask-microservices/blob/master/Datadog_Agent_Download.gif)
  
* Run the following command at the Jenkins instance with your Datadog API_KEY to activate the Datadog instance in Jenkins.This enables the Jenkins monitoring to be  visible at the Datadog Dashboard.
  
  ```DD_API_KEY=<API_KEY> DD_AGENT_MAJOR_VERSION=7 bash -c "$(curl -L https://raw.githubusercontent.com/DataDog/datadog-agent/master/cmd/agent/install_script.sh)"```
  
### Step 9: Add your pem file to the EC2 Jenkins Server.
* Create a new key_pair in the region where you have the deployment server.
* Download the pem file of teh newly created key_pair.
* scp -i access.pem cd /Users/anaghabhosale/Downloads/<key_pair.pem>  ubuntu@ec2-18-208-163-152.compute-1.amazonaws.com:~/home/ubuntu/init/.


### Step 10: Configure your Jenkins pipeline and pipeline script.
* Login to Jenkins Dashboard.Create a new pipeline by clicking on New Item and selecting Pipeline.
  
  ![image](https://github.com/vinay-sj/python-flask-microservices/blob/master/pipeline1.png)
  
* Select the following option, this enables the automatic trigeer command in Jenkins pipeline. When a commit is made to the GitHub account, it triggers a build here.
  
  ![image](https://github.com/vinay-sj/python-flask-microservices/blob/master/pipeline2.png)
  
  The jenkins URL along with /github-webhooks must be added to web plug-ins in the GitHub repository.
  
* The GitHub repo must be specified in the fields highlighted below, this configures the location of the Jenkinsfile that Jenkins looks while creating a build pipeline.
  
   ![image](https://github.com/vinay-sj/python-flask-microservices/blob/master/pipeline3.png)

### Step 11: Setup the datadog credentials in Jenkins
* Add the APP_KEY and API_KEY as contants in Jenkins. This is later accessed in the Jenkins Pipeline script.
* Go to Manage Jenkins-> Manage Credentials-> click on global scope-> Add Credentials.
* Click on Secret Text and add APP_KEY and API_KEY as description for each of the ids.
  

### Step 12: Do a commit and run the build.
  
  ![image](https://github.com/vinay-sj/python-flask-microservices/blob/master/pipeline4.png)
Upon committing  all the stages of the pipeline will run and the app gets deployed as well as the monitoring dashboard,and synthetic test setup.


## Key Decisions:

1. Using DDtrace instead of OpenTelementry and Jaeger. It helps to avoid  the development effort required for tagging the services for the monitoring purpose. As dd-trace requires some configuration in the environment and no code change.

2. Using Jenkins for continuous integration continuous delivery as the Datadog does not provide support for it

3. Use of Terraform for automating the deployment infrastructure creation, monitoring dashboard creation, synthetic test and monitor creation. This helps to automate infrastructure management. Easier replication of infrastructure incase of scenarios which need to duplicate the infrastructure.

4. Use of Docker Compose instead of Kubernetes

## Conclusion:

* This project was a great learning for us who were naive in the DevOps spectrum.
* We learned a lot of important tools and technologies such as Teraform, Jenkins and Datadog for monitoring. 
* A big thank you to our mentors (Panat and Brian) and Professor Peter Desnoyers for the constant support and a great learning experience through this project.








