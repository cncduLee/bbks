<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:set var="ctx" value="${pageContext.request.contextPath }"/> 
<c:set var="ctxStatic" value="${pageContext.request.contextPath}/static"/>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>图书详情</title>



<jsp:include page="../include/script.jsp" flush="false"></jsp:include>
<script type="text/javascript">
	$(function(){
		$(".speak_s .s_con .sure_btn").click(function(){
			console.log("----");
			<c:if test="${empty sessionScope._SIGN_USER_}">
				alert("登陆之后才能评论！");
				return;
			</c:if>
			var contentStr = $("#share_text_t").val();
			if(contentStr == null || contentStr == ""){
				return;
			}
			var data = {
					module: 'book',
					contentId:'${bookInfo.id }',
					content:contentStr,
					title:'${bookInfo.bookName}'
			};
			$.ajax({
			    type: "POST",
			    dataType: "json",
			    data:data,
			    url: '${ctx}/api/comment/add',
			    success: function(result){
					$(".speak_s").hide();
					window.location = "${ctx}/book/search/${bookInfo.id}";
			    },
			    error:function(err){
			    	alert(err);
			    }
			});			
		});
	});
	
	
//兴趣设置
function addInterested(type){
	if("${sessionScope._SIGN_USER_.id }" == ""){
		alert("登陆之后才能继续操作！");	
		return;
	}
	var uid = "${sessionScope._SIGN_USER_.id }";
	var data = {
			userId:uid,
			bookId:"${bookInfo.id}",
			typeId:type
	};
	$.ajax({
	    type: "POST",
	    dataType: "json",
	    data:data,
	    url: '${ctx}/api/interest/addInterest',
	    success: function(result){
	    	var jsonData = eval(result);
	    	console.log(jsonData);
	    },
	    error:function(err){
	    	alert(err);
	    }
	});	
}
</script>
</head>
<body>

<jsp:include page="../include/header.jsp" flush="false"></jsp:include>
<!-- menu bar start-->
<div id="index_warp">
	<div class="W960">
    	<div class="index_menu">
        	<ul>
            	<li><a href="${ctx}" class="index">书城</a></li>
                <li><a href="${ctx}/book/news">新书</a></li>
                <li><a href="${ctx}/book/promotion">特价</a></li>
                <li><a href="${ctx}/book/salerank">热销</a></li>
                <li><a href="${ctx}/book/searchrank">热搜</a></li>
            </ul>
            
            <ul class="ul_user">
                <li><a href="${ctx}/bs/index">书架</a></li>
                <li><a href="${ctx}/user/profile">社交网络</a></li>
            </ul>
        </div>
        <div class="ul_menu">
            <a href="#" class="mulu">目  录</a> 
            <div class="ml_con">
                <p>${bookInfo.directory }</p>
            </div>
            <a href="#" class="online">在线试读</a>
            <div class="online_con">
            	<ul>
                	<li><a href="#">当当读书</a></li>
                </ul>
            </div>
        </div>
        
    </div>
</div>
<!-- menu bar end-->

