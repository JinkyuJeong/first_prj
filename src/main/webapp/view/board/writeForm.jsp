<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 글쓰기</title>
<style type="text/css">
	/* writeForm.jsp에 들어갈 css속성임 */
  .container{width: 75vw;}
  #title{
    font-family: 'Dongle', sans-serif; 
    text-align: center; 
    font-size: 5em;
    margin-bottom: 7vh;
  }
  th, .btn.btn-dark{font-family:'Dongle', sans-serif; font-size: 1.4em;}
  th {
    text-align: center;
    width: 10vw;
  }
  /* ************************************ */
</style>
<script>
 function inputcheck(){

   if(document.f.title.value.trim() == ""){
     alert("제목을 입력하세요");
     document.f.name.focus();
     return;
   }

   if(document.f.content.value.trim() == ""){
     alert("내용을 입력하세요");
     document.f.name.focus();
     return;
   } 
   document.f.submit();
 }
</script>
</head>
<body>
	 <form method="post" action="write" enctype="multipart/form-data" name="f" >
    <div class="container">
      <h2 id="title">자유게시판 게시글 작성</h2>
    
      <table class="table table-hover">
      
        <tr>
          <th>제목</th>
          <td><input type="text" name="title" class="form-control" class="w3-input" placeholder="제목을 입력하세요."></td>
        </tr>

        <tr>
          <th>내용</th>
          <td><textarea rows="15" name="content" class="form-control" class="w3-input" id="content"></textarea></td>
          <script>
            CKEDITOR.replace("content",{
              filebrowserImageUploadUrl : "imgupload"
            })
          </script>
        </tr>

        <tr>
          <th>첨부파일</th>
          <td><input class="form-control" type="file" name="file1"></td>
        </tr>

        <tr>
          <td colspan="2" align="center"><a class="btn btn-dark" href="javascript:inputcheck()">등록하기</a></td>
        </tr>

      </table>
    </div>
  </form>
</body>
</html>