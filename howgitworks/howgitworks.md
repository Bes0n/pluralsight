# How Git Works 
## Module 1: Git Is an Onion
* Distibuted Revision Control System
* Revision Control System
* Stupid Content Tracker
* Persistent Map 

### Meet SHA1 

* Each piece of content is SHA1 
  * echo "Apple Pie" | git hash-object --stdin
  * SHA1s are unique in the universe 
  
### Storing Things
* echo "Apple Pie" | git hash-object --stdin -w (persistent)
you will get error, there is no repo
* run git init - to create repository
* objects - where items stored, first 2 digits of SHA1 is folder name

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img1.PNG)

it's called blob of data

* git cat-file - we can look how git stores objects 
  * git cat-file SHA1NUMBER -t - we can see type of file, it's blob
  * git cat-file SHA1NUMBER -p - we can unzip the object. Apple Pie in our key. 
  
### First Commit 
As we disscussed it is stupid content tracker
* git init - initiate repo 
* git status - check for untracked files 
* git add
  * git add menu.txt
  * git add recipes/
* call git status - you will that they are tracked now. 
* git commit -m "First commit!"
* git status - you can see that there is nothing to commit anymore 
* git log - to see details of change. 

Let's go deeper now
* git cat-file c1a77b3a1b47e2ad2103d107530559ff3977156f -p
by this command you can get wide information about commit. 

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img2.PNG)

you can see a *tree* on commit blob, this is also an object with first 2 digits in it. 

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img3.PNG)

by requesting cat file - you can see the SHA1 of your directory and it's tree 

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img4.PNG)

### Versioning Made Easy 
* each commint has it's own parent. 
* git doesn't create new tree for unchanged objects, git stores a new blob for changed file. 

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img5.PNG)


### Annotaded Tags
* git tag -a mytag -m "I love cheesecake" - tak is an object 
* git tag #output mytag 
* git cat-file -p mytag - you will get output of object with SHA1 and type of tag - commit 

Git Object
* Blobs - artibrate content 
* Trees - directories
* Commits 
* Tags 

### What Git really Is
* It looks like a file directories. 
  * Blob - Files 
  * Trees - Directories
  * Links - Links
  * Commits - Versioning
  
## Module 2: What Branches Really Are
* git branch - show you your current branch
  * in git directory it located in - ref > heads > master 
  * master branch file contains SHA file. 
  * a branch is just a reference to a commit 
  * branch does not have any special creation. It's only reference. 
  * git branch branchname - adding new branch. 
  * after adding new branch we can see it in refs directory
  
* just a reference to the same commit 
![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img6.PNG)

### The Mechanics of the Current Branch 
* you can see which branch is your current branch from HEAD file also. 
  * ref: refs/heads/master 
* HEAD is just a reference to a branch 

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img7.PNG)

* for switching from one branch to another use command *git checkout branchname*
* when you run this command 2 things happen:
  * HEAD points to branch you checked
  * content of our tree also changed 
In other words *checkout* means - move head and update the working area. 

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img8.PNG)

* after checkout to Lisa branch and adding new content to apple pie, we commit the changes. 
  * git adds new commit to the database 
  * head moved also

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img9.PNG)

### Let's Merge 
We move into the master branch. Let's consider that we like Lisa's recipe more. 
* git merge lisa - merging with lisa branch. (but we will get error, we have conflicts with files)
* git status - to check what conflicts we have. 
* open conflicting file manually. 

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img10.PNG)

You have to decide what changes keep and what to remove. Then save file 
* git add - recipes.txt
* git commit 

From git log you can find details of commit and merge of Lisa branch. You can see that there are two parents after merge. 

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img11.PNG)
*Git created a new commit with two parents to represent the merge, and moved master to point at the new commit. That's how merging works*