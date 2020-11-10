git add ./
npm config set registry http://registry.npmjs.org
npm version patch
npm publish

echo "----发布成功----"