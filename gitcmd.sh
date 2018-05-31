#!/bin/bash

##Remove the following warning: "warning: CRLF will be replaced by LF"
#git config --global core.safecrlf false
#git config core.autocrlf true
#git config core.safecrlf false


#For allowing the read command to work
exec < /dev/tty



#------------------------------------------------------#
#                       Hooks                          #
#------------------------------------------------------#
#                                                      #

            # Runs before every git command
            on_before_command () {
                echo 'HOOK: on-before-command'
            }

            #Runs after every git command
            on_after_command () {
                echo 'HOOK: on-after-command'
            }

            # Runs before every git commit
            on_before_commit () {
                echo 'HOOK: on-before-commit'
            }

            #Runs after every git commit
            on_after_commit () {
                echo 'HOOK: on-after-commit'
            }

            # Runs before every git add
            on_before_add () {
                echo 'HOOK: on-before-add'
            }

            #Runs after every git add
            on_after_add () {
                echo 'HOOK: on-after-add'
            }

            #Runs before every git pull
            on_before_pull () {
                echo 'HOOK: on-after-pull'
            }

            #Runs after every git add
            on_after_pull () {
                echo 'HOOK: on-after-pull'
            }


#                                                      #
#------------------------------------------------------#
#                     Functions                        #
#------------------------------------------------------#
#                                                      #

        #Check if a command is available
        check_command () {
            #If is empty
            if [ -z ${1} ]; then
                return 1
            fi

            #Check if the command exists
            case ${1} in
                ("commit") return 0; break;;
                ("add") return 0; break;;
                ("pull") return 0; break;;
                (*) return 0;;
            esac
        }

        execute_command_with_wrapper () {
            on_before_command "$@"
            case ${1} in
                ("commit")
                    on_before_commit "$@"
                    echo 'commit'
                    git $@
                    on_after_commit "$@"
                ;;
                ("add")
                    on_before_add "$@"
                    echo 'add'
                    git $@
                    on_after_add "$@"
                ;;
                ("pull")
                    on_before_pull "$@"
                    echo 'pull'
                    git $@
                    on_after_pull "$@"
                ;;
                (*)
                    git $@
                ;;
            esac
            on_after_command "$@"
        }

#                                                      #
#------------------------------------------------------#


#First check if the first argument is a valid command
if check_command ${1}; then
    echo 'Command was found'
    #Forward all arguments to the wrapper function
    execute_command_with_wrapper "$@"
else
    echo 'Command not found'
fi













#
#printf '--------------------------------------------------------------------------------------------------------'
#printf '                                                                                                        '
#printf '                                                                                                        '
#printf '                                                                                                        '
#printf '--------------------------------------------------------------------------------------------------------'
#
#
#
#
#
#while true; do
# read -p "Are you sure you want to commit(y-yes | n-no)?" yn
# case $yn in
#    [Yy]* )
#      blackbox_shred_all_files &> /dev/null
#      echo "Managed files were shreded successfully."
#      exit 0;;
#    [Nn]* ) exit 1;;
#        * ) echo "Please answer yes or no.";;
# esac
#done
##