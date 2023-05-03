<%@page import="model.MemberMybatisDao"%>
<%@page import="model.Member"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>쪽지함</title>
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.nicescroll/3.6.8-fix/jquery.nicescroll.min.js"></script>
<script type="text/javascript">
	$(function(){
    	$(".chat").niceScroll();
    	$("#message").keyup(function(e) {
    		if(e.keyCode == 13) {
    			document.f.submit();
    		}    		
    	})
    	$("#btn").click(function() {
    		document.f.submit();
    	})
	}) 
</script>
<style type="text/css">
body{ margin-top:20px; background:#eee;}
.row.row-broken { padding-bottom: 0;}
.col-inside-lg {padding: 20px;}
.chat {height: calc(100vh - 180px);}
.decor-default {background-color: #ffffff;}
.chat-users h6 {font-size: 20px; margin: 0 0 20px;}
.chat-users #msgBtn {margin: 0 0 20px;}
.chat-users .user {position: relative;padding: 0 0 10px 50px;display: block;cursor: pointer;margin: 0 0 20px;}
.chat-users .user .avatar {top: 0;left: 0;}
.chat .avatar {width: 40px;height: 40px;position: absolute;}
.chat .avatar img {display: block;border-radius: 20px;height: 100%;}
.chat-users .user .name {font-size: 14px;font-weight: bold;line-height: 20px;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;}
.chat-users .user .mood {font: 200 14px/20px "Raleway", sans-serif;white-space: nowrap;overflow: hidden;text-overflow: ellipsis;}

/*****************CHAT BODY *******************/
.chat-body h6 {font-size: 20px;margin: 0 0 20px;}
.chat-body .answer.left {padding: 0 0 0 58px;text-align: left;float: left;}
.chat-body .answer {position: relative;max-width: 600px;overflow: hidden;clear: both;}
.chat-body .answer.left .avatar {left: 0;}
.chat-body .answer .avatar {bottom: 36px;}
.chat .avatar {width: 40px;height: 40px;position: absolute;}
.chat .avatar img {display: block;border-radius: 20px;height: 100%;}
.chat-body .answer .name {font-size: 14px;line-height: 36px;}
.chat-body .answer.left .avatar .status {right: 4px;}
.chat-body .answer .avatar .status {bottom: 0;}
.chat-body .answer.left .text {background: #ebebeb;color: #333333;border-radius: 8px 8px 8px 0;}
.chat-body .answer .text {padding: 12px;font-size: 16px;line-height: 26px;position: relative;}
.chat-body .answer.left .text:before {left: -30px;border-right-color: #ebebeb;border-right-width: 12px;}
.chat-body .answer .text:before {content: '';display: block;position: absolute;bottom: 0;border: 18px solid transparent;border-bottom-width: 0;}
.chat-body .answer.left .time {padding-left: 12px;color: #333333;}
.chat-body .answer .time {font-size: 16px;line-height: 36px;position: relative;padding-bottom: 1px;}
/*RIGHT*/
.chat-body .answer.right {padding: 0 58px 0 0;text-align: right;float: right;}

.chat-body .answer.right .avatar {right: 0;}
.chat-body .answer.right .avatar .status {left: 4px;}
.chat-body .answer.right .text {background: green;color: #ffffff;border-radius: 8px 8px 0 8px;}
.chat-body .answer.right .text:before {right: -30px;border-left-color: green;border-left-width: 12px;}
.chat-body .answer.right .time {padding-right: 12px;color: #333333;}

/**************ADD FORM ***************/
.chat-body .answer-add {
    clear: both;
    position: relative;
    margin: 20px -20px -20px;
    padding: 20px;
    background: green;
}
.chat-body .answer-add input {
    border: none;
    background: none;
    display: block;
    width: 100%;
    font-size: 16px;
    line-height: 20px;
    padding: 0;
}
.chat input {
    -webkit-appearance: none;
    border-radius: 0;
}
.chat-body .answer-add .answer-btn-1 {
    background: url("http://91.234.35.26/iwiki-admin/v1.0.0/admin/img/icon-40.png") 50% 50% no-repeat;
    right: 56px;
}
.chat-body .answer-add .answer-btn {
    display: block;
    cursor: pointer;
    width: 36px;
    height: 36px;
    position: absolute;
    top: 50%;
    margin-top: -18px;
}
.chat-body .answer-add .answer-btn-2 {
    background: url("http://91.234.35.26/iwiki-admin/v1.0.0/admin/img/icon-41.png") 50% 50% no-repeat;
    right: 20px;
}
.chat input::-webkit-input-placeholder {color: #fff;}

.chat input:-moz-placeholder { /* Firefox 18- */color: #fff;  
}

.chat input::-moz-placeholder {  /* Firefox 19+ */color: #fff;  }

.chat input:-ms-input-placeholder {  color: #fff;  }
.chat input {
    -webkit-appearance: none;
    border-radius: 0;
}
</style>
</head>
<body>

	<div class="container">
<div class="content container-fluid bootstrap snippets bootdey">
      <div class="row row-broken">
        <div class="col-sm-3 col-xs-12">
          <div class="col-inside-lg decor-default chat" style="overflow: hidden; outline: none;" tabindex="5000">
            <div class="chat-users">
          <h6>쪽지함</h6>
              <c:forEach var="r" items="${senderInfoMap }" varStatus="st">
              	<c:set var="sender" value="${r.key}" />
  				<c:set var="cnt" value="${r.value.cnt}" />
  				<c:set var="pic" value="${r.value.pic}" />
                <div class="user" onclick="location.href='msgForm?receiver=${r.key}'">                
                    <div class="avatar">
                 	 	<c:if test="${pic=='basic-profile.JPG' }">
      						<img src="${path }/images/basic-profile.JPG"><br>
      					</c:if>
      					<c:if test="${pic != 'basic-profile.JPG' }">
      						<img src="/first_prj/upload/member/${pic}"><br>
      					</c:if>  
                    </div>
                    <div class="name">
                    	${sender}                    	
                    </div>
                    <span class="position-absolute translate-middle badge rounded-pill bg-danger" style="left: 230px; top:10px;">
    						${cnt }
    						<span class="visually-hidden">unread messages</span>
  			  		</span>
                </div>
              </c:forEach>
            </div>
          </div>
        </div>
        <div class="col-sm-9 col-xs-12 chat" style="overflow: hidden; outline: none;" tabindex="5001">
          <div class="col-inside-lg decor-default">
            <div class="chat-body">
              <h6>SHOERACE Chat</h6> 
            </div>
          </div>
        </div>
      </div>
    </div>
 </div>
</body>
</html>