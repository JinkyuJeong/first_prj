<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>게시물보기</title>
<style type="text/css">
	/* detail.jsp에 들어갈 css속성임 */
  .container{width: 75vw; overflow-x : auto;}
  #title{
    font-family: 'Dongle', sans-serif; 
    text-align: center; 
    font-size: 5rem;
    margin-bottom: 7vh;
  }
  
  th, .btn.btn-dark{font-family:'Dongle', sans-serif; font-size: 1.4em;}
  #f th {min-width : 12vw; text-align: center;}
  th {
    text-align: center;
    width: 12vw;
  }
  
  .table>:not(caption)>*>* {padding: 10px 10px 10px 15px;}
  #prof{width: 30px; height: 30px; border-radius: 50%;}
  #content{height: 40vh;}
  #recomm{font-family:'Dongle', sans-serif; font-size: 50px;}
  #comment{border-top: 2px solid; border-bottom: 2px solid;}
  td .btn{font-family: 'Dongle', sans-serif; font-size: 20px;}
  td .btn:hover {color: lightgray;}
  /* ************************************ */
</style>
</head>
<body>
	  <!-- About Section -->
  <div class="container">
    <form method="post" action="write" enctype="multipart/form-data" name="f"  id="f">
      <h2 id="title">${boardName}</h2>
    
      <table class="table table-hover align-middle">
        <tr>
          <th class="table-dark">제목</th>
          <td>${b.title}</td>
        </tr>

        <tr>
          <th class="table-dark">조회수</th>
          <td>${b.hit}</td>
        </tr>

        <tr>
          <th class="table-dark">작성자</th>
          <td>
          	<c:if test="${empty b.picture}">
            	<img id="prof" src="${path }/images/basic-profile.JPG">
            </c:if>
            <c:if test="${!empty b.picture}">
            	<img id="prof" src="/first_prj/upload/member/${b.picture}">
            </c:if>
            &nbsp;${b.nickname }
          </td>
        </tr>

        <tr id="content">
          <th class="table-dark">내용</th>
          <td >
            ${b.content }
          </td>
        </tr>

        <tr>
          <th class="table-dark">첨부파일</th>
          <td>
          	<c:if test="${empty b.file1 }">
							&nbsp;
						</c:if>
						<c:if test="${!empty b.file1 }">
							<a download href="${path }/upload/board/${b.file1 }">${b.file1 }</a>
						</c:if>
          </td>
        </tr>

      </table>
      
      <c:if test="${b.boardType != 4 }">
	      <!-- 좋아요 -->
	      <div align="center"><button id="recomm" class="btn"><i class="fa fa-thumbs-up" style="color: red; font-size: 50px;"></i>&nbsp;${b.recommend }</button></div>
      </c:if>
      
      <!-- 버튼들 -->
      <div align="center">
      	<c:if test="${sessionScope.login == 'admin' || b.nickname == nickname }">
	        <a class="btn btn-dark" href="updateForm?no=${b.no}">수정</a>
	        <a class="btn btn-dark" href="deleteForm?no=${b.no}">삭제</a>
        </c:if>
        <a class="btn btn-dark" href="list">목록으로</a>
      </div>
    </form>

    <div>&nbsp;</div>

    <table class="table table-hover">
      <tr >
        <th class="table-dark">이전글</th>
        <td>
	        <c:if test="${!empty bPrevious}">
	       		<a href="detail?no=${bPrevious.no}" class="btn">${bPrevious.title}</a>
	       	</c:if>
	       	<c:if test="${empty bPrevious}">
	       		<a href="" class="btn" onclick="event.preventDefault();">이전글이 없습니다.</a>
	       	</c:if>
        </td>
      </tr>
      <tr>
        <th class="table-dark">다음글</th>
        <td>
        	<c:if test="${!empty bNext}">
        		<a href="detail?no=${bNext.no}" class="btn">${bNext.title}</a>
        	</c:if>
        	<c:if test="${empty bNext}">
        		<a href="" class="btn" onclick="event.preventDefault();">다음글이 없습니다.</a>
        	</c:if>
        </td>
      </tr>
    </table>

    <div>&nbsp;</div>

    <!-- 댓글 -->
    <div class="container">
      
      <div style="display: flex; justify-content: space-between; margin: 15px auto;">
          <div>
            전체 댓글 <span style="color:red">${boardCnt }2</span>개
          </div>
          <div></div>
        </div>

        <span id="comment"></span>
        <div id="comment">
          <table  class="table table-hover align-middle">
            <tbody>
              <tr>
                <td width="15%"><img id="prof" src="${path }/images/basic-profile.JPG"> 고현빈</td>
                <td width="100vw" align="left">ㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋㅋ</td>
                <td width="10%"><font size="1">2023/04/16</font></td>
                <td width="9%"><button class="btn"><i class="fa fa-thumbs-up" style="color: red; font-size: 24px;"></i>&nbsp;10</td>
                <td width="7%"><a class="btn btn-dark" href="">삭제</a></td>
              </tr>
              <!-- 대댓글 -->
              <tr>
                <td width="15%">&nbsp;&nbsp;&#10551;&nbsp;&nbsp;<img id="prof" src="${path }/images/basic-profile.JPG"> 고현빈</td>
                <td width="100vw" align="left">재밌네</td>
                <td width="5%"><font size="1">2023/04/16</font></td>
                <td width="10%"><button class="btn"><i class="fa fa-thumbs-up" style="color: red; font-size: 24px;"></i>&nbsp;10</td>
                <td width="10%"><a class="btn btn-dark" href="">삭제</a></td>
              </tr>
            </tbody>
          </table>
        </div>
      
        <!-- Pagination -->
        <div class="w3-center w3-padding-32">
          <div class="w3-bar">
            <a href="#" class="w3-bar-item w3-button w3-hover-black">&laquo;</a>
            <a href="#" class="w3-bar-item w3-button w3-hover-black">1</a>
            <a href="#" class="w3-bar-item w3-button w3-hover-black">2</a>
            <a href="#" class="w3-bar-item w3-button w3-hover-black">3</a>
            <a href="#" class="w3-bar-item w3-button w3-hover-black">4</a>
            <a href="#" class="w3-bar-item w3-button w3-hover-black">5</a>
            <a href="#" class="w3-bar-item w3-button w3-hover-black">&raquo;</a>
          </div>
        </div>
      </div>
    
    <!-- 댓글작성 폼 -->
    <script>
      function inputcheck(f){
        if(f.content.value.trim() == ''){
          alert("댓글 내용을 입력하세요.")
          f.content.focus();
          return false;
        }

        return true;
      }
    </script>
    <form action="comment" method="post" name="f" onsubmit="return inputcheck(this)">
    	<input type="hidden" name="no" value="${b.no }">
      <table class="table align-middle table-borderless">
        <tr>
          <th class="table-light"><img id="prof" src="${path }/images/basic-profile.JPG"> 고현빈</th>
          <td><input type="text" name="content" class="form-control"></td>
        </tr>
        <tr>
          <td colspan="2" align="right"><button type="submit" class="btn btn-dark">댓글등록</button></td>
        </tr>
      </table>
		</form>

  </div>
</body>
</html>