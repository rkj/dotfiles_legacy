#!/bin/sh

hg log --template '{files}\n' | tr ' ' '\n' | sort | egrep -v '^$' | uniq -c | sort -n

