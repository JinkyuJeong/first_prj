<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>제품 상세</title>
<style type="text/css">
	 .w3-tag, .fa {cursor:pointer}
    .w3-tag {height:15px;width:15px;padding:5px;margin-top:0px;}
    .animation_canvas{
      overflow: hidden;
      position: relative;
      width: 900px;
      height: 600px;
    }
    .animation_canvas{
      position: relative;
      margin: 0 auto;
    }
    
    .slider_panel{
      width: ${imgCnt*900}px;
      position: relative;
    }
    .silder_image{
      float: left;
      width: 900px;
      height: 600px;
    }
    .control_panel{
      position: absolute;
      width: 100%;
      height: 50px;
      top:570px;
      font-size: 20px;
    }
	.container{width: 75vw;}
  #info, strong, span, .btn.btn-dark, .mb-3.mt-3{font-family: 'Dongle', sans-serif; font-size: 1.7em;}
</style>
<script>
    $(()=>{
    	  $(".w3-tag.demodots.w3-border.w3-transparent.w3-hover-white").each(function(index){
    	        $(this).attr("idx",index); //idx 속성을 추가 0,1,2,3,4
          }).click(function() {
          let index=$(this).attr("idx");
          moveSlider(index);
        })

      moveSlider(0);  // idx=0으로 시작. 첫번째부터 시작함
      let idx = 0;
      let inc = 1;
      setInterval(function(){
    	  idx += inc;
    	  moveSlider(idx % ${imgCnt});
        
      },3000)

      function moveSlider(index){     // 이미지 이동 함수
        let moveLeft = -(index * 900);
        $(".slider_panel").animate({left:moveLeft},'swing');
        // class="control_button select => 파란점으로표시"
        $(".control_button[idx=" + index + "]").addClass("select");
        $(".control_button[idx!=" + index + "]").removeClass("select");
        $(".w3-tag.demodots.w3-border.w3-transparent.w3-hover-white:nth-child(" + (index + 1) + ")").addClass("w3-white");
        $(".w3-tag.demodots.w3-border.w3-transparent.w3-hover-white:nth-child(n + 1):not(:nth-child(" + (index + 1) + "))").removeClass("w3-white");
      }

    
    })
  </script>
</head>
<body>
	<div class="container">
  <!-- Push down content on small screens -->
  <div class="w3-hide-large" style="margin-top:150px"></div>
  
  <!-- Slideshow Header -->
  <div class="w3-display-container animation_canvas">
      <div class="slider_panel">
      	<c:forEach var="img" items="${imgList }">
        	<img class="silder_image" src="${img }">
        </c:forEach>
      </div>

      <!-- Slideshow next/previous buttons -->
      <div class="control_panel">
        <div>
          <div class="w3-center w3-black" >
          	<c:forEach begin="0" end="${imgCnt-1}" >
            	<span class="w3-tag demodots w3-border w3-transparent w3-hover-white"></span>
            </c:forEach>
          </div>
        </div>
      </div>
    </div>

  <div class="w3-container" id="info">
    <h3 class="text-left mt-5"><strong>${nd.title }</strong></h3>
    <hr>
    
    <h4><strong>내용</strong></h4>
    <p>${nd.content }</p>
  </div>
  <hr>
    <div class="text-center"><a type="button" class="btn btn-dark" href="list">목록으로</a></div>

<!-- End page content -->
</div>
</body>
</html>