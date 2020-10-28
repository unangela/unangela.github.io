---
title: Hexo默认主题landscape优化
date: 2018-05-08 14:58:37
tags: Hexo
categories: 工具
---
landscape 作为 Hexo 默认主题还是非常简洁大方的，该有的都有
[Demo](https://unangela.com/postcards)<!--more-->
### 页面banner图替换
图片路径：...\themes\landscape\source\css\images\banner.jpg
分辨率尽量一致：1900*1200，大小不宜过大，否则影响加载，尽量500kb以内。
### 字体&配色&布局
基础样式：...\themes\landscape\source\css\_variables.styl
// Colors
// Fonts
详细文件：...\themes\landscape\source\css\_partial\*.styl
页面布局：...\themes\landscape\layout\*.ejs
### 添加文章评论
+ 注册 Disqus，获得 shortname
+ 打开 ...\themes\landscape\layout\_partial\article.ejs ，在文件最后添加下面的代码：
```
<% if (!index && post.comments){ %>
<section id="comments">
  <div id="disqus_thread"></div>
  <script>
	(function() { 
	var d = document, s = d.createElement('script');
	//下面 shortname 修改为对应的 shortname
	s.src = 'https://shortname.disqus.com/embed.js';
	s.setAttribute('data-timestamp', +new Date());
	(d.head || d.body).appendChild(s);
	})();
  </script>
  <noscript>Please enable JavaScript to view the <a href="https://disqus.com/?ref_noscript">comments powered by Disqus.</a></noscript>
</section>
<% } %>
```