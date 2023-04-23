<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
  <title>닉네임 중복체크</title>
  <style>
    #form{width: 500px; height: 300px;}
    .container{margin: 30px auto; padding: 0 50px;}
    h2{margin-bottom: 30px;}
  </style>
</head>
<body>
  <div id="form">
    <form action="nickChk" name="f" onsubmit="return inchk(this)">
      <div class="container">
        <h2>닉네임 중복체크</h2>

        <div class="form-group">
        	<c:if test="${empty mem }">
        		<script>
    				opener.document.f.nicknamechkchk.value="nicknamechecked";
				</script>
        		<span style="color:blue">아이디 ${param.nickname }는 사용 가능합니다.</span> <br><br>
					  <button type="button" class="btn btn-dark" onclick="self.close()">적용하기</button> 
        	</c:if>
        	
        	<c:if test="${!empty mem }">
        		<script>
    				opener.document.f.nickname.value="";
				</script>
        		<span style="color:red">닉네임 ${param.nickname }은(는) 중복입니다.</span> <br><br>
					<button type="button" class="btn btn-dark" onclick="nickClear()">닫기</button>
        	</c:if>
          
          
        </div>
      </div>
    </form>
  </div>

  <script type="text/javascript">
		function nickClear(){
			opener.document.f.nickname.value = "";
			self.close();
		}
	</script>
</body>
</html>