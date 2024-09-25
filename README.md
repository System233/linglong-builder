# 玲珑自动化打包器

[![Linglong Builder](https://github.com/System233/linglong-builder/actions/workflows/build.yaml/badge.svg)](https://github.com/System233/linglong-builder/actions/workflows/build.yaml)

## 安装

`yarn install`
或全局安装CLI
`sudo yarn global add linglong-helper@beta apt-cli`

## 命令
`source scripts/env.sh`

* ll-test - 测试程序入口、图标以及安装应用
* ll-clear - 卸载应用，删除linglong/output和linglong/sources，释放builder中的ostree残留
* ll-patch <补丁列表> - 从assets复制补丁
* ll-rebase <模板目录> - 切换当前项目的base和runtime
* ll-find - 从missing.list搜索当前项目缺失的依赖, 必须先构建一次
* add-patch.sh <名称> - 新建补丁脚本，名称为patch_名称.sh
* add-patch-strace.sh - 添加strace补丁，解决启动器+本体模型的应用因启动器退出而导致容器退出的问题
* release-space.sh - 清除buidler缓存中所有除base和runtime的包，以及ll-cli仓库的ostree残留


别名列表
```sh
alias "llb=ll-builder build"
alias "llr=ll-builder run"
alias "llbe=ll-builder build --exec bash"
alias "llre=ll-builder run --exec bash"

alias "lle=ll-builder export"

alias "llcr=ll-cli run"
alias "llci=ll-cli install"
alias "llcu=ll-cli uninstall"
alias "llcl=ll-cli list"
alias "llcp=ll-cli ps"
alias "llcs=rm linglong/sources/*.deb"

alias "llu=ll-helper update --cache-dir ~/.cache/linglong-helper"
alias "llrb=ll-rebase"
alias "llf=ll-find"

alias "llel=ll-builder export -l"

alias "llt=ll-test"
alias "llclr=ll-clear"
```

## 路线图

- [x] 自动构建发布
- [ ] 自动提远程 PR
- [ ] 自动更新仓库
- [x] 集中存储库
- [x] 按需构建

## 文件

- [list.csv](./list.csv) 任务总表
- [filter.list](./filter.list) 构建过滤列表
- [stats.csv](./stats.csv) 测试结果表


## TODO

- [x] 更新ld补丁,避免将CWD加入动态库搜索路径