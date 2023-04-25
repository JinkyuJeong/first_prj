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
<title>${boardName}</title>
<style type="text/css">
	/* detail.jsp에 들어갈 css속성임 */
  .container{width: 85vw; overflow-x : auto;}
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
  .btn.btn-dark.comm{font-size:12px;}
  .reply{display : none;}
  /* ************************************ */
</style>
</head>
<body>
	  <!-- About Section -->
  <div class="container">
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
       
       <fmt:formatDate value="${today }" pattern="yyyy-MM-dd" var="t"/>
       
       <tr>
       	<th class="table-dark">작성일</th>
       	<fmt:formatDate value="${b.regdate }" pattern="yyyy-MM-dd" var="r"/>
        <c:if test="${t eq r}">
					<td><fmt:formatDate value="${b.regdate }" pattern="HH:mm"/></td>
				</c:if>
				<c:if test="${t != r}">
					<td><fmt:formatDate value="${b.regdate }" pattern="yyyy-MM-dd"/></td>
				</c:if>
       </tr>

       <tr>
         <th class="table-dark">작성자</th>
         <td>
         	<c:if test="${b.picture == 'basic-profile.JPG'}">
           	<img id="prof" src="${path }/images/basic-profile.JPG">
           </c:if>
           <c:if test="${b.picture != 'basic-profile.JPG'}">
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
     	<c:if test="${sessionScope.login == 'admin' || b.nickname == mem.nickname }">
        <a class="btn btn-dark" href="updateForm?no=${b.no}">수정</a>
        <%-- <a class="btn btn-dark" href="deleteForm?no=${b.no}">삭제</a> --%>
        <!-- Button trigger modal -->
				<a type="button" class="btn btn-dark" data-bs-toggle="modal" data-bs-target="#staticBackdrop">
				 	삭제
				</a>
				
				<!-- Modal -->
				<div class="modal fade" id="staticBackdrop" data-bs-backdrop="static" data-bs-keyboard="false" tabindex="-1" aria-labelledby="staticBackdropLabel" aria-hidden="true">
				  <div class="modal-dialog">
				    <div class="modal-content">
				      <div class="modal-header">
				        <h5 class="modal-title" id="staticBackdropLabel">게시물 삭제</h5>
				        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
				      </div>
				      <div class="modal-body">
				        해당 게시물을 삭제 하시겠습니까?
				      </div>
				      <div class="modal-footer">
				        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
				        <a type="button" class="btn btn-primary" href="delete?no=${b.no}" >삭제</a>
				      </div>
				    </div>
				  </div>
				</div>
       </c:if>
       
       <a class="btn btn-dark" href="list">목록으로</a>
     </div>

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
            전체 댓글 <span style="color:red">${commCnt }</span>개
          </div>
          <div></div>
        </div>

        <span id="comment"></span>
        <div id="comment">
          <table  class="table table-hover align-middle">
            <tbody>
            
            <c:if test="${commCnt <= 0 }">
            	<tr align="center"><td>등록된 댓글이 없습니다.</td></tr>
            </c:if>
            
            <c:forEach var="comm" items="${commList }">
              <tr>
              
                <td width="15%">
                	<c:if test="${comm.grpLevel == 1}">&nbsp;&nbsp;&#10551;&nbsp;&nbsp;</c:if>
                	<c:if test="${comm.picture == 'basic-profile.JPG'}">
				           	<img id="prof" src="${path }/images/basic-profile.JPG">
				           </c:if>
				           <c:if test="${comm.picture != 'basic-profile.JPG'}">
				           	<img id="prof" src="/first_prj/upload/member/${comm.picture}">
				           </c:if>
				           &nbsp;${comm.nickname }
                </td>
                
                <td width="100vw" align="left">${comm.content }</td>
                
                <fmt:formatDate value="${comm.regdate }" pattern="yyyy-MM-dd" var="r2"/>
                <c:if test="${t eq r2}">
									<td width="10%">
										<font size="1"><fmt:formatDate value="${comm.regdate }" pattern="HH:mm"/></font>
									</td>
								</c:if>
								<c:if test="${t != r2}">
									<td width="10%">
										<font size="1"><fmt:formatDate value="${comm.regdate }" pattern="yyyy-MM-dd"/></font>
									</td>
								</c:if>
                
                <td width="9%"><button class="btn"><i class="fa fa-thumbs-up" style="color: red; font-size: 24px;"></i>&nbsp;${comm.recommend }</button></td>
                
                <td width="10%">
                	<c:if test="${comm.nickname == mem.nickname || sessionScope.login == 'admin'}">
                		<a class="btn btn-dark comm" href="">삭제</a>
                	</c:if>
                	<c:if test="${comm.grpLevel <1 && sessionScope.login != null}">
                		<a class="btn btn-dark comm" href="#f1" onclick="openReply(this)">댓글작성</a>
                	</c:if>
                </td>
                
              </tr>
              
              <tr class="reply">
              	<td colspan="5">
              	<c:if test="${!empty sessionScope.login}">
							    <form action="commReply" method="post" name="f1" id="f1" onsubmit="return inputcheck(this)">
							    	<input type="hidden" name="no" value="${comm.no }">
										<input type="hidden" name="grp" value="${comm.grp}">
										<input type="hidden" name="grpLevel" value="${comm.grpLevel }">
										<input type="hidden" name="grpStep" value="${comm.grpStep }">
										
							      <table class="table align-middle table-borderless">
							        <tr>
							          <th class="table-light">
							          	<c:if test="${mem.picture == 'basic-profile.JPG'}">
							           		&nbsp;&#10551;&nbsp;&nbsp;<img id="prof" src="${path }/images/basic-profile.JPG">
							           	</c:if>
							           	<c:if test="${mem.picture != 'basic-profile.JPG'}">
							           		&nbsp;&#10551;&nbsp;&nbsp;<img id="prof" src="/first_prj/upload/member/${mem.picture}">
							           	</c:if>
							           	&nbsp;${mem.nickname }
							           	<input type="hidden" name="nickname" value="${mem.nickname }"> 
							          	</th>
							          <td width="75%">
							          	<input type="text" name="content" class="form-control">
							          </td>
							          <td align="right"><button type="submit" class="btn btn-dark">댓글등록</button></td>
							        </tr>
							      </table>
									</form>
								</c:if>
								</td>
              </tr>
              
              </c:forEach>
              <!-- &nbsp;&nbsp;&#10551;&nbsp;&nbsp; -->
              
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
      function openReply(btn) {
    	  // 클릭한 버튼에 대응하는 댓글 작성 폼 선택
    	  var replyForm = $(btn).closest('tr').next('.reply');
    	  // 선택한 댓글 작성 폼 열거나 닫기
    	  replyForm.toggle();
    	  // 모든 댓글 작성 폼 중 선택한 댓글 작성 폼과 다른 요소를 닫기
    	  $('.reply').not(replyForm).hide();
    	}
    </script>
    
    <c:if test="${!empty sessionScope.login}">
	    <form action="comment"  method="post" name="f" onsubmit="return inputcheck(this)">
	    	<input type="hidden" name="no" value="${b.no }">
				
	      <table class="table align-middle table-borderless">
	        <tr>
	          <th class="table-light">
	          	<c:if test="${mem.picture == 'basic-profile.JPG'}">
	           		<img id="prof" src="${path }/images/basic-profile.JPG">
	           	</c:if>
	           	<c:if test="${mem.picture != 'basic-profile.JPG'}">
	           		<img id="prof" src="/first_prj/upload/member/${mem.picture}">
	           	</c:if>
	           	&nbsp;${mem.nickname }
	           	<input type="hidden" name="nickname" value="${mem.nickname }"> 
	          	</th>
	          <td><input type="text" name="content" class="form-control"></td>
	        </tr>
	        <tr>
	          <td colspan="2" align="right"><button type="submit" class="btn btn-dark">댓글등록</button></td>
	        </tr>
	      </table>
			</form>
		</c:if>
		
  </div>
  
</body>
</html>