## Getting Started with TeamCity

### Setting up TeamCity : Server Agent Model
Works as Server<>Agent model

Single one - server node, has services - server and agent. 

Agents work on builds, when one node is not enough - you can set up agent nodes and send builds there. 

![server_agent](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/Annotation%202019-02-22%20114307.jpg)
### Setting up TeamCity : Windows Installation
Go to website and download .exe file 

Will start as a services after reboot: 

![installation](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/Annotation%202019-02-22%20115118.jpg)

If you set up agent on different machine - enter servername instead of localhost. 
![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/Annotation%202019-02-22%20115653.jpg)

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
![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/Annotation%202019-02-22%20144704.jpg)

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

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/repo_automate.jpg)

* For build steps you can see Auto-build steps. Your VSC automatically scanned  
  * command line build 
  * maven build
  
![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img1.JPG)

* On Build Step: Maven you can see your steps. For this moment we have goals - Clean Test
  * Here we can change steps from *clean* to *compile* like in command line. 

### Detecting Build Tools

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img2.JPG)

* after JDK installation to be abe to see JDK in team city build window we need to restart team city build agent - TCBuildAgent 
* Goals field required for defining what command to run on Maven. We changed it to *compile*
* if we will check logs *C:\TeamCity\buildAgent\logs and go to teamcity-agent.log we can see that agent is looking for java installation. 
* also we can see that TeamCity BuildAgent is looking for another build tools like Dot Net Framework. 

### Running a Build
* To start our process we can use *run* button. 
![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img3.JPG)

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
  
![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img4.JPG)

### The Checkout Directory
* If we will go to the agent where build agent installed and check our Checkout directory - *C:\TeamCity\buildAgent\work\...* we can see there our repository/ 
* if we will run build again - nothing will happen, because files are cached. So in this case sometimes it happens that build can fail and it's difficult to find what causes that. Let's discuss *cleaning* process on next topic. 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img5.JPG)

### Cleaning Between Builds

* if incremental build is not enough for us, we can go to Build Steps and to the goals *clean compile* attribute. 
* if we will run build in this case we can see that folders are recreating inside work folder. 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img6.JPG)

### Capturing Packages as Artifacts

* we can change procedure of build again in Build Step: Goals field.
* change it from *clean compile* to *clean package*
* on *general settings* of our build we can see *artifact paths* which we can define by clicking on tree right on the field
* you also can open help for artifact path, to get more information 
* when you run build, tests start passing, because TeamCity smart and knows that in packaging procedure test must be passed. 
* you can take artifacts and push them to somewhere else. 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img7.JPG)

### Quizzery
* When you have error in your build, you can investigate it from *Build Log* 
* after our investigation we have to go to the step where build has failed, fix it and re-run build
* go to home and check build status 
* on root page you can see following information 
  * Build Configuration 
  * Project
  * Build Result 
  * Output of a Build 
  
![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img8.JPG)  

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

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img9.JPG)

### Restoring NuGet Dependencies
* first step we need NuGet Restore 
* same steps for creating project on Java. Go to <Root project>

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img10.JPG)

* there is a variaties of build steps in runner type field. 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img11.JPG)

* first of all go to Administration > Tools > Install tool and select NuGet 
  * select NuGet version 
  * find .sln file in your project Tree 
  * run build 
  
* after running build you can see NuGet Packages
* dependencies restored and next step is running MS Build  
![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img12.JPG)  

### Adding a Second Build Step for MSBuild
* go to *Edit configuration settings* and add Visual Studio as 2nd Build step
* don't mess with steps, first you have to restore dependencies, otherwise build will fail 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img13.JPG)

* when you click run - No compatible agents error appears. 
* there is no MSBuildTool installed on the agent 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img14.JPG)

* go and install required tools and restart agent
* msbuild will run immediately

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img15.JPG)

### Running Unit Tests with NUnit
* for unit test we're going to add Build Step *NUnit*
* select path for run tests from 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img16.JPG)


### Rich Test Reporting
* after Unit Test we can check results in Tests tab 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img17.JPG)

### Automated Code Coverage Reports

