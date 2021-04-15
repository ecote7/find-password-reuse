#!/bin/bash
# Determine if a NTLM hash of a an account is equivalent to another user account...you know...to expose some bad practices and maybe slap some sys admin behind the head :P I use it to underline bad practices of users with DA account.
# Create a file with the DA usernames that you wish to search for and save your AD NTLM hashes dump (I use CME export format) into a file.
# Usage example : ./find-password-reuse.sh DA-list.txt AD-Dump.txt [cracked-hashes.txt]
# If you already have cracked a bunch of NTLM hashes, specify the 3rd argument with your "hash:password" format for more pew pew
# Note: This script is provided as is and has not been tested.I know that some validations are missing but hey, it does the job for my needs.

if [ $# -lt 2 ]
then
	echo -e "Make sure you provide at least 2 files as arguments, optionnaly 3."
	echo -e "The 1st file is the users list (one per line), the 2nd the DCSync dump (CME format) and the 3rd one, if you cracked some passwords, hash:password format."
	echo -e "Usage example : ./find-password-reuse.sh DA-list.txt AD-Dump.txt [cracked-hashes.txt]"
	exit
fi

da=$(sort -u $1)
ntlm=""

for d in $da; do
	ntlm="$(cat $2 |grep -i $d|cut -d ":" -f 4)"
	nb=$(grep -o $ntlm $2|wc -l)
	if [ $nb -gt 1 ]
       	then 
		if [ $# == 3 ]
		then
			pass="$(cat $3 |grep $ntlm | cut -d ":" -f 2)"
			echo -e "$d : $ntlm has $nb occurences with password $pass"
			echo -e "$(cat $2 |grep $ntlm | cut -d ":" -f 1)"
		else
			echo -e "$d : $ntlm hash $nb occurences"
			echo -e "$(cat $2 |grep $ntlm | cut -d ":" -f 1)"
		fi
	fi
done
