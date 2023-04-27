<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SHOERACE</title>
<style type="text/css">
body,h1,h2,h3,h4,h5 {font-family: 'Dongle', sans-serif;}
body {font-size: 16px;}
.mySlides .w3-image {
  min-width: 500px;
  width: 100vw;
  height: 100vh; /* 이미지 높이 고정 */
  object-fit: cover; /* 이미지 비율 유지 */
}
	.jumbo {
	  position: absolute;
	  top: 40%;
	  left: 50%;
	  transform: translate(-50%, -50%);
	  text-align: center;
	  z-index: 1;
	}
	.jumbo h3 {
	  font-size: 100px;
	  color: white;
	  text-shadow: 3px 3px 3px rgba(0, 0, 0, 0.5);
	  margin: 0;
	}
	.jumbo p {
	  font-size: 40px;
	  color: white;
	  text-shadow: 3px 3px 3px rgba(0, 0, 0, 0.4);
	  margin: 0;
	}
	.jumbo a {
	  display: inline-block;
	  padding: 12px 30px;
	  margin-top: 40px;
	  background-color: #007bff;
	  color: white;
	  border-radius: 5px;
	  text-decoration: none;
	}
</style>
</head>
<body>
<div class="w3-content w3-black" style="max-width:2000px;margin: -30px -20px 0;height: 100vh;">
<!-- Header with Slideshow -->
<header class="w3-display-container w3-center">
  <div class="mySlides w3-animate-opacity">
	  <div class="jumbo">
	    <h3 class="display-4 fw-bold mb-4">자유게시판</h3>
	    <p class="mb-4">회원분들과 소통을 하는 공간입니다.</p>
	    <p><a class="btn btn-primary btn-lg" href="${path}/board/list?boardType=1" role="button">바로가기</a></p>
	  </div>
	  <img class="w3-image" src="./images/jumbo.jpg" alt="Image 1" style="min-width:500px" width="1800" height="100%">
	</div>
  
  <div class="mySlides w3-animate-opacity">
	  <div class="jumbo">
	    <h3 class="display-4 fw-bold mb-4">실시간 발매정보</h3>
	    <p class="mb-4">발매예정인 상품들의 정보를 볼 수 있습니다.</p>
	    <p><a class="btn btn-primary btn-lg" href="${path}/release/list" role="button">바로가기</a></p>
	  </div>
	  <img class="w3-image" src="./images/jumbo1.jpg" alt="Image 1" style="min-width:500px" width="1800" height="100%">
	</div>
  
  <div class="mySlides w3-animate-opacity">
	  <div class="jumbo">
	    <h3 class="display-4 fw-bold mb-4">스니커 소식</h3>
	    <p class="mb-4">스니커 소식들을 접해봅니다.</p>
	    <p><a class="btn btn-primary btn-lg" href="${path}/news/list" role="button">바로가기</a></p>
	  </div>
	  <img class="w3-image" src="./images/jumbo2.jpg" alt="Image 3" style="min-width:500px" width="1800" height="100%">
	</div>	
  
  <div class="mySlides w3-animate-opacity">
	  <div class="jumbo">
	    <h3 class="display-4 fw-bold mb-4">EVENT</h3>
	    <p class="mb-4">슈레이스에서 주최하는 응모이벤트!</p>
	    <p><a class="btn btn-primary btn-lg" href="${path }/event/eventForm" role="button">바로가기</a></p>
	  </div>
	  <img class="w3-image" src="./images/jumbo3.jpg" alt="Image 1" style="min-width:500px" width="1800" height="100%">
	</div>
  
  <a class="w3-button w3-black w3-display-left w3-margin-left w3-round w3-hide-small w3-hover-light-grey" onclick="plusDivs(-1)"><i class="fa fa-angle-left"></i> 이전</a>
	<a class="w3-button w3-block w3-black w3-hide-large w3-hide-medium" onclick="plusDivs(-1)"><i class="fa fa-angle-left"></i> 이전</a>
  
  <a class="w3-button w3-black w3-display-right w3-margin-right w3-round w3-hide-small w3-hover-light-grey" onclick="plusDivs(1)">다음 <i class="fa fa-angle-right"></i></a>
  <a class="w3-button w3-block w3-black w3-hide-large w3-hide-medium" onclick="plusDivs(1)">다음 <i class="fa fa-angle-right"></i></a>
</header>
</div>

<script>
// Slideshow
var slideIndex = 1;
showDivs(slideIndex);

function plusDivs(n) {
	  showDivs(slideIndex += n);
	}

	function showDivs(n) {
	  let i;
	  const x = document.getElementsByClassName("mySlides");
	  if (n > x.length) {slideIndex = 1}
	  if (n < 1) {slideIndex = x.length}
	  for (i = 0; i < x.length; i++) {
	    x[i].style.display = "none";  
	  }
	  x[slideIndex-1].style.display = "block";  
	}
setInterval(function() {
	  $(".w3-button.w3-black.w3-display-right").click();
	}, 4500);
</script>
</body>
</html>