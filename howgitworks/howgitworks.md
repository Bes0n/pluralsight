# How Git Works 
## Module 1: Git Is an Onion
* Distibuted Revision Control System
* Revision Control System
* Stupid Content Tracker
* Persistent Map 

### Meet SHA1 

* Each piece of content is SHA1 
  * ```echo "Apple Pie" | git hash-object --stdin```
  * SHA1s are unique in the universe 
  
### Storing Things
* ```echo "Apple Pie" | git hash-object --stdin -w``` (persistent)
you will get error, there is no repo
* run ```git init``` - to create repository
* objects - where items stored, first 2 digits of SHA1 is folder name

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img1.PNG)

it's called blob of data

* ```git cat-file``` - we can look how git stores objects 
  * ```git cat-file SHA1NUMBER -t ``` - we can see type of file, it's blob
  * ```git cat-file SHA1NUMBER -p  ``` - we can unzip the object. Apple Pie in our key. 
  
### First Commit 
As we disscussed it is stupid content tracker
* ``` git init``` - initiate repo 
* ```git status``` - check for untracked files 
* ```git add```
  * ```git add menu.txt```
  * ```git add recipes/```
* call ```git status``` - you will that they are tracked now. 
* ```git commit -m "First commit!"```
* ```git status``` - you can see that there is nothing to commit anymore 
* ```git log``` - to see details of change. 

Let's go deeper now
* ```git cat-file c1a77b3a1b47e2ad2103d107530559ff3977156f -p```
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
* ```git tag -a mytag -m "I love cheesecake"``` - tag is an object 
* ```git tag``` #output mytag 
* ```git cat-file -p mytag``` - you will get output of object with SHA1 and type of tag - commit 

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
  
## Module 2: Branches Demystified
### What Branches Really Are
* ```git branch``` - show you your current branch
  * in git directory it located in - ref > heads > master 
  * master branch file contains SHA file. 
  * a branch is just a reference to a commit 
  * branch does not have any special creation. It's only reference. 
  * ```git branch branchname``` - adding new branch. 
  * after adding new branch we can see it in refs directory
  
* just a reference to the same commit 
![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img6.PNG)

### The Mechanics of the Current Branch 
* you can see which branch is your current branch from HEAD file also. 
  * ref: refs/heads/master 
* HEAD is just a reference to a branch 

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img7.png)

* for switching from one branch to another use command *git checkout branchname*
* when you run this command 2 things happen:
  * HEAD points to branch you checked
  * content of our tree also changed 
In other words *checkout* means - move head and update the working area. 

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img8.png)

* after checkout to Lisa branch and adding new content to apple pie, we commit the changes. 
  * git adds new commit to the database 
  * head moved also

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img9.png)

### Let's Merge 
We move into the master branch. Let's consider that we like Lisa's recipe more. 
* ```git merge lisa``` - merging with lisa branch. (but we will get error, we have conflicts with files)
* ```git status``` - to check what conflicts we have. 
* open conflicting file manually. 

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img10.png)

You have to decide what changes keep and what to remove. Then save file 
* ```git add``` - recipes.txt
* ```git commit``` 

From git log you can find details of commit and merge of Lisa branch. You can see that there are two parents after merge. 

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img11.png)

*Git created a new commit with two parents to represent the merge, and moved master to point at the new commit. That's how merging works*

### Time Traver for Developers 
* Reference between commits are used to track history 
* All other references are used to track content 
* Focus on content history. 

### Merging Without Merging 
In case of merging Lisa branch with Master branch - *fast forward* will happen. 
We already fixed conflicts with master and lisa branches, before 1st merge. 
It will be wasteful for creating new commit, so if you run ``` git merge master ``` just Fast-Forward appear and move point of Lisa HEAD reference to the master's reference 

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img12.png)

### Losing Your HEAD
* HEAD is a reference to  branch, which in turn in a reference to commit. 
* Instead of checkout a branch, you can checkout a commit.
* ``` git checkout SHA1``` - it called Detached HEAD, you leave any branch.
* you can make commit all directly from this SHA1's but these coommits are not accessible from any branch. 
* garbage collector will remove these commits. 
* you move back to these commits and create branches there. To save these commits. 

### Objects and References
There are Three Rules:
* The current branch tracks new commits
* When you move to another commit, Git updates your working directory
* Unreachable objects are garbage collected

## Module 3: Rebasing Made Simple
### What a Rebase Looks like 
Let's imagine we have 2 branches with different files added. We have another branch - spaghetti with 2 new files added there. 
Instead of merging them and making one commit it's better to rebase branches. 
Rebase actually moves content of spaghetti branch to the master. 

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img13.png)

