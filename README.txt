What is this?
============

It is a simple regexp list of hostnames collected from spam emails and can be used as a replacement of URIBL list in header and body check files.
Use it carefully.
It was created for my personal purposes and represents my taste. It may harm you mail system.


Usage
=====
postconf -e body_checks='pcre:/etc/postfix/postfix_checks/body_checks_urls, pcre:/etc/postfix/postfix_checks/body_checks_misc'
