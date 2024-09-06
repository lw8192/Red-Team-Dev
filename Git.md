# Git Cheatsheet    
[Git style guide](https://github.com/agis/git-style-guide)            
[Clone a Private Repo](https://stackoverflow.com/questions/2505096/clone-a-private-repository-github)        
## Common commands   
git workflow: clone repo, make changes, stage changes (using add), commit changes then push   
clone repo using an access token:     
> git clone https://<pat>@github.com/<your account or organization>/<repo>.git

status (you want all green):      

> git status        
look at logs:     

> git log --oneline       
current remote connections (PATs being used):    

> git remote -v         
add everything but untracked files to be staged:    

> git add -u       
commit changes to a repo with an update message:    

> git commit -m "moved all images to a different folder"      

push to main branch:     

> git push origin main         
## Fixing Mistakes   
Reset commit if not pushed (discard your changes):    

> git reset HEAD~1    
> git status   #check status for a clean copy     
If pushed to remote:    

> git revert HEAD    #reset commit   

## Branches       
> git checkout -b branch_name    #create a new branch and switch to it    
> git checkout branch_name       #switch to a branch, then commit some changes     
> git checkout main              #switch to the main branch   
> git merge branch_name          #merge the branch into main  
> git branch -d branch_name      #delete branch post merge   
Merge conflicts:    
> git status    #check for unmerged changes, manually resolves the conflicts.  