* after rebase spaghetti branch contains all the commits of master branch plus the spaghetti stuff as we wanted 

* then we can checkout to the master branch and rebase to spaghetti. It will be fast-forwarded merge, as you know already. 

### An Illusion of Movement
* Git cann't just move a commit. Commits are immutable. New commits have different SHA1s.
* when you rebase Git makes a copies of the commits. It creates new commits with mostly the same data. Actually exact the same data with different parents. 
* so these are the same object but with new SHA1s   
* rebasing is an operation that creates new commits

### Taking out the Garbage
* after rebase, old commits will be removed by garbage colletor
* you can access them through the hash codes if you remember them
* Git garbage-collects unreachable objects 

### The Trade-offs of Merges
* Merges preserve history and merges never lie. 

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img14.png)

### The Trade-offs of Rebases
* rebases refactor history 
* rebase history looks cleaner but it's a lie. 
* rebase also cause unwanted side effects 
* when it doubt, just merge 
* rebase - when you know what you doing and you understand the consequences. 

### Tags in Brief
There is a 2 types of tags
* annotated tag
* non-annotated tag
  * ``` git tag -a dinner ```
or you can remove -a and just type ``` git tag dinner ```
  * tags stored in refs/ directory tags folder 
  * ``` cat .git/refs/tags/dinner ```

* A tag is like a branch that doesn't move

## Module 4: Distributed Version Control
### A World of Peers
Let's imagine we uploaded our git repository into the cloud. We want to install it on local computer
* ``` git clone ``` - just copy paste URL from github. 
* you can synchronize with any repo, local one or repo which is on the cloud 

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img15.png)

* All of these clones are peers 

### Local and Remote
* when you clone your repo, git add few lines in .git\config file 
* ``` git branch --all ``` calls the all branches, which are on remote. 
* all branches are still references to commit. Remote branches stored in objects/packed-refs file 
![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img16.png)

* ``` git show-ref master ``` - we can see which commits done. 
* like a local branch, a remote branch is just a reference to a commit 

### The Joy of Pushing
* Each Git object is just a sequence of bytes identified by a SHA1
* Let's imagine that we cloned our repo and have new objects in local repo 

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img17.png)

* after making the change in our local repository, we have to call these commands
  * ``` git add ```
  * ``` git commit -m "update note"```
  * ``` git push ```
  * ``` git show-ref master ``` - we can see that origin state has been updated and referenced to master branch 
  
  
### The Chore of Pulling
* what if we also have commit on our remote branch? There are two options:
  * we can force the push (it's not recommended) by ``` git push -f ``` command 
  * let's do it properly. We need to fix conflict on our machine first 
    * ``` git fetch ``` - we get the new objects from the remote, and we also update the current position of the remote branches as usual. 
	* now we can merge our local changes from remote history 
	
![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img18.png)

* This is what you do
  * fetch 
  * merge 
  * push
  
There is one sigle command for that. Combine them together - ``` git pull ```. A fetch followed by merge. 

### Rebase Revisited
Let's talk about rebase. 
We rolled the change from master into lisa 

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img19.png)

After rebase - commit moves to the master and garbage our previous branch 
Commit with exclamation is a different commit and not the same with yellow one. 

![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img20.png)

We again have a conflict and we can fix it by force-push and after push - everything looks good. But let's imagine we have another developer which still has old commits without exclamation commit. It will be difficult to understand what happened and what causes an error. 

* Never rebase shared commits. It's okay to rebase commit which you didn't shared 

### Getting Social
* there is a good option on GitHub - Fork. We can clone someone's project to our cloud 
* Fork is a kind of clone but clone of GitHub Cloud 
* We have now clone on our github account and can clone in local repository
  * when we do it, git points to our remote repo called *origin*
  * github does know that these 2 projects are connected. So if we want to track changes to the original project then we need to add another remote pointing at original project. We have to do it ourselves. This one called *upstream*
  * we can commit changes to our remote repo (origin) or if there is a changes on original repo *upstream* we can pull them to our local project solve any conflicts and then push them to *origin*
  * but we still couldn't push our commit to upstream, so github provides us an alternative. We can send a message to maintainers of upstream and ask to pull our changes from origin 
  * It's called *pull request* 
  
![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img21.png) 

### The whole Onion 
   
![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img22.png) 
![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img23.png) 
![img](https://github.com/Bes0n/pluralsight/blob/master/howgitworks/images/img24.png) 