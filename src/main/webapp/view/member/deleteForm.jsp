<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴</title>
<style type="text/css">
  /* deleteForm.jsp에 들어갈 css속성임 */
  #title{
    font-family: 'Dongle', sans-serif; 
    text-align: center; 
    font-size: 5em;
    margin-bottom: 7vh;
  }
  .container{width: 70vw;}
  .btn{font-family: 'Dongle', sans-serif; font-size: 1.6em;}
  .form-group{width: 35vw;}
  .mt-3 .btn:hover {color: lightgray;}
  /* ************************************ */
</style>
<script>
	function inputcheck(f){
		if(f.pass.value.trim() == ""){
	    alert("비밀번호를 입력하세요")
	    f.pass.focus();
	    return false;
	  }
	}
</script>
</head>
<body>
		<form action="update" method="post" name="f" onsubmit="return input_check(this)">

    <input type="hidden" name="id" value="${param.id }">
    
		<h1 id="title">회원탈퇴</h1>
    <div class="form-group container">
      <label class="mb-1" for="pwd">비밀번호</label><input placeholder="비밀번호" type="password" class="form-control mb-3" id="pwd" name="pass">
    </div>
    <div class="container mt-3" align="center">
      <button type="submit" class="btn">회원탈퇴</button>
    </div>
	</form>
</body>
</html>
