#!/bin/bash

IFS='
'

TLD='(com|net)'

for domain in `cat domains.txt`;do
	echo "/${domain}(/, )?/"   DISCARD DROP: ${domain}|sed "s;TLD;${TLD};g"
done
