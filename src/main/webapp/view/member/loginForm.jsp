<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>로그인</title>
  <style type="text/css">
	  /* loginForm.jsp에 들어갈 css속성임 */
	  #title{
	    font-family: 'Dongle', sans-serif; 
	    text-align: center; 
	    font-size: 5em;
	    margin-bottom: -2vh;
	  }
	  .container{width: 30vw; padding-top: 5vh;}
	  #loginBtn{border-radius: 2em;}
	  p, .btn{font-family: 'Dongle', sans-serif; font-size: 1.2em;}
	  .btn{font-size: 24px;}
	  .btn:hover {color: lightgray;}
	  /* ************************************ */
  </style>
  <script>
		function input_check(f){
		  if(f.id.value.trim() === ""){
		    alert("아이디를 입력하세요")
		    f.id.focus();
		    return false;
		  }
		  if(f.pass.value.trim() === ""){
		    alert("비밀번호를 입력하세요")
		    f.pass.focus();
		    return false;
		  }
		  return true;
		}
		
		function win_open(page){
	    let op = "width=500, height=450, left=50, top=150";
	    open(page,"",op);
	  }
	</script>
</head>
<body>
 <!-- About Section -->
  <form action="login" name="f" method="post" onsubmit="return input_check(this)">
  	<h1 id="title">로그인</h1>

  	<div class="container">
  		
  		<div class="form-group">
  			<label class="mb-1" for="usr">이메일</label><input placeholder="이메일" type="text" class="form-control mb-4" id="usr" name="id">
  			<label class="mb-1" for="pwd">비밀번호</label><input placeholder="비밀번호" type="password" class="form-control mb-3" id="pwd" name="pass">
  		</div>
  		
  		<div>
  			<button id="loginBtn"type="submit" class="btn btn-dark w-100 mb-3">로그인</button>

        <p class="mb-2" style="display: inline-block;">회원이 아니신가요?</p>&nbsp;&nbsp;&nbsp;
        <button type="button" class="btn px-0 fw-bold" onclick="location.href='joinForm'">회원가입</button>
        <br><br>
        <p class="mb-2">비밀번호를 찾으실려면 아래 버튼을 눌러주세요.</p>
        <button type="button" class="btn  px-0 fw-bold" onclick="win_open('emailForm2')">비밀번호 찾기</button>

  		</div>
  		
  	</div>
  	
  </form>
</body>
</html>