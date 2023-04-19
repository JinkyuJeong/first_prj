<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 이거는 비밀번호 찾기에서 들어오는 이메일인증폼임 --%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
  <title>이메일 인증</title>
  <style>
    .container{margin: 30px auto; padding: 0 50px;}
    h2{margin-bottom: 30px;}
  </style>
   <script>
		function inchk(f){
			if(f.email1.value.trim() === ""){
				alert("이메일을 입력하세요");
	      f.pass.focus();
	      return false;
			}

      if(f.email2.value.trim() === ""){
				alert("이메일을 입력하세요");
	      f.pass.focus();
	      return false;
			}
	    return true;
	  }
</script>
</head>
<body>
   <form action="emailForm" name="f" onsubmit="return inchk(this)">
     <div class="container">
     
       <h2>이메일 인증</h2>
       
       <div class="form-group">
         <label class="mb-1" for="pwd">이메일</label>
         <div class="input-group mb-3">
           <input type="text" class="form-control" name="email1" placeholder="아이디" aria-label="Username">
           <span class="input-group-text">@</span>
           <input type="text" class="form-control" name="email2" placeholder="Example.com" aria-label="Server">
         </div>
       </div>
       <div class="form-group">
         <button type="submit" class="btn btn-dark">이메일인증</button>
       </div>
     </div>
   </form>
</body>
</html>