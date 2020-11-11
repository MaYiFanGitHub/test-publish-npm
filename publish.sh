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
# function npmPublish()
# {
#     npm version patch
#     npm publish
#     echo "-----发布完成-----"
# }

# is_login=`npm whoami`
# if [ $? -eq 0 ]; then
#     npmPublish
# else
#     echo '----当前npm用户未登陆，请登陆进行登陆！----'
#     npm adduser
# fi
# sayhello

# 输出
function print() {
    color="[33m"
    if [ $2 ]; then
        color=$2
    fi
    echo "\n\033$color$1\033[0m\n"
}

# 构造版本发包
function build_version() {
    print "----正在构造版本...----" "[32m"
    
    version=`npm version patch`

    if [ $? -eq 0 ]; then
        print "----构造版本成功，最新的版本号为$version----" "[32m"
        publish $version
    else
        print "----构造失败, 请保证当前git工作区是干净的----" "[31m"
        exit 1
    fi
}

# 发包
function publish() {
    print "----正在发布版本 $1...----" "[32m"
    npm publish --registry=http://registry.npm.baidu-int.com
    if [ $? -eq 0 ]; then
        print "----版本发布成功，当前版本号XXXX\n请使用 npm i @baidu/med-ui@1.1.1 --registry=http://registry.npm.baidu-int.com 更新依赖----" "[32m"
    else
        print "----发布失败...----" "[31m"
        exit 1
    fi
}

# 判断当前是否登陆
function is_login() {
    npm whoami >/dev/null 2>&1
    if [ $? -eq 1 ]; then
        print "----当前npm用户未登陆，请在下方进行登陆（无账号默认注册）！----"
        npm adduser
    fi
}

# 判断登陆
is_login
if [ $? -eq 0 ]; then
    build_version
else
    print "----登陆或注册失败...----" "[31m"
    exit 1
fi