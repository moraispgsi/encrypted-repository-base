# encrypted-repository-base


This package requires git-secrets installed on ubuntu bash.


gitcmd.sh is necessary because we cant commit the files using windows alone, therefor we need to use the ubuntu bash
to be able to use git-secrets. Another option was to create hooks in the .git/hooks folder and going to the bash for
executing git commits, however this is not very agil because one has to open the bash and got to the path first. Also
we lose some of the control over the commands that should be executed as the hooks are hidden in the .git/hooks folder.
A better solution is to have a simple gitcmd.sh file that can easily executed in windows from a normal CMD.
The gitcmd.sh file has its own commands aswell as some of the git original commands. It wraps every command and ands
 hooks for basic events such as before a particular command is executed as well as after a particular command is executed.
 
 With this we can take into our hand to secure the repository automatically by calling the necessary git-secrets commands
 on the hooks.