* enable Code Coverage in Buld Steps of NUnit testing by selecting JetBrains dotCover 
* after Unit Test end you can see code coverage output 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img18.JPG)

* so you can also access code coverage tab directly and take a look at any parts of your code 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img19.JPG)

### Triggering Builds on Code Changes
* let's consider Triggers in Build Configuration Settings 
* VCS root trigger could find any changes in your git repo and fetch them in GUI
* VCS understands when you make changes in your repo and automatically triggers. 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img20.JPG)

* take a look on VCS root name and Fetch URL this is where changes are triggered. You have to fork repo if you took it from other person, otherwise you couldn't push the changes to repo. 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img21.JPG)

### Notifications
![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img22.JPG)
* Notifications set up by user. Click on your *user* tab and check *Notification Rules*
* There are 4 types of notifications 
  * Email
  * IDE
  * Jabber
  * Windows Tray 
  
![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img23.JPG)  

### Email Notifications
* Let's configure email notifications. Go to *Administration* > *Email Notifier*
* Install Mailhog for testing email notifications. Find .yml config below

``` 
    mailhog:
        image: mailhog/mailhog
        restart: unless-stopped
        ports:
            - 1025:1025
            - 8025:8025
```

* Set up mail notifications and send test. 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img24.JPG)

* after setting up your notification rules you should get notification message about successful build or failed, depends how did you configured your notification rules. 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img25.JPG)

### GitHub Integration
* One of the important Build Features is Commit Status publisher. 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img26.JPG)

* We can add issue tracking for Project itself. 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img27.JPG)

* Or you can go to Connections tab and establish connection with cloud solution 
  * this one simplifies your repository adding, tracking issues and commits 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img28.JPG)

### Quizzery 

* while packaging NuGet packages, you can check in Build Steps the following
  * *Publish created packages to build artifacts* - so artifacts can automatically selected after finish of build. 

## Chaining Builds to Perform Parallel Integration Testing
### Modeling Deployment Pipelines
* Let's confider Java Build process
  * Getting repository from github
  * performing fast tests with npm install and PhantomJS
  * performing integration tests for compatibility on browsers 
  * after integration and fast test, someone review it and press push button 
  * deploy to staging with deploy and smoke test 
  
![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img29.JPG)

### Manually Adding a Build Configuration
* Manually create project and manually create build
* add 01. Fast Tests as first build 
* add https://github.com/g0t4/teamcity-course-cards as URL to repository 
* we can choose different Type of VCS. In our case this is Git 
  * add VCS root name and Fetch URL 
  * you also can change authentication method from anonymous to password 
  
![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img30.JPG)

### Build Scripts with the Command Line Build Step
* Let's use *command line* as a build step, we have to add it manually. 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img31.JPG)

###  Using NPM in TeamCity
* we're going to have problems, because there is no nodejs and npm on our build. 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img32.JPG)

* we have to install nodejs and npm. For linux
  * *apt install nodejs* *apt install npm*
  * after installation you have to restart agent]
  * now we can run our build. 
  * for better view - let's split build steps in 2: *npm install* *npm test*
  
### Karma Test Results on the Fly via Service Messages

* let's install dependency of teamcity - *karma*   
``` npm i --save-dev karma-teamcity-reporter ``` - required to pick up test results. 
* in our build step we have to add ``` --reporters teamcity ``` 
* for taking changes automatically we have to add VCS triggers
* with Karma reporter we can see partial test results on build overview 

### Build Configuration Templates
* from previous lessons we did testing for PhantomJS browser, now we want to test it on Chrome and Firefox browsers. We will use templates for this purpose 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img33.JPG)

### Extracting a Build Configuration Template
* it's possible to extract template from build configuration 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img34.JPG)

* after template creation you can see that build configuration is built on template

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img35.JPG)

### Parameterizing a Template
* for parametize template - go to build steps in template and add required parameters. In build steps 2 we will change *phantomjs* to *%Browser%* value

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img36.JPG)

* to define parameter for our step - we have to go to *Parameters* menu. 
* better to keep value empty, so it will be mandatory to enter for any step inside build 
* build will not run until we define required parameter. So we have to go inside build setting check parameter and write down in our case "PhantomJS" value
![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img37.JPG)

