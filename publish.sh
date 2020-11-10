# git add ./
# npm config set registry http://registry.npmjs.org
# npm version patch
# npm publish

# 拿到之前版本号
# last_version=`npm view test-publish-npm-myf version`
# 构造一个新的版本号
# now_version=`npm version patch`
# echo "v$last_version"
# echo $now_version

# if [ "v$last_version" < $now_version ];then
#     echo '不成立'
#     exit 0
# fi
# npm publish
# exit 0

# function pause()
# {
# 　　if [ "x$1" != "x" ] ;then
# 　　　　echo $1
# 　　fi
# 　　if [ $enable_pause -eq 1 ];then
# 　　　　echo "Press any key to continue!"
# 　　char=`get_char`
# 　　fi
# }
# pause "xxx ok"
# echo "请输入npm账号、密码、邮箱"
# npm login
# read -p "任意键继续..."
function npmPublish()
{
    npm version patch
    npm publish
    echo "-----发布完成-----"
}

is_login=`npm whoami`
if [ $? -eq 0 ]; then
    npmPublish
else
    echo '----当前npm用户未登陆，请登陆进行登陆！----'
    npm adduser
fi
# sayhello