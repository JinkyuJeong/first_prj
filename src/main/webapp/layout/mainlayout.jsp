<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<title><sitemesh:write property='title'/></title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script type="text/javascript" src="http://cdn.ckeditor.com/4.5.7/full/ckeditor.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Karma">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
<link href="https://fonts.googleapis.com/css2?family=Dongle&display=swap" rel="stylesheet">

<style>
  .w3-bar-block .w3-bar-item {padding:20px}
	a:hover{color:black;}
  #mySidebar{
    display:none;
    z-index:2;
    width:20%;
    min-width:300px;
  }
  #mySidebar a, #top, #footer, #footer h3{font-family: 'Dongle', sans-serif;}
  #mySidebar> a {font-size: 1.2em;}
  #demoAcc1 a{font-size: 1.4em;}
  #demoAcc2 a{font-size: 1.4em;}
  #flip-horizontal {
    -moz-transform: scaleX(-1);
    -webkit-transform: scaleX(-1);
    -o-transform: scaleX(-1);
    transform: scaleX(-1);
    filter: FlipH;
    -ms-filter: "FlipH";
  }
  #top{border-bottom: 1px solid rgba(0,0,0,0.3);}
  #top .w3-white{
    padding-left: 20px;
    padding-right: 20px;
  }
  #top a{text-decoration: none;}
  #top #center{font-size: 36px;}
  #center a:hover {color: inherit;}
  
  /* 푸터부분 */
  #footer.w3-padding-32 {
    display: flex;
    justify-content: center;
    align-items: center;
  }
</style>
<sitemesh:write property='head'/>
</head>
<body>

<!-- Sidebar (hidden by default) -->
<nav class="w3-sidebar w3-bar-block w3-card w3-top w3-xlarge w3-animate-left" id="mySidebar">
  <a href="javascript:void(0)" onclick="w3_close()" class="w3-bar-item w3-button"><i id="flip-horizontal" class="fa fa-sign-out"></i></a>
  <a href="${path}/release/list"  class="w3-bar-item w3-button">실시간 발매정보</a>
  <a href=""  class="w3-bar-item w3-button">이벤트</a>
  <hr>
  <a onclick="myAccFunc()" href="javascript:void(0)" class="w3-button w3-block w3-white w3-left-align" id="myBtn1">게시판 &nbsp;<i class="fa fa-caret-down"></i></a>
  <div id="demoAcc1" class="w3-bar-block w3-hide w3-padding-large w3-medium">
  	<a href="${path}/board/list?boardType=1" class="w3-bar-item w3-button">자유게시판</a>
	  <a href="${path}/board/list?boardType=2"  class="w3-bar-item w3-button">질문게시판</a>
	  <a href="${path}/board/list?boardType=3"  class="w3-bar-item w3-button">후기게시판</a>
	  <a href="${path}/board/list?boardType=4"  class="w3-bar-item w3-button">공지사항</a>
	</div>
</nav>

<!-- Top menu -->
<div id="top" class="w3-top">
  <div class="w3-white w3-xlarge" style="max-width:100%;margin:auto">
    <div class="w3-button w3-padding-16 w3-left" onclick="w3_open()">&#9776;</div>
    <c:if test="${!empty sessionScope.login}">
    	<div class="w3-right w3-padding-16"><a href="${path}/member/logout">로그아웃</a></div>
	    <div class="w3-right w3-padding-16"><a href="${path}/member/myPage?email=${sessionScope.login}">마이페이지</a>&nbsp;&nbsp;</div>
    </c:if>
    <c:if test="${empty sessionScope.login}">
	    <div class="w3-right w3-padding-16"><a href="${path}/member/joinForm">회원가입</a></div>
	    <div class="w3-right w3-padding-16"><a href="${path}/member/loginForm">로그인</a>&nbsp;&nbsp;</div>
    </c:if>
    <div id="center" class="w3-center w3-padding-16"><a href="${path}">SHOERACE</a></div>
  </div>
</div>
  

<div class="w3-main w3-content w3-padding" style="max-width:100vw;margin-top:50px;min-height:100vh;">
  <hr id="about">

  <sitemesh:write property='body'/>
  
</div>

<hr>
<!-- Footer -->
<footer id="footer" class="w3-row-padding w3-padding-32">
  <div class="w3-third">
    <h3>홈페이지 제작중...</h3>
    <p>제작중입니다~</p>
  </div>
</footer>

<!-- End page content -->


<script>
  function w3_open() {$("#mySidebar").show();}
  function w3_close() {$("#mySidebar").hide();}

  $(document).ready(function() {
    $('#myBtn1, #demoAcc1').mouseenter(function() {
      $('#demoAcc1').addClass('w3-show');
    });

    $('#myBtn1, #demoAcc1').mouseleave(function() {
      $('#demoAcc1').removeClass('w3-show');
    });
  });
</script>

</body>
</html>