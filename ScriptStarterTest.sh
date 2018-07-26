#!/bin/bash

function usage()
{
cat << _EOT_

   ScriptStarterTest   
  ---------------------- author: xshoji

  Usage:
    ./$(basename "$0") --scriptPath ScriptStarter.sh
 
  Description:
    This is ScriptStarterTest
 
  Required parameters:
    --scriptPath ScriptStarter.sh : ScriptStarter.sh is specified as scriptPath
 
  Optional parameters:
    --debug,-d : Enable debug mode

_EOT_
exit 1
}




#------------------------------------------
# Preparation
#------------------------------------------

# Parse parameters
for ARG in "$@"
do
    SHIFT="true"
    ([ "${ARG}" == "--debug" ] || [ "${ARG}" == "-d" ]) && { shift 1; set -x; SHIFT="false"; }
    ([ "${ARG}" == "--scriptPath" ] || [ "${ARG}" == "-s" ]) && { shift 1; SCRIPT_PATH=${1}; SHIFT="false"; }
    ([ "${SHIFT}" == "true" ] && [ "$#" -gt 0 ]) && { shift 1; }
done
# Check required parameters
[ -z "${SCRIPT_PATH+x}" ] && { echo "[!] --scriptPath is required. "; INVALID_STATE="true"; }
[ ! -z "${INVALID_STATE+x}" ] && { usage; exit 1; }



#------------------------------------------
# Main
#------------------------------------------
COUNT=1


TEST_FILE=/tmp/test.sh
echo ""
echo "================="
    echo ${COUNT}". error"
COUNT=$(( COUNT + 1 ))
bash ${SCRIPT_PATH}

echo ""
echo "================="
echo ${COUNT}". ok"
COUNT=$(( COUNT + 1 ))
./${SCRIPT_PATH} --naming test --author user > ${TEST_FILE}
chmod 777 ${TEST_FILE}
bash ${TEST_FILE}

echo ""
echo "================="
echo ${COUNT}". execute generated tool"
COUNT=$(( COUNT + 1 ))
./${SCRIPT_PATH} --naming test --author user --required aaa,aaa > ${TEST_FILE}
chmod 777 ${TEST_FILE}
bash ${TEST_FILE}
bash ${TEST_FILE} --aaa aaa

echo ""
echo "================="
echo ${COUNT}". execute generated tool with env"
COUNT=$(( COUNT + 1 ))
./${SCRIPT_PATH} --naming test --author user --required aaa,aaa --env TEST,test > ${TEST_FILE}
chmod 777 ${TEST_FILE}
bash ${TEST_FILE}
bash ${TEST_FILE} --aaa aaa
export TEST=test
bash ${TEST_FILE} --aaa aaa
unset TEST

echo ""
echo "================="
echo ${COUNT}". execute generated tool with option"
COUNT=$(( COUNT + 1 ))
./${SCRIPT_PATH} --naming test --author user --required aaa,aaa --option bbb,bbb > ${TEST_FILE}
chmod 777 ${TEST_FILE}
bash ${TEST_FILE}
bash ${TEST_FILE} --aaa aaa
bash ${TEST_FILE} --aaa aaa --bbb bbb

echo ""
echo "================="
echo ${COUNT}". execute generated tool with option and flag"
COUNT=$(( COUNT + 1 ))
./${SCRIPT_PATH} --naming test --author user --required aaa,aaa --option bbb,bbb --flag ccc > ${TEST_FILE}
chmod 777 ${TEST_FILE}
bash ${TEST_FILE}
bash ${TEST_FILE} --aaa aaa
bash ${TEST_FILE} --aaa aaa --bbb bbb
bash ${TEST_FILE} --aaa aaa --bbb bbb --ccc

echo ""
echo "================="
echo ${COUNT}". execute generated tool without required parameter"
COUNT=$(( COUNT + 1 ))
./${SCRIPT_PATH} --naming test --author user --option bbb,bbb --flag ccc > ${TEST_FILE}
chmod 777 ${TEST_FILE}
bash ${TEST_FILE}
bash ${TEST_FILE} --bbb bbb
bash ${TEST_FILE} --bbb bbb --ccc

echo ""
echo "================="
echo ${COUNT}". execute generated tool strange order parameters"
COUNT=$(( COUNT + 1 ))
./${SCRIPT_PATH} --xxx --flag ccc --yyy --option bbb,bbb --required xxx,xxx --naming test --author user > ${TEST_FILE}
chmod 777 ${TEST_FILE}
bash ${TEST_FILE}
bash ${TEST_FILE} --xxx xxx
bash ${TEST_FILE} --bbb bbb --xxx xxx
bash ${TEST_FILE} --bbb bbb --ccc --xxx xxx
bash ${TEST_FILE} --debug 
bash ${TEST_FILE} --debug --xxx xxx

echo ""
echo "================="
echo ${COUNT}". execute generated tool strange order parameters shorten"
COUNT=$(( COUNT + 1 ))
./${SCRIPT_PATH} --xxx -f ccc --yyy -o bbb,bbb -r xxx,xxx -n test -a user > ${TEST_FILE}
chmod 777 ${TEST_FILE}
bash ${TEST_FILE}
bash ${TEST_FILE} --xxx xxx
bash ${TEST_FILE} --bbb bbb --xxx xxx
bash ${TEST_FILE} --bbb bbb --ccc --xxx xxx
bash ${TEST_FILE} --debug 
bash ${TEST_FILE} --debug --xxx xxx

echo ""
echo "================="
echo ${COUNT}". execute generated tool strange order parameters shorten"
COUNT=$(( COUNT + 1 ))
./${SCRIPT_PATH} --xxx -f ccc --yyy -o bbb,bbb -r xxx,xxx -n test -a user -s > ${TEST_FILE}
chmod 777 ${TEST_FILE}
bash ${TEST_FILE}
bash ${TEST_FILE} --xxx xxx
bash ${TEST_FILE} -b bbb -x xxx
bash ${TEST_FILE} -b bbb -c -x x
bash ${TEST_FILE} --debug
bash ${TEST_FILE} --debug -x xxx

echo ""
echo "================="
echo ${COUNT}". execute generated tool strange order parameters shorten with description"
COUNT=$(( COUNT + 1 ))
./${SCRIPT_PATH} --xxx -f ccc --yyy -o bbb,bbb -r xxx,xxx -n test -a user -s -d "Test script" > ${TEST_FILE}
chmod 777 ${TEST_FILE}
bash ${TEST_FILE}
bash ${TEST_FILE} --xxx xxx
bash ${TEST_FILE} -b bbb -x xxx
bash ${TEST_FILE} -b bbb -c -x x
bash ${TEST_FILE} --debug
bash ${TEST_FILE} --debug -x xxx

rm -rf ${TEST_FILE} 