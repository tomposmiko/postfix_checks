#!/bin/bash

IFS='
'
dir_postfix_checks="/etc/postfix/postfix_checks"

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
		for url in `grep -v ^\# urls.txt`;do
			echo "/${ur}([,>\*\/\ ]|$)/   REJECT 'SPAM: `echo ${url}|sed 's,\[\@\\\/\\\.\\\ \],,'`'"|sed "s,TLD,${TLD},g"
		done > body_checks_urls
echo > body_checks_urls
		sudo /usr/sbin/postfix reload
fi

echo > body_checks_misc

if [ $updated -eq 1 ];
    then
        for misc in `grep -v ^\# misc.txt`;do
            echo "/${misc}/   REJECT 'SPAM: ${misc}'"|sed "s;TLD;${TLD};g"
        done > body_checks_misc

echo > body_checks_misc
        sudo /usr/sbin/postfix reload
fi
