<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입</title>
<style type="text/css">
	/* JoinForm.jsp에 들어갈 css속성임 */
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
  .btn{font-family: 'Dongle', sans-serif; font-size: 1.2em;}
  #pic{border-radius: 50%;}
  .form-group{width: 35vw;}
  .form-control, .form-select{display: inline-block;}
  #usr, #sel{width:15vw;}
  span.ms-3{color:blue;}
  .container .form-group:nth-child(3){position: relative;}
  #minMsg{position: absolute; bottom: 2.7vh; left: 0; color: red;}
  .mt-3 .btn{font-size: 24px;}
  .mt-3 .btn:hover {color: lightgray;}
  #authMsg{font-size:10px;}
  #cor1, #cor2{position:relative;}
  #pwMsg, #crPwMsg{font-size:10px; margin-top:-2vh; position:absolute; bottom:0; left:0;}
  /* ************************************ */
</style>
<script>
	function input_check(f){
	  if(f.email1.value.trim() == "" ){
	    alert("이메일을 입력하세요")
	    f.email1.focus();
	    return false;
	  }
	  if(f.email2.value.trim() == "" ){
		    alert("이메일을 입력하세요")
		    f.email2.focus();
		    return false;
		  }
	  if(f.pass.value.trim() == ""){
	    alert("비밀번호를 입력하세요")
	    f.pass.focus();
	    return false;
	  }
	  
	  if(f.nickname.value.trim() == ""){
	    alert("닉네임을 입력하세요")
	    f.nickname.focus();
	    return false;
	  }
	  if(f.emailchkchk.value != "emailchecked") {
  		alert("이메일 인증을 해주세요.");
  		return false;
  	  }
	  if(f.pwchkchk.value != "pwchecked") {
		alert("비밀번호를 확인 해주세요.");
		return false;
	  }
	  if(f.nicknamechkchk.value != "nicknamechecked") {
		alert("닉네임 중복검사를 해주세요.");
		return false;
	  }
	  return true;
	}
	
	function win_upload(){
		let op = "width=600, height=500, left=50, top=150";
		open("pictureForm","",op);
	}
	
	function win_open(page){		
		if(f.email1.value == "") {
    		alert("이메일을 입력하세요.");
    		f.email1.focus();
    		return;
    	} else if(f.email2.value == "") {
    		alert("이메일을 입력하세요.");
    		f.email2.focus();
    		return;
    	} else {
    		let email1 = document.f.email1.value;
    		let email2 = document.f.email2.value;
    		let email = email1 + "@" + email2;
    		let op = "width=500, height=300, left=50, top=150";
    	    open(page+"?email="+ email,"",op);
    	}	    
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
	function checkPasswords() {
		let password = document.getElementById("pwd").value;
		let password2 = document.getElementById("pwd2").value;
		let pwMsg = document.getElementById("pwMsg");
		if(password == password2) {
			pwMsg.innerHTML="비밀번호가 일치합니다.";
			pwMsg.style.color = "blue";
			document.getElementById("pwchkchk").value = "pwchecked";
		} else {
			pwMsg.innerHTML="비밀번호가 일치하지않습니다.";
			pwMsg.style.color = "red";
		}
	}
	function correctPwChk() {
		let password = document.getElementById("pwd").value;
		let pwPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,16}$/;
		let crPwMsg = document.getElementById("crPwMsg");
		if(!pwPattern.test(password)) {
			crPwMsg.innerHTML="유효하지 않은 비밀번호 입니다.";
			crPwMsg.style.color = "red";
		} else {
			crPwMsg.innerHTML="사용가능한 비밀번호 입니다.";
			crPwMsg.style.color = "blue";
		}
	}
</script>
</head>
<body>
	<form action="join" method="post" name="f" onsubmit="return input_check(this)">
	<h1 id="title">회원가입</h1>
		
		<div class="container form">
      <!-- 왼쪽 사진등록 구역 -->
      <div class="be-light">
        <input type="hidden" name="picture" value="basic-profile.JPG">
        <img src="${path }/images/basic-profile.JPG" width="200" height="200" id="pic"><br>
        <div align="center"><font size="1"><a href="javascript:win_upload()">사진등록</a></font></div>
      </div>
      <!-- 오른쪽 아이디/비번/닉네임 입력구역-->
      <div>
        <!-- 이메일 -->
        <div class="form-group mb-3">
          <label class="mb-1" for="email1">이메일</label>
          <div class="input-group mb-3">
            <input type="text" class="form-control" name="email1" id="email1" placeholder="아이디" aria-label="Username">
            <span class="input-group-text">@</span>
            <select class="form-select" name="email2">
            	<option value="naver.com">naver.com</option>
            	<option value="nate.com">nate.com</option>
            	<option value="gmail.com">gmail.com</option>
            	<option value="hanmail.net">hanmail.net</option>
            	<option value="daum.net">daum.net</option>
            </select>
<!--          <input type="text" class="form-control" name="email2" id="email2" placeholder="Example.com" aria-label="Server">  -->   
          </div>
          <button type="button" class="btn btn-dark" onclick="win_open('emailForm')">이메일인증</button>
          
          <span class="ms-3" id="authMsg"></span>
          
          <input type="hidden" name="emailchkchk" value="emailunchecked"> 
        </div>
        <!-- 비밀번호-->
        <div id="cor1" class="form-group">
          <label class="mb-1" for="pwd">비밀번호</label>
          <input type="password" class="form-control mb-4" id="pwd" name="pass" placeholder="8~16자 영대소문자/숫자 조합 특수문자 불가" onkeyup="correctPwChk()"> 
          <span id="crPwMsg"></span>
        </div>
        <!-- 비밀번호 재입력 -->
        <div id="cor2" class="form-group">
          <label class="mb-1" for="pwd2">비밀번호 재입력</label>
          <input type="password" class="form-control mb-4" id="pwd2" name="pass2" onkeyup="checkPasswords()">
          <span id="pwMsg"></span>     
          <input type="hidden" id="pwchkchk" value="pwunchecked"> 
          
        </div>
        <!-- 닉네임 -->
        <div class="form-group">
          <label class="mb-1" for="nickname">닉네임</label>
          <div class="input-group mb-3">
            <input type="text" class="form-control" name="nickname" id="nickname" placeholder="최대 8자, 부적절한 닉네임 사용금지">
            <button class="btn btn-outline-secondary" type="button" id="button-addon2" onclick="win_nickChk()">중복검사</button>
            <input type="hidden" id="nicknamechkchk" value="nicknameunchecked">
          </div>
        </div>
      </div>

		</div>

    <!-- 회원가입 / 초기화 -->
    <div class="container mt-3" align="center">
      <button type="submit" class="btn">회원가입</button>
      <button type="reset" class="btn ms-2">초기화</button>
    </div>

	</form>
</body>
</html>