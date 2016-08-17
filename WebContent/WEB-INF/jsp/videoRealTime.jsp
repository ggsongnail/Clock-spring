<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="../../layouts/taglibs.jsp"%>
<html>
<head>
<title>实时视频</title>
<meta charset="utf-8">
<link href="${css}/style.css" rel="stylesheet">
<link href="${ctx}/static/ckplayer/circle.css" rel="stylesheet" type="text/css">
<link href="${ctx}/static/ckplayer/jquery.datetimepicker.css" rel="stylesheet" type="text/css">
<script src="${ctx}/static/ckplayer/jquery.datetimepicker.js"></script>
<script src="${ctx}/static/ckplayer/ckplayer.js" charset="utf-8" type="text/javascript"></script>
<script src="${res}/flatlab/js/jquery.nicescroll.js" type="text/javascript"></script>

<style type="text/css">
.fixedcontrol{position:fixed;top:0px;right:0px;}
.snapimg{left: -287px;position: absolute;}
#lanrenzhijia{ max-height:100px; margin:10px auto; overflow:hidden;}
.dropdown-menu { min-width: auto;}
.vbtn{ display:inline-block; width:85px; height:35px; background-image:url(${img}/help/vbtn.png)}
.vbtn-xuanzhuang{ background-position:0 0}
.vbtn-yushua{ background-position:0 -40px}
.vbtn-dakai{ background-position:0 -80px;width:135px}
.vbtn-denguang1{ background-position:0 -117px}
.vbtn-denguang2{ background-position:0 bottom}
#video_pagination .row{    margin-right: -5px; margin-left: -5px;}
.video-ctr-mask{ width:100%; height:100%;background-color: rgba(255,255,255,0.5); z-index:9999; position:absolute; top:50px; left:0; display:none;}
object, embed {
    width: 100%;
    height: 100%;
    display:block;
    margin: 0;
    /* Below from Eric Meyer's Reset */
    padding: 0;
    border: 0;
    font-size: 100%;
    font: inherit;
    vertical-align: baseline;
}
</style>
</head>
<body>
	<div class="modal fade" id="snapshotview">
		<div class="modal-dialog">
			<div class="modal-content">
				<img id="snapimg" src="" class="snapimg" style="width:1280px;height:720px">
			</div>
		</div>
	</div>
	<div class="container-fluid" id="video_pagination">
		<div class="panel">
			<div class="panel-body">
				<div class="row">
					<div class="col-md-10 ">
						<span class="video-page-show">每页显示：</span>
						<a href="?page.size=1" alt="1" class="video-tab-btn "><i class="fa-4x icon-video1"></i></a>  一屏
						<a href="?page.size=4" alt="4" class="video-tab-btn "> <i class="fa-4x icon-video2"> </i></a>四屏
						<a href="?page.size=6" alt="6" class="video-tab-btn "><i class="fa-4x icon-video3"> </i></a> 六屏
						<a href="?page.size=9" alt="9" class="video-tab-btn "> <i class="fa-4x icon-video4"> </i></a> 九屏
						<a href="?page.size=12" alt="8" class="video-tab-btn "><i class="fa-4x icon-video5"> </i></a>十二屏
						<a href="?page.size=16" alt="16" class="video-tab-btn"> <i class="fa-4x icon-video6"> </i></a>十六屏
					</div>
					<div class="col-md-2">
							<div style="padding-top:10px;">
								<div class="video-total-page">
									<div class="dropdown">
									  <a id="dLabel"  data-toggle="dropdown" aria-haspopup="true" aria-expanded="false" style="cursor:pointer">
									 	   第${pageNumber}页
									    <span class="caret"></span>
									  </a>
									  <ul class="dropdown-menu" aria-labelledby="dLabel" style="z-index:9999999;">
											 <c:forEach var="i" begin="1" end="${pagination}">
												<li role="presentation"><a href="?page=${i}&page.size=${pageSize}" role="menuitem" tabindex="-1">第${i}页</a></li>
											</c:forEach>
									  </ul>
									</div>
								</div>
								<div class="video-total-page">
								共${pagination}页
								</div>
							</div>
					</div>
				</div>
				
			<div class="row">
				<div class="col-md-10">
					<div class="row">
						<c:forEach items="${videoPage.content}" var="video" varStatus="vstatus">
							<div class="col-md-${col}" data-type="${video.type}" style="border:1px solid #aaa;padding:0 0">
								<div class="double" title="双击放大视频 单击选择控制视频" 
									style="z-index:999;background:rgba(0,0,0,0); position: absolute;left:0;width:100%;" 
									onclick="clickBanner('${video.id}','${video.type}','${video.cloudtag}');" 
									ondblclick="oneVideo(this,'${col}')">
								</div>
								<c:if test="${video.type!=1}">
									<div class="novideoall" style="background:url(${ctx}/static/ckplayer/img/img_${col}.png) center center no-repeat;background-size:cover;overflow:hidden; width:100%; height:100%;">
										<div class="video-mask-title">
											<b>[${video.videoName}]&nbsp;</b>
											<a href="javascript:void(0);" class="sendReConnect" data-id="${video.id}">
												<b class="alright"  id="r_${video.id}">重连流</b>
											</a>
										</div>
									</div>
								</c:if>
								<c:if test="${video.type==1}">
									<div id="${video.id}" class="video-td-container selectkibonone"></div>
									<div class="video-mask-title">
										<b>[${video.videoName}]&nbsp;</b>
										<a href="javascript:void(0);" class="sendMainSonRtmp" data-id="${video.id}">
											<b class="alright"  id="r_${video.id}">切换流</b>
										</a>
									</div>
									<script type="text/javascript">
										$(function(){	
											var parent = $('#${video.id}');
											var _width = parent.css("width");
											var _height=($(document).height()-130)/${row};
											var flashvars = {
												p : 1,
												f : '${rtmp}live/${video.source}',
												c : 0,
												wh : _width + ':' + _height,
											};
											var params = {
												bgcolor : '#FFF',
												allowFullScreen : true,
												allowScriptAccess : 'always',
												wmode : 'transparent'
											};
											CKobject.embedSWF('${ctx}/static/ckplayer/ckplayer.swf', '${video.id}', 'ckplayer_${video.id}',
													_width, _height, flashvars, params);
										});
									</script>
								</c:if>
							</div>						
						</c:forEach>
					</div>
				</div>
				<div class="col-md-2" style="padding-top: 3px">
					<div class="row">
						<div class="col-md-5" style="padding-left: 4px;">
							<a id="history" class="btn video-btn-re block-a" style="width: 100%; display: block"><i class="fa  fa-play-circle-o"></i>&nbsp;影像回放</a> <span
								class="help-icon-cls v-huifang" data-placement="bottom"><i class="fa fa-question-circle"></i></span>
						</div>
						<div class="col-md-7">
							<div class="btn video-btn-re reboot" style="width: 100%">
								<i class="fa fa-rotate-right"></i>&nbsp;重启流媒体
							</div>
						</div>
					</div>
					<div class="video-ctrl-btn2">
						<div class="tab_1">
							<a href="javascript:void(0);" class="tab_cloud tab_click" data-type="control" id="tab_control"> 调整云台 </a> <a href="javascript:void(0);"
								class="tab_cloud tab_hold" data-type="menu" id="tab_menu"> 菜单控制 </a>
						</div>
						<div id="controltab" class="">
							<div class="text-center">
								<span class="help-icon-cls v-tiaozheng" data-placement="bottom"><i class="fa fa-question-circle"></i></span> <br />
							</div>
							<div class="text-center video-controller" style="width: 168px; height: 168px">
								<div class="bigcircle" style="position: relative;">
									<div class="circle-refresh littlecircle"></div>
									<div class="circle-refresh littlecircle_ hidden"></div>
									<a href="javascript:void(0);" class="refreshcircle"></a> <a href="javascript:void(0);" class="circle-arrow2 circle-arrow  leftcircle"
										data-control="left"></a> <a href="javascript:void(0);" class="circle-arrow2 circle-arrow  rightcircle" data-control="right"></a> <a
										href="javascript:void(0);" class="circle-arrow2 circle-arrow  topcircle" data-control="up"></a> <a href="javascript:void(0);"
										class="circle-arrow2 circle-arrow  bottomcircle" data-control="down"></a> <a href="javascript:void(0);"
										class="circle-arrow2 circle-arrow  leftcircle_ hidden" data-control="left"></a> <a href="javascript:void(0);"
										class="circle-arrow2 circle-arrow  rightcircle_ hidden" data-control="right"></a> <a href="javascript:void(0);"
										class="circle-arrow2 circle-arrow  topcircle_ hidden" data-control="up"></a> <a href="javascript:void(0);"
										class="circle-arrow2 circle-arrow  bottomcircle_ hidden" data-control="down"></a>
								</div>

								<!-- <div class="circle open">
								<div class="ring">
									<a href="javascript:void(0);" class="menuItem control" data-control="up"><i class="fa fa-play fa-2x up"></i></a>
									<a class="menuItem fa fa-play fa-2x"></a>
									<a href="javascript:void(0);" class="menuItem control" data-control="right"><i class="fa fa-play fa-2x"></i></a>
									<a class="menuItem fa fa-play fa-2x"></a>
									<a href="javascript:void(0);" class="menuItem control" data-control="down"><i class="fa fa-play fa-2x down"></i></a>
									<a class="menuItem fa fa-play fa-2x"></a>
									<a href="javascript:void(0);" class="menuItem control" data-control="left"><i class="fa fa-play fa-2x left"></i></a>
									<a class="menuItem fa fa-play fa-2x"></a>
								</div>
								<a id="refresh" href="javascript:void(0);" class="center fa fa-refresh fa-2x"></a>
							</div> -->
								<%-- <img src="${img}/observation/video-controller.png" /> --%>
							</div>
							<div class="row pdtb6" style="margin-right: 0; margin-left: 0;">
								<div class="col-md-4 pd5">
									<a class="btn btn-success block-a control2" data-control="rotate"><i class="icon-rotate"></i><b>&nbsp;旋转</b></a>
								</div>
								<div class="col-md-4 pd5">
									<a id="wiper" class="btn video-btn-re block-a" data-control="wiper"><i class="fa fa-paint-brush"></i>&nbsp;雨刷</a>
								</div>
								<div class="col-md-4 pd5">
									<a class="btn video-btn-re block-a control2" data-control="light"><i class="fa fa-lightbulb-o"></i>&nbsp;灯光</a>
								</div>
								<div>
									<span class="help-icon-cls v-btn" data-placement="bottom"><i class="fa fa-question-circle"></i></span>
								</div>
							</div>
							<div class="text-center pdtb6">
								<a class="btn video-btn-re control circle-arrow2" data-control="focusadd"><i class="fa fa-plus"></i></a>
								&nbsp;&nbsp;&nbsp;调焦&nbsp;&nbsp;&nbsp; <a class="btn video-btn-re control circle-arrow2" data-control="focusdec"><i class="fa fa-minus"></i></a>
							</div>
							<div class="text-center pdtb6">
								<a class="btn video-btn-re control circle-arrow2" data-control="apertureadd"><i class="fa fa-plus"></i></a>
								&nbsp;&nbsp;&nbsp;光圈&nbsp;&nbsp;&nbsp; <a class="btn video-btn-re control circle-arrow2" data-control="aperturedec"><i
									class="fa fa-minus"></i></a>
							</div>
							<div class="text-center pdtb6">
								<a class="btn video-btn-re control circle-arrow2" data-control="zoomadd"><i class="fa fa-plus"></i></a>
								&nbsp;&nbsp;&nbsp;变倍&nbsp;&nbsp;&nbsp; <a class="btn video-btn-re control circle-arrow2" data-control="zoomdec"><i class="fa fa-minus"></i></a>
							</div>
							<div class="text-center pdtb6">
								<span class="help-icon-cls v-plusminus" data-placement="top"><i class="fa fa-question-circle"></i></span>
							</div>
							<div class="row pdb14" style="margin-right: 0; margin-left: 0;">
								<div class="col-md-3">速度等级</div>
								<div class="col-md-7" style="padding-top: 3px">
									<div id="slider-speed-min" class="slider"></div>
								</div>
								<div class="col-md-2">
									<span class="slider-info" id="slider-speed-amount">X5</span>
								</div>

							</div>
							<div class="row">
								<div class="col-md-12">
									<!-- <div class="btn btn-success reboot">
									<i class="icon-reboot"></i> 重启流媒体服务器
								</div> -->
								</div>
							</div>
							<!-- <div class="row  pdb14">
							<div class="col-md-3 pd0">重连</div>
							<div class="col-md-7">
								<button id="sendReConnect" class="btn btn-info">click</button>
							</div>
						</div> -->
						</div>
						<!-- <div class="text-center pd5">
						<div class="btn-group" role="group" aria-label="...">
							<div class="btn-group" role="group">
								<button type="button" class="btn btn-success dropdown-toggle" data-toggle="dropdown" aria-expanded="false" style="border-radius: 0">
									预置位选择 <span class="caret"></span>
								</button>
								<ul class="dropdown-menu" role="menu">
									<li><a>Dropdown link</a></li>
									<li><a>Dropdown link</a></li>
								</ul>
							</div>
							<button type="button" class="btn btn-success">设置</button>
							<button type="button" class="btn btn-success" style="border-radius: 0">定位</button>
						</div>
					</div> -->
						<div id="menutab" class="hidden">
							<div class="text-center video-controller" style="width: 168px; height: 168px">
								<div class="bigcircle" style="position: relative;">
									<div class="circle-refresh littlecircle"></div>
									<div class="circle-refresh littlecircle_ hidden"></div>
									<a href="javascript:void(0);" class="controlmenu confirmcircle" data-control="menuconfirm"></a> <a href="javascript:void(0);"
										class="controlmenu circle-arrow  leftcircle" data-control="menuleft"></a> <a href="javascript:void(0);"
										class="controlmenu circle-arrow  rightcircle" data-control="menuright"></a> <a href="javascript:void(0);"
										class="controlmenu circle-arrow  topcircle" data-control="menuup"></a> <a href="javascript:void(0);"
										class="controlmenu circle-arrow  bottomcircle" data-control="menudown"></a> <a href="javascript:void(0);"
										class="controlmenu circle-arrow  leftcircle_ hidden" data-control="menuleft"></a> <a href="javascript:void(0);"
										class="controlmenu circle-arrow  rightcircle_ hidden" data-control="menuright"></a> <a href="javascript:void(0);"
										class="controlmenu circle-arrow  topcircle_ hidden" data-control="menuup"></a> <a href="javascript:void(0);"
										class="controlmenu circle-arrow bottomcircle_ hidden" data-control="menudown"></a>



								</div>
								<!-- <div class="circle open">
								<div class="ring">
									<a class="menuItem fa fa-play fa-2x up controlmenu" data-control="menuup"></a>
									<a class="menuItem fa fa-play fa-2x"></a>
									<a class="menuItem fa fa-play fa-2x controlmenu" data-control="menuright"></a>
									<a class="menuItem fa fa-play fa-2x"></a>
									<a class="menuItem fa fa-play fa-2x down controlmenu" data-control="menudown"></a>
									<a class="menuItem fa fa-play fa-2x"></a>
									<a class="menuItem fa fa-play fa-2x left controlmenu" data-control="menuleft"></a>
									<a class="menuItem fa fa-play fa-2x"></a>
								</div>
								<a class="center controlmenu" data-control="menuconfirm"><strong>OK</strong></a>
							</div> -->
								<%-- <img src="${img}/observation/video-controller.png" /> --%>
							</div>
							<div class="row pdb4" style="margin-right: 0; margin-left: 0">
								<div class="col-md-6 pd5">
									<a class="btn video-btn-re block-a controlmenu" data-control="menuopen">打开</a>
								</div>
								<div class="col-md-6 pd5">
									<a class="btn video-btn-re block-a controlmenu" data-control="menuclose">关闭</a>
								</div>
							</div>
						</div>
						<div class="video-ctr-mask"></div>
					</div>
					

				</div>
			</div>
		</div>
		</div>
		
	</div>
	
	<div class="vHuifang" style="display:none;">
		<p><i class="showhelp-ti">说明：</i>监控视频回放功能</p>
		<p><i class="showhelp-ti">操作：</i>1鼠标左键选择回放云台、2鼠标左键点击回放按钮、3选择对应云台回放的起始时间、4点击确定按钮</p>
	</div>
	<div class="vTiaozheng" style="display:none;">
		<p><i class="showhelp-ti">说明：</i>云台方位调整功能</p>
		<div><i class="showhelp-ti">操作：</i> 
		<img src="${img}/help/vtiaozheng.png">
		<p>1鼠标左键按住”向左“按钮控制云台向左旋转</p>
		<p>2鼠标左键按钮”向右“按钮控制云台向右旋转</p>
		<p>3鼠标左键按住”向上“按钮控制云台向上翻转</p>
		<p>4鼠标左键按住 ”向下“按钮控制云台向下翻转</p>
		<p>5鼠标左键点击”刷新“按钮，所有云台自动重新加载</p>
		</div>
	</div>
	<div class="vBtn" style="display:none;">
		<p><i class="showhelp-ti">说明(旋转)：</i>控制云台水平持续旋转功能</p>
		<p><i class="showhelp-ti">操作：</i>鼠标左键点击<span class="vbtn vbtn-xuanzhuang"></span> 按钮开启云台持续水平旋转，再次单击关闭云台持续水平旋转</p>
		<br/>
		<p style="border-top:1px solid #ccc; padding-top:8px;"><i class="showhelp-ti">说明(雨刷)：</i>云台雨刷控制功能</p>
		<p><i class="showhelp-ti">操作：</i>鼠标左键点击<span class="vbtn vbtn-yushua"></span>按钮、2点击菜单控制中的<span class="vbtn vbtn-dakai"></span>按钮、3进入后台设置，选择雨刷设置、4点击开启雨刷。</p>
		<br/>
		<p style="border-top:1px solid #ccc; padding-top:8px;"><i class="showhelp-ti">说明(灯光)：</i>云台灯光控制功能</p>
		<p><i class="showhelp-ti">操作：</i>鼠标左键单击<span class="vbtn vbtn-denguang1"></span>按钮开启云台灯光，再次单击<span class="vbtn vbtn-denguang2"></span>按钮关闭云台灯光。</p>
	</div>
	<div class="vPlusminuus" style="display:none;">
		<p><i class="showhelp-ti">光圈控制功能：</i>鼠标左键点击"+"按钮增加视频摄像头的光圈，鼠标左键点击"-"按钮降低视频摄像头的光圈。</p>
		<p><i class="showhelp-ti">焦距控制功能：</i>鼠标左键点击"+"按钮增加视频摄像头的焦距，鼠标左键点击"-"按钮降低视频摄像头的焦距。</p>
		<p><i class="showhelp-ti">变倍控制功能：</i>鼠标左键点击 "+"按钮增加视频摄像头的变倍，鼠标左键点击"-"按钮降低视频摄像头的变倍。</p>
		<p><i class="showhelp-ti">云台移动速度控制功能：</i>滑动滚动条修改云台设备的移动速度</p>
	</div>
		
	<script src="${ctx}/static/ckplayer/circle.js"></script>
	<script>
		var getColH=($(document).height()-130)/${row};
		$(function() {
			$(".novideoall").css({"height":getColH+"px"});
			//$(".left-row >div").css({"height":getColH+12+"px","overflow":"hidden"});
			$(".video-td-container").css({"height":getColH+"px","overflow":"hidden"});
			$(".double").css({"height":getColH-50+"px"});
			
			window.onbeforeunload = function(event) {
				var selected = $(".selectkibo");
				var videoId = selected.attr("id");
				var flag = "hahah";
				if(videoId!='undefined'){
					$.ajax({
						cache: false,
						url : contextPath+"/observation/video/cloud?videoId=" + videoId + "&command=norotate" + "&dwstep=" + 1 + "&dwstop=" + 1+"&leave="+0,
						success : function(data) {
						}
					});
					$.ajax({
						cache: false,
						url : contextPath+"/observation/video/cloud?videoId=" + videoId + "&command=nolight" + "&dwstep=" + 1 + "&dwstop=" + 1+"&leave="+0,
						success : function(data) {
						}
					});
				}
			};
			$(window).resize(function() {
				vResize();
			});
			disptime();
			
			//帮助提示
			$('.v-huifang').webuiPopover('destroy').webuiPopover($.extend({},
					{title:'视频回放',content:$('.vHuifang').html()}
				));
			$('.v-tiaozheng').webuiPopover('destroy').webuiPopover($.extend({},
					{title:'调整云台',width:'300',content:$('.vTiaozheng').html()}
				));
			$('.v-btn').webuiPopover('destroy').webuiPopover($.extend({},
					{title:'视频：旋转/雨刷/灯光',width:"300",content:$('.vBtn').html()}
				));
			$('.v-plusminus').webuiPopover('destroy').webuiPopover($.extend({},
					{title:'云台光圈间距便倍功能',width:"300",content:$('.vPlusminuus').html()}
				));
			
		});
		function vResize() {
			var videoboxHeight = $(document).height() - 110;
			$(".online-video .panels").css({
				"height" : videoboxHeight + "px"
			});
			$(".videoTabShow-cls .row").css({
				"height" : videoboxHeight + "px"
			});
			//alert(videoboxHeight+"   "+document.body.clientHeight )
		}
		vResize();
		/* $("#lanrenzhijia").niceScroll({
			cursorcolor : "#CC0071",
			cursoropacitymax : 1,
			touchbehavior : false,
			cursorwidth : "5px",
			cursorborder : "0",
			cursorborderradius : "5px"
		}); */
	</script>
</body>
</html>