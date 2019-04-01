## Getting Started with TeamCity

### Setting up TeamCity : Server Agent Model
Works as Server<>Agent model

Single one - server node, has services - server and agent. 

Agents work on builds, when one node is not enough - you can set up agent nodes and send builds there. 

![server_agent](https://github.com/Bes0n/TeamCity/blob/master/images/Annotation%202019-02-22%20114307.jpg)

### Setting up TeamCity : Windows Installation
Go to website and download .exe file 

Will start as a services after reboot: 

![installation](https://github.com/Bes0n/TeamCity/blob/master/images/Annotation%202019-02-22%20115118.jpg)

If you set up agent on different machine - enter servername instead of localhost. 
![img](https://github.com/Bes0n/TeamCity/blob/master/images/Annotation%202019-02-22%20115653.jpg)

* For services running use user account, helps to avoid debugging problems. 

* Choose database type. HSQL - internal SQL, for production best practice to use different type of database. 

* Set up admin account and directory where to store files 

* TeamCity services:
  * TeamCity Server - main node service
  * TCBBuildAgent - TeamCity Build Agent

### Setting up TeamCity : Linux and Mac Installation
* Same procedure - download required OS package. 

* Unpack archive tar -zxf TeamCity-10.0.1.tar.gz
  * follow /bin folder and /bin/runAll.sh start - for start services
  * /bin/runAll.sh stop - for stop services 
  * follow localhost:8111/mnt

### Setting up TeamCity : A docker-compose.yml for TeamCity
* go to docker hub and find jet brains organization - https://hub.docker.com/u/jetbrains
* go to teamcity-server 
* check tags for versions
* there is a repo info
* go to docker compose file 
* grab raw content of docker-compose.yml - https://gist.github.com/g0t4/
* create docker compose file on your system. 

```
docker run -it --name teamcity-server-instance  \
    -v <path to data directory>:/data/teamcity_server/datadir \
    -v <path to logs directory>:/opt/teamcity/logs  \
    -p <port on host>:8111 \
    jetbrains/teamcity-server
```

### Setting up TeamCity : Starting TeamCity Docker Containers
* docker-compose up -d teamcity
* docker-compose ps - check service up and running 
* agents run different from server, so you have to run agents with *docker-compose up -d*
* docker-compose log -f - look for logs in tail mode 
* check for agent status from web and authorize your agent. 

### Setting up TeamCity : Configuring vs. Consuming and User Accounts
* To add new users go to Administration > Users > Create a New User Account 
* Administrator can create project
* You can change Authentication from Built-In to LDAP or NTLM type. 

## Creating Application Builds
### Anatomy of a Build
![img](https://github.com/Bes0n/TeamCity/blob/master/images/Annotation%202019-02-22%20144704.jpg)

### Cloning the Sample Project
* For example we will take this repo - https://github.com/g0t4/teamcity-course-spring-petclinic
* Clone or download this repo and use *git clone* command with URL 
* git clone https://github.com/g0t4/teamcity-course-spring-petclinic.git
* change directory to your unpacket git repo

### Installing Build Tools
* As you see this project can be compiled by Maven 
* go to Maven website and install application
* use mvn to work with Maven 
* for windows you can use *Chocolatey* package manager - https://chocolatey.org/install
  * get-execution policy 
  * install chocolatey 
  * choco install -y maven, if you didn't install Java - install JDK 8 too
  * re-run powershell ISE, run as administrator 
  * mvn -v - check version of maven 
  * choco install -y git 
  * same as for linux - *git clone URL* 

### Manually Compiling an Application
* change your directory after cloning your repo 
* run *mvn compile* (same for mac and windows)
* target folder arrives with classes 

### Manually Testing an Application
* You can test your application with Maven - *mvn test*
  * you will see the results of testing and information about build status 
  * there will be test results in the same directory TEST-org and jacoco.exec file 
  * same for Windows and exact output will be given in the end of testing 
  
### Manually Packaging an Application
* Now we need to package our application
  * mvn package 
  * building war file and directory where this file is located 
  * same steps for windows: testing - packaging - output file 
  
### Automating Builds
* now we are going to perform the same steps done manually - with TeamCity and automated

### Creating a TeamCity Project and Build Configuration
* Steps:
  * Create project
  * Pointing to repository URL 
    * for public repository username and password is not required. 
  * set project name and build configuration name 

![img](https://github.com/Bes0n/TeamCity/blob/master/images/repo_automate.jpg)

* For build steps you can see Auto-build steps. Your VSC automatically scanned  
  * command line build 
  * maven build
  
![img](https://github.com/Bes0n/TeamCity/blob/master/images/img1.JPG)

* On Build Step: Maven you can see your steps. For this moment we have goals - Clean Test
  * Here we can change steps from *clean* to *compile* like in command line. 

### Detecting Build Tools

![img](https://github.com/Bes0n/TeamCity/blob/master/images/img2.JPG)

* after JDK installation to be abe to see JDK in team city build window we need to restart team city build agent - TCBuildAgent 
* Goals field required for defining what command to run on Maven. We changed it to *compile*
* if we will check logs *C:\TeamCity\buildAgent\logs and go to teamcity-agent.log we can see that agent is looking for java installation. 
* also we can see that TeamCity BuildAgent is looking for another build tools like Dot Net Framework. 

### Running a Build
* To start our process we can use *run* button. 
![img](https://github.com/Bes0n/TeamCity/blob/master/images/img3.JPG)

* after clicking run you can see update on a *build queue* that one item is added 
* then on agent tab color will change, that agent is busy right now. 
* if you didn't redirected to *build view* go to * Build Configuration Home* to see result in recent history. 
* we can switch from *Build Configuration* to *Edit Configuration Settings* and visa versa. 
* you can access *build log* to see details of your build. 

### The Build Log
* in build log you can see different information combined by groups
  * Collecting changes in 1 VCS root
  * Publishing internal artifacts
  * Updating sources
  * Maven step (which is orange) with time indicated
  
![img](https://github.com/Bes0n/TeamCity/blob/master/images/img4.JPG)

### The Checkout Directory
* If we will go to the agent where build agent installed and check our Checkout directory - *C:\TeamCity\buildAgent\work\...* we can see there our repository/ 
* if we will run build again - nothing will happen, because files are cached. So in this case sometimes it happens that build can fail and it's difficult to find what causes that. Let's discuss *cleaning* process on next topic. 

![img](https://github.com/Bes0n/TeamCity/blob/master/images/img5.JPG)

### Cleaning Between Builds

* if incremental build is not enough for us, we can go to Build Steps and to the goals *clean compile* attribute. 
* if we will run build in this case we can see that folders are recreating inside work folder. 

![img](https://github.com/Bes0n/TeamCity/blob/master/images/img6.JPG)

### Capturing Packages as Artifacts

* we can change procedure of build again in Build Step: Goals field.
* change it from *clean compile* to *clean package*
* on *general settings* of our build we can see *artifact paths* which we can define by clicking on tree right on the field
* you also can open help for artifact path, to get more information 
* when you run build, tests start passing, because TeamCity smart and knows that in packaging procedure test must be passed. 
* you can take artifacts and push them to somewhere else. 

![img](https://github.com/Bes0n/TeamCity/blob/master/images/img7.JPG)

### Quizzery
* When you have error in your build, you can investigate it from *Build Log* 
* after our investigation we have to go to the step where build has failed, fix it and re-run build
* go to home and check build status 
* on root page you can see following information 
  * Build Configuration 
  * Project
  * Build Result 
  * Output of a Build 
  
![img](https://github.com/Bes0n/TeamCity/blob/master/images/img8.JPG)  

## Automating Builds for Fast Feedback
### .NET Library Build Steps
* clone repository to workspace folder 
* NuGet - which is a packager manager for the Dot Net ecosystem
* NuGet to pull dependencies. 
* MSBuild - to compile our application. 
* NUnit - test runner in te NET space. Need to run some unit tests 
* NuGet Pack - for packaging our application after performed tests. 

As example we will use this project: 
https://github.com/g0t4/teamcity-course-aspnet-identity-mongo

![img](https://github.com/Bes0n/TeamCity/blob/master/images/img9.JPG)

### Restoring NuGet Dependencies
* first step we need NuGet Restore 
* same steps for creating project on Java. Go to <Root project>

![img](https://github.com/Bes0n/TeamCity/blob/master/images/img10.JPG)

* there is a variaties of build steps in runner type field. 

![img](https://github.com/Bes0n/TeamCity/blob/master/images/img11.JPG)

* first of all go to Administration > Tools > Install tool and select NuGet 
  * select NuGet version 
  * find .sln file in your project Tree 
  * run build 
  
* after running build you can see NuGet Packages
* dependencies restored and next step is running MS Build  
![img](https://github.com/Bes0n/TeamCity/blob/master/images/img12.JPG)  

### Adding a Second Build Step for MSBuild
* go to *Edit configuration settings* and add Visual Studio as 2nd Build step
* don't mess with steps, first you have to restore dependencies, otherwise build will fail 

![img](https://github.com/Bes0n/TeamCity/blob/master/images/img13.JPG)

* when you click run - No compatible agents error appears. 
* there is no MSBuildTool installed on the agent 

![img](https://github.com/Bes0n/TeamCity/blob/master/images/img14.JPG)

* go and install required tools and restart agent
* msbuild will run immediately

![img](https://github.com/Bes0n/TeamCity/blob/master/images/img15.JPG)

### Running Unit Tests with NUnit
* for unit test we're going to add Build Step *NUnit*
* select path for run tests from 

![img](https://github.com/Bes0n/TeamCity/blob/master/images/img16.JPG)


### Rich Test Reporting
* after Unit Test we can check results in Tests tab 

![img](https://github.com/Bes0n/TeamCity/blob/master/images/img17.JPG)

### Automated Code Coverage Reports

* enable Code Coverage in Buld Steps of NUnit testing by selecting JetBrains dotCover 
* after Unit Test end you can see code coverage output 

![img](https://github.com/Bes0n/TeamCity/blob/master/images/img18.JPG)

* so you can also access code coverage tab directly and take a look at any parts of your code 

### Triggering Builds on Code Changes