#!/bin/bash
LOADFILE='swipl-load.gitlocal'
EXECFILE='swipl-exec.gitlocal'

echo "halt." | swipl -f testAll.pl -g testAll. 1> $EXECFILE 2> $LOADFILE

FAILED=0
BUFFER=''
grep -q "ERROR: " $LOADFILE > /dev/null 2>&1
if [ $? -eq 0 ]; then
	FAILED=1
	BUFFER="You've Prolog compilation \033[1;31mERRORS\033[m.\n"
fi

grep -q "Warning: " $LOADFILE > /dev/null 2>&1
if [ $? -eq 0 ]; then
	FAILED=1
	BUFFER+="You've Prolog compilation \033[1;31mWARNINGS\033[m.\n"
fi

if [ $FAILED -ne 0 ]; then
	cat $LOADFILE
fi

grep -q ": Failed" $EXECFILE > /dev/null 2>&1
if [ $? -eq 0 ]; then
	FAILED=1
	BUFFER+="Some unit tests have \033[1;31mFAILLED\033[m.\n"
	cat $EXECFILE
fi

rm -f $LOADFILE $EXECFILE

if [ $FAILED -eq 0 ]; then
	exit 0
fi

echo -ne "\n$BUFFER"
echo -e "\033[1m\033[41mPlease fix them before committing.\033[m"

exit 128
