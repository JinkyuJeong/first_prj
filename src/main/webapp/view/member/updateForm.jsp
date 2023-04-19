<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
<style type="text/css">
	#title{
    font-family: 'Dongle', sans-serif; 
    text-align: center; 
    font-size: 5em;
    margin-bottom: 4vh;
  }
  .container{width: 70vw;}
  .container.form{ 
    padding-top: 5vh;
    display: flex;
    justify-content: space-evenly;
  }
  .btn{font-family: 'Dongle', sans-serif; font-size: 1.2em;}
  #pic{border-radius: 50%;}
  .form-group{width: 35vw;}
  .form-control, .form-select{display: inline-block;}
  #usr, #sel{width:15vw;}
  .mt-3 .btn{font-size: 24px;}
  .mt-3 .btn:hover {color: lightgray;}
  /* ************************************ */
</style>
<script type="text/javascript">
	function input_check(f){
		if(f.pass.value.trim() === ""){
	    alert("비밀번호를 입력하세요")
	    f.pass.focus();
	    return false;
		}
	}
	
	function win_passChg(){
		let op = "width=500, height=450, left=50, top=150";
		open("pwChgUpdateForm","",op);
	}
	
	function win_upload(){
		let op = "width=500, height=500, left=50, top=150";
		open("pictureForm","",op);
	}
	
	function win_nickChk(){
		const nickname = f.nickname.value.trim();
	  if(nickname == ""){
		    alert("닉네임을 입력하세요")
		    f.nickname.focus();
		    return false;
		}
		const op = "width=400, height=250, left=50, top=150";
		open("nickChk?nickname="+nickname,"",op);
	}
</script>
</head>
<body>
	<form action="update" method="post" name="f" onsubmit="return input_check(this)">
    
		<h1 id="title">회원정보 수정</h1>

		<div class="container form">
      <!-- 왼쪽 사진등록 구역 -->
      <div class="be-light">
        <input type="hidden" name="picture" value="${mem.picture}">
        <img src="${path }/images/basic-profile.JPG" width="200" height="200" id="pic"><br>
        <div align="center"><font size="1"><a href="javascript:win_upload()">사진등록</a></font></div>
      </div>
      <!-- 오른쪽 아이디/비번/닉네임 입력구역-->
      <div>

        <div class="form-group mb-3">
          <label class="mb-1" for="email">이메일</label>
          <div class="input-group mb-3">
            <input type="text" class="form-control" name="email1" readonly value="khb">
            <span class="input-group-text">@</span>
            <input type="text" class="form-control" name="email2" readonly value="naver.com" >
          </div>
        </div>

        <!-- 비밀번호-->
        <div class="form-group">
          <label class="mb-1" for="pwd">비밀번호</label>
          <input type="password" class="form-control mb-4" id="pwd" name="pass">
        </div>
        
        <!-- 닉네임 -->
        <div class="form-group">
          <label class="mb-1" for="pwd">닉네임</label>
          <div class="input-group mb-3">
            <input type="text" class="form-control" name="nickname" id="nickname" value="현재 닉네임">
            <button class="btn btn-outline-secondary" type="button" id="button-addon2" onclick="win_nickChk()">중복검사</button>
          </div>
        </div>
      </div>

		</div>

    <!-- 정보수정 / 비번변경 -->
    <div class="container mt-3" align="center">
      <button type="submit" class="btn">정보수정</button>
      <button type="reset" class="btn ms-2" onclick="win_passChg()">비밀번호변경</button>
    </div>

	</form>
</body>
</html>
