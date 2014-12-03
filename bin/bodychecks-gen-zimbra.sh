#!/bin/bash

IFS='
'
dir_postfix_checks="/opt/etc/postfix_checks"

TLD='(com|net)'
cd $dir_postfix_checks || exit 1

if git pull|grep -q 'Already up-to-date';
	then
		updated=0
	else
		updated=1
fi

if [ x$1 == x-f ];
	then
		updated=1
fi

if [ $updated -eq 1 ];
	then
		for domain in `grep -v ^\# domains.txt`;do
			echo "/${domain}([\/\,\ ])/   REJECT 'SPAM: `echo ${domain}|sed 's;\[\@\\\/\\\.\\\ \];;'`'"|sed "s;TLD;${TLD};g"
		done > body_checks
		sudo /opt/zimbra/postfix/sbin/postfix reload
fi
