#!/bin/bash

IFS='
'
dir_postfix_checks="/opt/etc/postfix_checks"

TLD='(com|net)'
cd $dir_postfix_checks || exit 1

if ! git pull|grep -q 'Already up-to-date';
	then
		for domain in `grep -v ^\# domains.txt`;do
			echo "/${domain}([\/\,\ ])?/"	WARN SPAM: ${domain}|sed "s;TLD;${TLD};g"
		done > body_checks
		sudo /opt/zimbra/postfix/sbin/postfix reload
fi