### Creating Builds Based on a Template
* Now we're going to create different build configuration for rest browsers. 
* Best way to create another builds click on *Project* and *Edit project settings*
* Here we can manage our Build configurations and Templates 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img38.JPG)

* Here we're creating Build Configuration by defining name, choose template and define required parameters in our case it's Browser 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img39.JPG)

* Install required browsers and create from template configuration builds
  * Chrome
  * Firefox
  
### Dependencies
* Let's create new Build Configuration *Deploy To Staging*
* To establish connection between build configurations and build pipeline - we have to go in *Dependencies* menu. 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img40.JPG)

* We add PhantomJS or Fast Tests in build chain 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img41.JPG)

* for * Deploy to staging * we will choose Chrome and Firefox build configurations. Step 01 already used in our build chain. 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img42.JPG)

* Below you can see *Deployment Pipeline* diagram 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img43.JPG)

### Manually Running a Build Chain
* After running our step 3. *Deploy to Staging* we can see entire picture of our build chain 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img44.JPG)

* take as a note and look at these number, when your build is successfull tests will not run again, so you will not loose any time for testing again. 
* the only number is changes on *Deploy to staging* step. 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img45.JPG)

## Deploying Software with the Build Chain DSL
### TeamCity XML Configuration
* all build configurations stored in .xml file. Stored on TeamCity server

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img47.JPG)

* directory where .xml files stored - *\TeamCity\config\projects* 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img46.JPG)

### Setting up Versioned Settings with Kotlin
* Let's create git hub repo 
* add it in VCS root directory
* go to project settings, in our case JavaScript project
* Select *Versioned Settings* and check *Synchronization enabled* with indicating repo we just created. 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img48.JPG)

* after connecting your VCS to Kotlin you can see .kt file on your repo - which is Kotlin language based on Java 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img49.JPG)

### Changing Settings Through VCS
* clone repo *https://github.com/Bes0n/javascript-settings.git*
* Install IntelliJ
* You can see that message on *Versioned Settings* - * Project settings are stored in Kotlin DSL, consider changing the settings in the Kotlin scripts instead of user interface *
* when we make any change in our setting through IDE and push them from git, so our project automaticall will apply these changes. 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img50.JPG)

* after making required changes you can push it to Git, VCS will catch your changes and apply them. 

* Here I've added new browsers through *settings.kts*

```

project {

    vcsRoot(HttpsGithubComBes0nTeamcityCourseCardsGit)

    buildType(id01FastTests)
    buildType(id02Chrome)
    buildType(id03Firefox)
    buildType(id04DeployToStaging)

    template(Template_1)
}


object id02Chrome : BuildType({
    templates(Template_1)
    id("02Chrome")
    name = "02. Chrome"

    params {
        param("Browser", "Chrome")
    }

    dependencies {
        snapshot(id01FastTests) {
        }
    }
})

object id03Firefox : BuildType({
    templates(Template_1)
    id("03Firefox")
    name = "03. Firefox"

    params {
        param("Browser", "Firefox")
    }

    dependencies {
        snapshot(id01FastTests) {
        }
    }
})

```

### Modifying the Deployment Pipeline Through VCS

* We can make changes - like adding build configurations, build chains etc 
* We can reuse previous scripts to add new tests. 

### Triggering Build Chains
* We've added ne configuration build, but we don't have IE launcher. To install it * npm install karma-ie-launcher --save-dev *

* when you add Kotlin Versioned setting - VCS trigger automatically set to the last step of Build Chain 

### Automating Deployments
* TIme to deploy our project on IIS, we've added some script in Deploy to Staging build. 

```
    steps {
        script {
            name = "IIS Deploy"
            id = "RUNNER_6"
            scriptContent = """
                rmdir /S /Q \inetpub\wwwroot
                xcopy /S /I /Y app \inetpub\wwwroot
            """.trimIndent()
        }
```

* As the result we deployed our project on IIS 

![img](https://github.com/Bes0n/pluralsight/blob/master/teamcity/images/img51.JPG)

