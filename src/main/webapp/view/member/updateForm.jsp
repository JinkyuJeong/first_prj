<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원정보수정</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
<style type="text/css">
	#title{
    font-family: 'Dongle', sans-serif; 
    text-align: center; 
    font-size: 5em;
    margin-bottom: 7vh;
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
  #basic {cursor:pointer;}
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
		if(document.f.pass.value.trim() === "") {
			alert("비밀번호를 입력하세요")
		    f.pass.focus();
		    return false;
		}
		let email1 = document.f.email1.value;
		let email2 = document.f.email2.value;
		let email = email1+"@"+email2;
		let op = "width=500, height=450, left=50, top=150";
		open("pwChgUpdateForm?email="+email,"",op);
	}
	
	function win_upload(){
		let op = "width=600, height=500, left=50, top=150";
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
	$(function() {
		$.ajax({
			url : "/first_prj/ajax/basicForm",
			type : "POST",
			success : function(result) {
				$("#picUpdate").html(result)
			},
			error : function(e) {
				alert("이미지 처음 로드" + e.status)
			}
		})
		$("#update").click(function() {
			if(f.pass.value.trim() === "") {
				alert("비밀번호를 입력하세요")
			    f.pass.focus();
			    return false;
			}
		})
	})
</script>
</head>
<body>
	<form action="update" method="post" name="f" onsubmit="return input_check(this)">
    
		<h1 id="title">회원정보 수정</h1>

		<div class="container form">
      <!-- 왼쪽 사진등록 구역 -->
      <div class="be-light" id="picUpdate">
        
      </div>
      <!-- 오른쪽 아이디/비번/닉네임 입력구역-->
      <div>

        <div class="form-group mb-3">
          <label class="mb-1" for="email">이메일</label>
          <div class="input-group mb-3">
          	<c:set var="email" value="${mem.emailaddress}" />
          	<c:set var="split" value="@" />
            <input type="text" class="form-control" name="email1" readonly value="${fn:substringBefore(email,split) }">
            <span class="input-group-text">@</span>
            <input type="text" class="form-control" name="email2" readonly value="${fn:substringAfter(email,split) }" >
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
            <input type="text" class="form-control" name="nickname" id="nickname" value="${mem.nickname }">
            <button class="btn btn-outline-secondary" type="button" id="button-addon2" onclick="win_nickChk()">중복검사</button>
            <span id="nickChkMsg"></span>
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
