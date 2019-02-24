## How Git Works 
- [Module 1: Git Is an Onion](# git-is-an-onion)
- [What Branches Really Are](# what-branches-really-are)

## Git Is an Onion
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
  
## What Branches Really Are
