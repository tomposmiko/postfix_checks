#!/bin/bash

IFS='
'
dir_postfix_checks="/etc/postfix/postfix_checks"

TLD='(com|net)'
cd $dir_postfix_checks || exit 1

if ! git pull|grep -q 'Already up-to-date';
	then
		for domain in `grep -v ^\# domains.txt`;do
			echo "/${domain}([\/\,\ ])?/"   DISCARD DROP: ${domain}|sed "s;TLD;${TLD};g"
		done > body_checks
		sudo /usr/sbin/postfix reload
fi
