# git add ./
# npm config set registry http://registry.npmjs.org
npm version patch
# npm publish
echo $?
echo "----发布成功----"
exit 1