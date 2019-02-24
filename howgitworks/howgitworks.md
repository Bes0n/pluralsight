## How Git Works 
### Git Is an Onion
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
 
  