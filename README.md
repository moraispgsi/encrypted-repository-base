# encrypted-repository-base

## Motivation
I was trying to find a way to protect an application database credentials and aws API keys and I found out about blackbox(https://github.com/StackExchange/blackbox) , a tool that allows you to protect secrets in a git repository.

## Requirements
This package requires blackbox installed on ubuntu bash.

## About 
This repository protects the user from accidentally commiting sensitive information. Blackbox saves the public key of the administrators. Sensitive files are added to a bundle of encrypted data and can only be decrypted by the registered administrators private GPG keys. 

## Reading sensitive information

### For windows:

**The following steps are only for reading the files, if the files are edited then you will not be able to encrypt them back. Also be aware that you should never edit the name of the file, if you do so the file will not be shred after the read operation and will most likely be commited to the repository as a regular file in plain-text**

1. Open ubuntu bash.
2. Go to project folder
3. Run the following command to decrypt all files:  
    ```blackbox_decrypt_all_files```  
4. After using the decrypted files,
remove them with the following command:  
    ```blackbox_shred_all_files```

## Editing sensitive information

### For windows:

**Be aware that you should never edit the name of the file, if you do so the file will not be shred after the edit operation and will most likely be committed to the repository as a regular file in plain-text**

1. Start the edit operation for a given blackbox controlled file, e.g.:  
    ```blackbox_edit_start credentials.json```
2. Now you are able to edit the file. After editing the file if you want to replace the previous encrypted file use the following command to end the edit operation:  
    ```blackbox_edit_end credentials.json```


# Commands


**The following commands should be used with care!**

| Name:                               | Description:                                                            |
|-------------------------------------|-------------------------------------------------------------------------|
| `blackbox_edit <file>`              | Decrypt, run $EDITOR, re-encrypt a file                                 |
| `blackbox_edit_start <file>`        | Decrypt a file so it can be updated                                     |
| `blackbox_edit_end <file>`          | Encrypt a file after blackbox_edit_start was used                       |
| `blackbox_cat <file>`               | Decrypt and view the contents of a file                                 |
| `blackbox_diff`                     | Diff decrypted files against their original crypted version             |
| `blackbox_initialize`               | Enable blackbox for a GIT or HG repo                                    |
| `blackbox_register_new_file <file>` | Encrypt a file for the first time                                       |
| `blackbox_deregister_file <file>`   | Remove a file from blackbox                                             |
| `blackbox_list_files`               | List the files maintained by blackbox                                   |
| `blackbox_list_admins`              | List admins currently authorized for blackbox                           |
| `blackbox_decrypt_all_files`        | Decrypt all managed files (INTERACTIVE)                                 |
| `blackbox_postdeploy`               | Decrypt all managed files (batch)                                       |
| `blackbox_addadmin <gpg-key>`       | Add someone to the list of people that can encrypt/decrypt secrets      |
| `blackbox_removeadmin <gpg-key>`    | Remove someone from the list of people that can encrypt/decrypt secrets |
| `blackbox_shred_all_files`          | Safely delete any decrypted files                                       |
| `blackbox_update_all_files`         | Decrypt then re-encrypt all files. Useful after keys are changed        |
| `blackbox_whatsnew <file>`          | show what has changed in the last commit for a given file               |


## GitHooks
This repository has a very simple hook that searches for the files that are currently being protected by blackbox and if they are still available in the repository the hook will not allow you to commit any of the files. Maybe in a later version I will improve it to chech first what was git added and only verify that those files are indeed protected or not.

## FAQ

I'm getting an error when I shred the files using blackbox.
R: Shred in black box is not working in windows bash. This however is only a security addon that you can skip because it only scrambles the files before removing it.

