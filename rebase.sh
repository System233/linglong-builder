# Copyright (c) 2024 System233
#
# This software is released under the MIT License.
# https://opensource.org/licenses/MIT

while read line; do
    if grep -q 'appstorev23' "$line" && grep -q "com.uniontech.foundation" "$line"; then
        echo update $line
        DIR=$(dirname "$line")
        sed -i -E -e '/base/ s#com.uniontech.foundation/20.0.1#org.deepin.foundation/23.0.0#g' -e '/runtime/ s#org.deepin.Runtime/20.0.1#org.deepin.Runtime/23.0.1#g' "$line"
        cp -af org.deepin.foundation/sources.list "$DIR/sources.list"
    fi
    # appstorev23
    # apt-cli find $line -c .cache -f ./com.uniontech.foundation/sources.list
done <<<$(find repos -name "linglong.yaml")