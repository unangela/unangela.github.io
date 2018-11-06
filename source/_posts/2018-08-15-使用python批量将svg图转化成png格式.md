---
title: 使用python批量将svg图转化成png格式
date: 2018-08-08 09:43:22
tags: Python
categories: 编程
---
　　emm，之前下了一个fluffy house的一个修图软件,彩虹妹妹真的太可爱了。
　　<img src="http://wx2.sinaimg.cn/mw690/61b81d32gy1fua493tti5j20qo0qoab3.jpg" width=120px>
　　But，iOS里面的贴图都要收费，去下了一个安卓版，果真安卓版本里是免费的，赤果果的对iOS用户的歧视。
　　实在是喜欢，就想说利用安卓包扒下来收藏（这里显然不太道德...所以不能分享），
　　解包发现了里面所有图片都是SVG格式的。。
　　要是一张一张通过浏览器另存为png也太没有效率了，
　　网上一查，发现可以利用python进行批量转换（也估计有其他工具，不过玩一下python也挺好的）<!--more-->
　　[<网上的代码>](http://www.qttc.net/201401401.html)
　　
**好记性不如烂笔头**
- python 安装的时候有个勾勾记得勾上 `Add python to PATH`
- pip install 超时，使用镜像
- `import cairosvg` 的时候报了很多模块找不到的错，到最后装了这么多Package
<img src="http://wx4.sinaimg.cn/large/61b81d32gy1fua5k9ahwpj20km06jq30.jpg">
- 模块不报错了又来一个报错 `dlopen() failed to load a library: cairo / cairo-2` [< 解决办法 GTK >](https://blog.csdn.net/hacklyc/article/details/77101965)
- 终于运行成功，但导出的png尺寸太小，放大很模糊。看了一下[< CairoSVG 官方文档 >](https://cairosvg.org/documentation/)，在导出的那句代码里加了一句属性，将规格设置了6倍 ：`cairosvg.svg2png(bytestring=svg, scale=6, write_to=exportPath)` ，完美。
- Pycharm 的安装与[破解激活](https://blog.csdn.net/u014044812/article/details/78727496)（本来没有下载IDE，但是在下载python库的时候发现，pip不好使，用工具直接下载库很方便）
- print 在 python2.x 和 3.x 有区别，文章这个代码是针对2.x的

*写完这个决定去学一学 python 语法，感觉 python 可以做一些有趣的事情*