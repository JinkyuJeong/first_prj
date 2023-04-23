<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>${boardName} 게시글 수정</title>
<style type="text/css">
	/* updateForm.jsp에 들어갈 css속성임 */
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
  td .btn{font-family: 'Dongle', sans-serif; font-size: 20px;}
  td .btn:hover {color: lightgray;}
  /* ************************************ */
</style>
<script>
	function file_delete() {
		document.f.file2.value="";
		file_desc.style.display = "none";
	}
	
 function inputcheck(){
	 
   if(document.f.title.value.trim() == ""){
     alert("제목을 입력하세요");
     document.f.title.focus();
     return;
   }

   if(CKEDITOR.instances.content.getData().trim() == ""){
     alert("내용을 입력하세요");
     CKEDITOR.instances.content.focus();
     return;
		}
   
   document.f.submit();
 }
</script>
</head>
<body>
	 <form method="post" action="update" enctype="multipart/form-data" name="f" >
	 	<input type="hidden" name="no" value="${b.no }">
	 	<input type="hidden" name="file2" value="${b.file1}">
    <div class="container">
      <h2 id="title">${boardName} 게시글 수정</h2>
    
      <table class="table table-hover">
      
        <tr>
          <th class="table-light">제목</th>
          <td><input type="text" name="title" class="form-control"  placeholder="제목을 입력하세요." value="${b.title }"></td>
        </tr>

        <tr>
          <th class="table-light">내용</th>
          <td><textarea rows="15" name="content" class="form-control"  id="content">${b.content }</textarea></td>
         <script>
	        CKEDITOR.editorConfig = function( config ) {
					  config.htmlFilter = CKEDITOR.filter.disallowAll();
					};
				  CKEDITOR.replace("content",{
				    filebrowserImageUploadUrl : "imgupload",
				    // 툴바 구성 변경
				    toolbar: [
				      { name: 'document', items: [ 'Source','-','Save','NewPage','Preview','-','Templates' ] },
				      { name: 'clipboard', items: [ 'Cut','Copy','Paste','PasteText','PasteFromWord','-','Undo','Redo' ] },
				      { name: 'insert', items: [ 'Image','Table','HorizontalRule','SpecialChar' ] },
				      '/',
				      { name: 'styles', items: [ 'Styles','Format','Font','FontSize' ] },
				      { name: 'basicstyles', items: [ 'Bold','Italic','Strike','-','RemoveFormat' ] }
				    ],
				    // 스킨 변경
				    skin: 'moono',
				    // 기타 옵션
				    language: 'ko',
				    height: 300,
				    resize_enabled: false
				  });
				</script>
        </tr>

        <tr>
          <th class="table-light">첨부파일</th>
          
          <td>
          	<c:if test="${!empty b.file1 }">
							<div id="file_desc">
								${b.file1}
								<a class="btn" href="javascript:file_delete()">[첨부파일 삭제]</a>
							</div>
						</c:if>
						<input class="form-control" type="file" name="file1">
        	</td>
        </tr>

        <tr>
          <td colspan="2" align="center"><a class="btn btn-dark" href="javascript:inputcheck()">수정하기</a></td>
        </tr>
			
      </table>
    </div>
  </form>
</body>
</html>