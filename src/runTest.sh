#!/bin/bash
cd "$(dirname "$0")"

LOADFILE='swipl-load.gitlocal'
EXECFILE='swipl-exec.gitlocal'

ARG1=$1

echo "halt." | swipl -s testAll.pl -g testAll. 1> $EXECFILE 2> $LOADFILE

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
	BUFFER+="Some unit tests have \033[1;31mFAILED\033[m.\n"
	cat $EXECFILE
fi

rm -f $LOADFILE

if [ $FAILED -eq 0 ]; then
	if [ "$ARG1" != "-q" ]; then
		cat $EXECFILE
		echo -e "\033[1;32mAll tests \033[0m\033[1m\033[42mPASSED\033[0m\033[1;32m!\033[0m"
	fi
	rm -f $EXECFILE
	exit 0
fi

rm -f $EXECFILE
echo -ne "\n$BUFFER"
echo -e "\033[1m\033[41mPlease fix them before committing.\033[m"

exit 128
