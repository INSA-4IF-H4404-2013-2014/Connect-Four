#!/bin/bash
HOOKFILE=.git/hooks/pre-commit

echo "#!/bin/bash" > $HOOKFILE
echo "cd src" >> $HOOKFILE
echo "./runTest.sh" >> $HOOKFILE
chmod +x $HOOKFILE