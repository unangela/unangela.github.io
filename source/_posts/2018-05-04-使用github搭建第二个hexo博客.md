---
title: 使用github搭建第二个hexo博客
date: 2018-05-04 09:10:33
tags: Hexo
categories: 工具
---
　　大学时期热爱的明信片事业被生活耽搁了好久，成都的邮路一直不太好，基本上是寄出去没问题，但是收片寥寥无几，丢片率太高了，还是很怀念以前重邮旁边那个小邮局，几乎没有丢过片，最近脑子突然蹦出一个想法，想单独给明信片们开一个记录的网站，可能换片的频率会随着生活忙碌越来越低，但是希望不要丢掉这份初心，认真记录每一张明信片每一个故事。<!--more-->
　　所以开始了搭建第二个博客，这个过程并不是很顺利，开始被 github page 官网的这句话误导了，以为一个账号只能新建一个博客项目，打脸。
>You get one site per GitHub account and organization, and unlimited project sites. Let‘s get started.

　　于是我折腾了很久，新建了一个小号，hexo 搭建流程走了一遍，最后着重在解决怎么让小号大号方便快捷地交替更新和推送操作不同的库，感觉把 git 工具能报的错都遇到了，一言不合就 fatal，很是烦躁，很多错误忘了记录下来，把我还记得的写一下。虽然后来我知道了搭第二个 hexo 博客不需要新建小号，但是这里还是说一下。
　　怎么在一台电脑上使用两个 github 账号，网上查一下大致流程都差不多，具体就不阐述了，方法就是使用 SSH Key。在配置多个 ssh-key 的时候，config 保存后 `ssh -T ***` 测试一直报错，后来发现是空格的问题，网上复制过来的配置文件有缩进空格，把空格删掉就没报错了，不知道是不是只有 windows 系统才会有这个问题。
　　`Could not open a connection to your authentication agent` ，解决办法：执行 `ssh-agent bash`  。当结果是 `Hi username! You've successfully authenticated, but GitHub does not provide shell access.` 的时候就连接成功了。
　　ssh 连接成功了之后就可以单独根据不同的库来管理账号了，在对应的库下面设置 `git config user.name "name"` 和 `git config user.email "email"` 。
　　单独提交推送都没有问题的时候，我以为差不多OK了，用 hexo 指令的时候 hexo d 日志打印 `please tell me who you are` ，大致意思是让我设置全局 user，这下就相悖了，如果设置了 global user，在使用另一个库的时候又要提示 `make sure you have the correct access` 。谜一样的操作，一怒之下还是就用一个账号吧，因为讲道理这是行得通的...事实也证明真的也是行得通的。

那么使用一个账号管理两个 hexo，就是再开一个库的问题而已：
- 新建一个仓库，随便命名 name
- 新建一个备份仓库，name.bak
- 部署 hexo
- config 设置url: `http://yoursite.com/name`，root: ` /name/`
- pull 远端地址设置为那个备份仓库
- OVER

　　真的是太过分啦，明明这么简单！最后还是放一下我的明信片专属博客地址：[Happy Postcrossing](http://unangela.com/postcards)，用的是 hexo 默认的主题 landscape，默认主题还是很简洁很好看的有木有，下一篇就写 landscape 的配置使用教程。