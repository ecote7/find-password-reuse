# find-password-reuse

Determine if a NTLM hash of a an account is equivalent to another user account...you know...to expose some bad practices and maybe slap some sys admin behind the head :P I use it to underline bad practices of users with DA account.

Create a file with the DA usernames that you wish to search for and save your AD NTLM hashes dump (I use CME export format) into a file.
Usage example : ./find-password-reuse.sh DA-list.txt AD-Dump.txt [cracked-hashes.txt]
If you already have cracked a bunch of NTLM hashes, specify the 3rd argument with your "hash:password" format for more pew pew

Note: This script is provided as is and has not been tested.I know that some validations are missing but hey, it does the job for my needs.
