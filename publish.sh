# git add ./
# npm config set registry http://registry.npmjs.org
# npm version patch
# npm publish


lastversion=`npm view test-publish-npm-myf version`
nowversion=`npm version patch`
echo $lastversion
echo $nowversion
exit 0
# if [ "1.0.8" > "1.0.9" ];then
# echo "[ > ]"
# fi