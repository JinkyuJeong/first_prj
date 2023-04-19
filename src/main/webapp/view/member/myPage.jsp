<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>마이페이지</title>
<style type="text/css">
	/* info.jsp에 들어갈 css속성임 */
	#title{
    font-family: 'Dongle', sans-serif; 
    text-align: center; 
    font-size: 5em;
    margin-bottom: -2vh;
  }
  .container{width: 70vw;}
  .container.form{ 
    padding-top: 5vh;
    display: flex;
    justify-content: space-evenly;
  }
  .btn, h4{font-family: 'Dongle', sans-serif; font-size: 1.2em;}
  #pic{border-radius: 50%;}
  .form-group{width: 35vw;}
  .form-control, .form-select{display: inline-block;}
  #usr, #sel{width:15vw;}
  .mt-3 .btn{font-size: 24px;}
  .mt-3 .btn:hover {color: lightgray;}
</style>
</head>
<body>
	<h1 id="title">마이페이지</h1>

  <!-- About Section -->
  <div class="container form">
    <!-- 왼쪽 사진등록 구역 -->
    <div class="be-light">
      <input type="hidden" name="picture" value="">
      <img src="${path}/images/basic-profile.JPG" width="200" height="200" id="pic"><br>
    </div>
    <!-- 오른쪽 아이디/비번/닉네임 입력구역-->
    <div>
      <!-- 이메일 -->
      <div class="form-group mb-3">
        <label class="mb-1" for="email">이메일</label>
        <div class="input-group mb-3">
          <input type="text" class="form-control" name="email1" readonly value="khb">
          <span class="input-group-text">@</span>
          <input type="text" class="form-control" name="email2" readonly value="naver.com" >
        </div>
      </div>
      
      <!-- 닉네임 -->
      <div class="form-group">
        <label class="mb-1" for="nickname">닉네임</label>
        <div class="input-group mb-3">
          <input type="text" class="form-control" name="nickname" id="nickname" readonly value="고현빈">
        </div>
      </div>
      
      <h4 class="mt-4">가입일자 : 2023-04-16 00:00:00</h4>

      <div class="mt-3">
        <a class="btn" href="myBoardList?email1="><font size="5">게시글 : 10개</font></a>
        <br>
        <a class="btn" href="myCmtList?email1="><font size="5">댓글 : 20개</font></a>
      </div>
    </div>

  </div>
  <br>
  <!-- 회원가입 / 초기화 -->
  <div class="container mt-3" align="center">
    <a class="btn" href="updateForm?email1=">수정</a>
    <a class="btn ms-2" href="deleteForm?email1=">회원탈퇴</a>
  </div>

</body>
</html>