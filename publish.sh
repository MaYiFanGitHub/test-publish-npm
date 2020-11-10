# git add ./
# npm config set registry http://registry.npmjs.org
# npm version patch
# npm publish
# 拿到之前版本号
last_version=`npm view test-publish-npm-myf version`
# 构造一个新的版本号
now_version=`npm version patch`
echo "^$last_version"
echo $now_version

if [ "^$last_version" > $now_version ];then
    echo "不成立"
    exit 1
fi
exit 0
