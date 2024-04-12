# Git Cheatsheet    
[Git style guide](https://github.com/agis/git-style-guide)       

[Clone a Private Repo](https://stackoverflow.com/questions/2505096/clone-a-private-repository-github)       
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