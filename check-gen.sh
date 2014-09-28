#!/bin/bash

IFS='
'

TLD='(com|net)'

for domain in `cat domains.txt`;do
	echo "/[@/. ]${domain}([?!#,. ])/"   DISCARD DROP: ${i}|sed "s;TLD;"${TLD};"
done
