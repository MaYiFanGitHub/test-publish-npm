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
    if [ $2 -eq 0 ]; then
        preCommitId=`git rev-parse HEAD`
        git commit -m '构造版本临时提交'
    fi
    username=`npm whoami`

    print "----正在构造版本...----" "[32m"
    version=`npm version $1 -m "$username update to %s"`

    if [ $? -eq 0 ]; then
        print "----构造版本成功，最新的版本号为$version----" "[32m"
        echo $preCommitIdgi
        publish $version $preCommitId
        exit 0
    else
        print "----构造失败----" "[31m"
        
        if [ $2 -eq 0 ]; then
            git reset --soft $preCommitId
        fi
        exit 1
    fi
}

# 发包
function publish() {
    version=$1
    print "----正在发布版本 $version...----" "[32m"
    # npm publish --registry=http://registry.npm.baidu-int.com
    npm publish
    if [ $? -eq 0 ]; then
        now_version=`npm view test-publish-npm-myf version`
        print "----版本发布成功，当前版本号$version----" "[32m"
        print "----请使用 npm i @baidu/med-ui@${version#*v} -S --registry=http://registry.npm.baidu-int.com 更新依赖----" "[32m"
        print "----请自行确认本次更改的代码，是否要推送到远程仓库（git push origin HEAD:refs/for/master）----" 

        exit 0
    else
        git tag -d $version
        print "----发布失败...----" "[31m"

        if [ "$2" != "" ]; then
            git reset --soft $2
        fi
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

# 获取提交文件

git add .

STAGE_FILE=1
if [ "`git diff --cached --name-only`" != "" ]; then
    STAGE_FILE=0
fi

# 发包类型
type=$1
# 判断登陆
is_login
if [ $? -eq 0 ]; then
    build_version $type $STAGE_FILE
    exit 0
else
    print "----登陆或注册失败...----" "[31m"
    exit 1
fi