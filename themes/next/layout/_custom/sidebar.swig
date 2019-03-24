<!--网易云音乐外嵌iframe-->
<div>
	<iframe id="iframer" frameborder="no" border="0" marginwidth="0" marginheight="0" width=220 height=52 src=""></iframe>
</div>

<script language='javascript' type='text/javascript'>
	window.onload = function(){
		setTimeout(function () {
			var iframer = document.getElementById("iframer");
			iframer.setAttribute("src","//music.163.com/outchain/player?type=2&id=38358214&auto=1&height=32");
		}, 1000);
	}
</script>