<!-- book detail start-->
<div  id="pages_book">
	<div class="W960 bg_F fn-clear">
	
		<!-- left start -->
    	<div class="W600">
        	<!-- start base info -->
        	<div class="gb_img">
            	<img src="${bookInfo.coverPic }" width="188" height="258"  alt="" />
            	<div class="gb_img_btn">
            			<c:choose>
	                		<c:when test="${bookInfo.islike }">
	                			  <input type="button" class="gb_img_btn_1 gb_img_btn_3"/>
	                		</c:when>
	                		<c:otherwise>
	                			<input type="button" class="gb_img_btn_1" onclick="addInterested(4);" />
	                		</c:otherwise>
                		</c:choose>
                	
                    	<input type="button" class="gb_img_btn_2" />
                </div>
                <div class="gb_img_span">
                		<c:choose>
	                		<c:when test="${bookInfo.iswantRead }">
	                			  <a href="javascript:void(0);" style="background: #3278ac;">想读</a>
	                		</c:when>
	                		<c:otherwise>
	                			<a href="#" onclick="addInterested(2);">想读</a>
	                		</c:otherwise>
                		</c:choose>
                		<c:choose>
	                		<c:when test="${bookInfo.ishasRead }">
	                			  <a href="javascript:void(0);" style="background: #3278ac;">已读</a>
	                		</c:when>
	                		<c:otherwise>
	                			<a href="#" onclick="addInterested(3);">已读</a>
	                		</c:otherwise>
                		</c:choose>
                		<c:choose>
	                		<c:when test="${bookInfo.reading }">
	                			  <a href="javascript:void(0);" style="background: #3278ac;">已在读</a>
	                		</c:when>
	                		<c:otherwise>
	                			<a href="#" onclick="addInterested(1);">在读</a>
	                		</c:otherwise>
                		</c:choose>
                </div>
            </div>
            <div class="gb_con">
            	<h1>${bookInfo.bookName }</h1>
                <div class="star">
                	<em class="gb_star"></em><em class="gb_star"></em><em class="gb_star"></em><em class="gb_star"></em><em class="gb_star"></em>
                    <span class="fs">4.2</span>
                    <span class="pj">（0人评级）</span>
                </div>
                <div class="text">
                	<p>${bookInfo.outline }</p>
                    
                </div>
                <span class="sq">收起</span>
                <div class="con_info">
                	<ul>
                    	<li><span>作者：</span><a href="#">${bookInfo.author }</a></li>
                        <li><span>译者：</span>${bookInfo.translator }</li>
                        <li><span>出版社：</span>${bookInfo.press }</li>
                        <li><span>版本：</span>${bookInfo.version }</li>
                        <li><a href="#">>更多</a></li>
                    </ul>
                </div>
                <div class="share">
                	<a href="#" class="write">写书评</a>|<a href="#" class="spa">@</a>|<a href="#" class="sha">分享<em></em></a>
                    <div class="speak_s">
                    	<h2>@</h2>
                        <div class="s_con">
                        	<textarea name="" cols="" rows="" class="s_text_t" id="share_text_t"></textarea>
                            <input type="button" class="sure_btn" />
                        </div>
                    </div>
                    <div class="share_p">
                    	<h2><a href="#">分享<em></em></a></h2>
                        <ul>
                        	<li>新浪微博</li>
                            <li>QQ空间</li>
                            <li>人人网</li>
                            <li>腾讯微博</li>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- end of base info -->
            
            
            <!-- start commit and share info -->
            <div class="gb_tab" id="tabBox">
            	<ul class="gb_ul">
                	<li  class="active">图书概述</li>
                    <li>作者简介</li>
                    <li>图书目录</li>
                    <li>图书推荐</li>
                </ul>
                <div class="gb_tab_k">
                	<div class="gb_tab_con"  style="display:block;">
                    	<dl class="gb_list">
                        	<p>${bookInfo.outline }</p>
                        </dl>
                    </div>
                	<div class="gb_tab_con">
                    	<dl class="sp_list">
                    	<p>${bookInfo.authorintro }</p>
                        </dl>
                    </div>
                    <div class="gb_tab_con">
                    	<dl class="gb_list">
                        	<p> ${bookInfo.directory }</p>
                        </dl>
                    </div>
                    <div class="gb_tab_con">
                    	<c:forEach var="comment" items="${commentList }">
                    		<dl class="sp_list">
	                        	<dt><a href="${ctx }/user/detail/${comment.uid }"><img src="${comment.avatar }" width="48" height="48" alt=""></a></dt>
	                            <dd>
	                            	<h3><span class="ds"></span><a href="${ctx }/book/search/${comment.contentId }">${comment.title }</a></h3>
	                                <h4><a href="#">${comment.name }</a><em class="s_on"></em><em class="s_on"></em><em class="s_on"></em><em class="s_on"></em><em class="s_off"></em></h4>
	                                <p>
	                                	${comment.content }
	                                </p>
	                                <h5><span class="time">${comment.createDate }</span><span class="sf"><a href="#">转发</a>|<a href="#">收藏</a>|<a href="#">评论</a></span></h5>
	                            </dd>
	                        </dl>	
                    	</c:forEach>
                    	
                    </div>
                </div>
            </div>
            <!-- end commit and share info -->
            
        </div>
        <!-- left end -->
        
        <!-- right start -->
        <div class="W290">
        
  			<!--start book relation -->		      
        	<div class="reader">
            	<a href="#">${bookInfo.wantRead}想读</a>|<a href="#">${bookInfo.hasRead}人读过</a>|<a href="#">${bookInfo.isReading}在已读</a><em></em>
                <!-- <div class="reader_list">
                	<ul>
                    	<li>162人喜欢</li>
                        <li>162人搜过</li>
                    </ul>
                </div> -->
            </div>
            <!--end book relation -->
            
            <!--start book price -->
            <div class="pb_bj">
            	<h2>定价：${bookInfo.pubPrice} 元</h2>
                <dl class="pb_bj_list">
                	<dt>购买新书</dt>
                    <!-- <dd><span class="dd_money">￥18元</span><a href="#">当当网:</a></dd>
                    <dd><span class="dd_money">￥18元</span><a href="#">当当网:</a></dd>
                     -->
                </dl>
                <dl class="pb_bj_list">
                	<dt>购买二手书</dt>
                    <!-- <dd><span class="dd_money">￥18元</span><a href="#">当当网:</a></dd> -->
                </dl>
                <dl class="pb_bj_list">
                	<dt>购买电子书</dt><!-- 
                    <dd><span class="dd_money">￥18元</span><a href="#">当当网:</a></dd>
                     -->
                </dl>
            </div>
            <!--end book price -->
            
            <!--start book tag -->
            <div class="pb_book_span">
            	<h2><a href="#">书签</a></h2>
                <div class="span_list">
                	<ul> 
                    	<li><a href="#">${bookInfo.category.name }</a></li>
                        <!-- <li><a href="#">德鲁克</a>(725)</li>
                        <li><a href="#">管理的实践</a>(323)</li>
                        <li><a href="#">管理学</a>(254)</li>
                        <li><a href="#">管理经典</a>(163)</li>
                        <li><a href="#">大师</a>(62)</li>
                        <li><a href="#">管理的实践</a>(323)</li>
                        <li><a href="#">管理学</a>(254)</li>
                        <li><a href="#">管理经典</a>(163)</li>
                        <li><a href="#">大师</a>(62)</li>
                         -->
                    </ul>
                    <p><a href="#">>更多</a></p>
                </div>
            </div>
          	<!-- end book tag -->
       		 
       		 <!-- start the similars -->
       		 <div class="pb_col">
            	<div class="title">
                	<h2><a href="#">谁来过这本书...</a></h2>
                </div>
                <div class="col_list">
                	<ul>
                		<c:forEach items="${bookInteresting }" var="item">
                    	<li>
                                <a href="${ctx }/user/detail/${item.user.id}">
                                	<img src="${item.user.avatar }" width="48" height="48" alt="" />
                                    <h5>${item.user.username }</h5>
                                </a>
                                <div class="read_info">
                                    <div class="read_info_base">
                                        <img src="${item.user.avatar }" width="40" height="40" alt="" />
                                        <h2>${item.user.username }</h2>
                                        <h4><span>关注</span> ${item.user.floweds } | <Span>粉丝</Span> ${item.user.flowings } |</h4>
                                        <p>${item.user.description }</p>
                                    </div>
                                    <div class="read_info_btn">
                                        <input type="button" class="btn" />
                                    </div>
                                </div>
                            </li>
                   		</c:forEach>
                   </ul>
                </div>
            </div>
       		 <!-- end the similars -->
        </div>
   		<!-- right ended -->
   </div>
</div>
<!-- book detail end-->

<jsp:include page="../include/index_login.jsp" flush="false"></jsp:include>
<jsp:include page="../include/index_reg.jsp" flush="false"></jsp:include>
<jsp:include page="../include/bookshelf_pop.jsp" flush="false"></jsp:include>

<script type="text/javascript"> 
 function tabMenu(tabBox,navClass){
  var tabNavLi=document.getElementById(tabBox).getElementsByTagName("ul")[0].getElementsByTagName("li");
  var tabCon=document.getElementById(tabBox).getElementsByTagName("div")[0].getElementsByTagName("div");
  var tabLens=tabCon.length;
  for(var i=0;i<tabLens;i++){
  //应用js闭包传入参数i作为当前索引值赋值给m
    (function(m){
   tabNavLi[m].onclick = function(){
    for(var j=0; j<tabLens; j++){
     tabNavLi[j].className = (j==m)?navClass:"";
     tabCon[j].style.display = (j==m)?"block":"";
    }
   }
    })(i); 
  }
 }
//函数调用
window.onload=function(){
 tabMenu("tabBox","active");
}
</script>

</body>
</html>

 