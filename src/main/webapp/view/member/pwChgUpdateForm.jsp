<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
  <title>비밀번호 변경</title>
  <style>
    .container{margin: 30px auto; padding: 0 50px;}
    h2{margin-bottom: 30px;}
    .container .form-group{position: relative;}
    #minMsg{position: absolute; bottom: 4vh; left: 0; color: red;}
  </style>
  <script>
    function inchk(f){
      if(f.pass.value.trim() === ""){
        alert("비밀번호를 입력하세요.");
        f.pass.focus();
        return false;
      }
      
      if(f.chgpass.value.trim() === ""){
        alert("변경 비밀번호를 입력하세요");
        f.chgpass.focus();
        return false;
      }
      
      if(f.chgpass2.value.trim() === ""){
        alert("변경 재입력 비밀번호를 입력하세요");
        f.chgpass2.focus();
        return false;
      }
      
      if(f.chgpass.value.trim() !== f.chgpass2.value.trim()){
        alert("변경 비밀번호와 변경 재입력 비밀번호가 일치하지 않습니다.");
        f.chgpass2.value = "";
        f.chgpass2.focus();
        return false;
      }
      return true;
    }
    function correctPwChk() {
		let password = document.getElementById("pwd").value;
		let pwPattern = /^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,16}$/;
		let crPwMsg = document.getElementById("crPwMsg");
		if(!pwPattern.test(password)) {
			crPwMsg.innerHTML="유효하지 않은 비밀번호 입니다.";
			crPwMsg.style.color = "red";
			document.getElementById("corpwchk").value = "pwunchecked";
		} else {
			crPwMsg.innerHTML="사용가능한 비밀번호 입니다.";
			crPwMsg.style.color = "blue";
			document.getElementById("corpwchk").value = "pwchecked";
		}
	}
    function checkPasswords() {
		let password = document.getElementById("pwd").value;
		let password2 = document.getElementById("pwd2").value;
		let pwMsg = document.getElementById("pwMsg");
		let corPw = document.getElementById("corpwchk").value;
		if(corPw == "pwunchecked" || password==null || password=="") {
			pwMsg.innerHTML="8~16자리 영대소문자/숫자 조합의 비밀번호를 입력해주세요.";
			pwMsg.style.color = "red";
		} else {
			if(password == password2) {
				pwMsg.innerHTML="비밀번호가 일치합니다.";
				pwMsg.style.color = "blue";
				document.getElementById("pwchkchk").value = "pwchecked";
			} else {
				pwMsg.innerHTML="비밀번호가 일치하지않습니다.";
				pwMsg.style.color = "red";
				document.getElementById("pwchkchk").value = "pwunchecked";
			}
		}		
	}
  </script>
</head>
<body>
    <form action="password2">
    	<input type="hidden" name="email" value="${email }">
      <div class="container">
        <h2>비밀번호 변경</h2>
        <!-- 현재 비밀번호-->
        <div class="form-group">
          <label class="mb-1" for="pass">현재 비밀번호</label>
          <input type="password" class="form-control mb-4" id="pass" name="currentPass">
        </div>
        <!-- 변경 비밀번호-->
        <div class="form-group">
          <label class="mb-1" for="chgpass">변경 비밀번호</label>
          <input type="password" class="form-control mb-4" id="chgpass" name="pass" placeholder="8~16자 영소문자/숫자 조합 특수문자 불가" onkeyup="correctPwChk()">
          <span id="crPwMsg"></span>
          <input type="hidden" id="corpwchk" value="pwunchecked">
        </div>
        <!-- 변경 비밀번호 재입력 -->
        <div class="form-group">
          <label class="mb-1" for="chgpass2">변경 비밀번호 재입력</label>
          <input type="password" class="form-control mb-3" id="chgpass2" name="pass2" onkeyup="checkPasswords()">
          <br>
          <span id="pwMsg"></span>     
          <input type="hidden" id="pwchkchk" value="pwunchecked"> 
        </div>

        <div class="form-group">
          <button type="submit" class="btn btn-dark">변경하기</button>
          <button type="reset" class="btn btn-dark">초기화</button>
        </div>
      </div>
    </form>
</body>
</html>