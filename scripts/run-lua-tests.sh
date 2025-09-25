#!/usr/bin/bash
run() {
    local OLD_WD
    export OLD_WD=$PWD
    cd /usr/share/lua-tests/
    lua -e"_U=true" all.lua
    cd $OLD_WD
}
if command -v lua > /dev/null 2>&1
then
    if [[ -d /usr/share/lua-tests ]]
    then
        run
    else
        echo Tests directory non-existent
    fi
else
    echo Lua not found
    exit -1
fi