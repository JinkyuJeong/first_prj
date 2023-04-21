<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<c:set var="path" value="${pageContext.request.contextPath }" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>자유게시판</title>
<style type="text/css">
 	body{font-size: 12px;}
  #title{
    font-family: 'Dongle', sans-serif; 
    text-align: center; 
    font-size: 5em;
    margin-bottom: 7vh;
  }
  a{text-decoration: none;}
  .container{width: 70vw;}
  .orange{color:rgb(255, 102, 0);}
  .blue{color:blue;}
  #write{width:70px; height: 30px; font-size: 16px; padding: 0; font-family: 'Dongle', sans-serif;}
  .table-form {display: flex;}
  .table-form #sel{width: 130px; height: 30px; font-size: 12px;}
  .table-form .input-group * {height: 30px; font-size: 12px;}
  tr th{text-align: center;}
  tr td:not(:nth-child(2)){text-align: center;}
  tr th:nth-child(1) {width: 5vw;}
  tr th:nth-child(2) {width: 30vw;}
  tr th:nth-child(3) {width: 8vw;}
  tr th:nth-child(4) {width: 6vw;}
  tr th:nth-child(5) {width: 5vw;}
  tr th:nth-child(6) {width: 5vw;}
  #profile{width: 16px; height: 16px; border-radius: 50%;}
  .notice{background-color:lightgray;}
  #cnt{padding:0px; font-family: 'Dongle', sans-serif; font-size:25px;}
  /* ************************************ */
</style>
</head>
<body>
	 <!-- About Section -->
  <div class="container">
    <h1 id="title">${boardName }</h1>

    <div style="display: flex; justify-content: space-between; margin-bottom: -7px;">

      <div id="cnt">
      	전체 게시물 <span style="color:red">${empty boardCnt? 0 : boardCnt}</span>개
      </div>

      <form class="table-form">
        <select id="sel" class="form-select" name="f">
          <option ${(param.f == "title+content") ? "selected" : ""} value="title+content">제목+내용</option>
          <option ${(param.f == "nickname") ? "selected" : ""} value="nickname">작성자</option>
        </select>
        <div class="input-group mb-3 ms-1">
          <input type="text" class="form-control" name="q" placeholder="검색어" value="${param.q }">
          <button class="btn btn-outline-secondary" type="submit" id="button-addon2"><i class="fa fa-search"></i></button>
        </div>
      </form>
    </div>

    <table class="table table-hover">
			
      <thead>
        <tr class="table-dark">
          <th scope="col">번호</th>
          <th scope="col">제목</th>
          <th scope="col">글쓴이</th>
          <th scope="col">작성일</th>
          <th scope="col">조회수</th>
          <th scope="col">추천</th>
        </tr>
      </thead>
			
      <tbody>
      
      	<!-- 공지사항 고정글 1개 + 이벤트 당첨글 1개 -->
      	<!-- 공지 글이 없을 때 -->
      	<c:if test="${boardType != 4 }">
		      <c:if test="${nCnt <= 0}">
						<tr><td colspan="7">등록된 공지사항이 없습니다.</td></tr>
					</c:if>
					<!-- 게시판 글이 있을 때 -->
					
					<fmt:formatDate value="${today }" pattern="yyyy-MM-dd" var="t"/>

					<c:if test="${nCnt > 0}">
						<c:set var="cnt" value="${nCnt==1? 0:nCnt }"/>
						<c:forEach var="n" items="${nList}" begin="0" end="${cnt}">
			      	<tr class="notice">
			          <th class="fw-bold"><span class="blue">공지</span></th>
			          <td class="fw-bold"><a href="">${n.title}</a></td>
			          <td class="fw-bold">
			          	<c:if test="${b.picture == null }">
			          		<img id="profile" src="${path }/images/basic-profile.JPG">
			          	</c:if>
			          	<c:if test="${b.picture != null }">
			          		<img id="profile" src="/first_prj/upload/member/${b.picture}">
			          	</c:if>
			          	<c:if test="${sessionScope.login eq 'admin' }">
			          		운영자
			          	</c:if> 
		          	</td>
		          	
		          	<fmt:formatDate value="${n.regdate }" pattern="yyyy-MM-dd" var="r2"/>
			          <c:if test="${t eq r2}">
									<td><fmt:formatDate value="${n.regdate }" pattern="HH:mm:ss"/></td>
								</c:if>
								<c:if test="${t != r2}">
									<td><fmt:formatDate value="${n.regdate }" pattern="yyyy-MM-dd"/></td>
								</c:if>
							
			          <td>${n.hit }</td>
			          <td>0</td>
			        </tr>
			        <c:if test="${nCnt==1}"></c:if>
			        </c:forEach>
	        </c:if>
        </c:if>
        
        <!-- 게시판 글이 없을 때 -->
	      <c:if test="${boardCnt <= 0}">
					<tr><td colspan="7">등록된 게시글이 없습니다.</td></tr>
				</c:if>
				
				<!-- 게시판 글이 있을 때 -->
				<c:if test="${boardCnt > 0}">
					<c:forEach var="b" items="${list }">
		        <tr>
		          <td scope="row">${boardNum}</td>	<c:set var="boardNum" value="${boardNum-1 }"/>
		          <td>
		          	<c:if test="${!empty b.file1 }">
		          		<i class="fa fa-image"></i>
		          	</c:if>
		          	<!-- 댓글 조건처리 하기구현해야함 -->
		          	<a href="detail?no=${b.no }">${b.title }</a> <span class="orange">[5]</span>
		          </td>
		          <td>
		          <!-- 이미지 조건처리 하기구현해야함-->
		          	<c:if test="${b.picture == null }">
		          		<img id="profile" src="${path }/images/basic-profile.JPG">
		          	</c:if>
		          	<c:if test="${b.picture != null }">
		          		<img id="profile" src="/first_prj/upload/member/${b.picture}">
		          	</c:if>
		          	${b.nickname }
		          </td>
		          
		          <fmt:formatDate value="${b.regdate }" pattern="yyyy-MM-dd" var="r"/>
							<c:if test="${t eq r}">
								<td><fmt:formatDate value="${b.regdate }" pattern="HH:mm:ss"/></td>
							</c:if>
							<c:if test="${t != r}">
								<td><fmt:formatDate value="${b.regdate }" pattern="yyyy-MM-dd"/></td>
							</c:if>
							
		          <td>${b.hit}</td>
		          <td>${b.recommend}</td>
		        </tr>
	        </c:forEach>
        </c:if>
      </tbody>

    </table>

		<!-- 공지사항으로 들어오면 글 못쓰는데 어드민이면 공지글쓰기 가능 -->
    <div align="right">
    	<c:if test="${sessionScope.boardType != 4}">
    		<button id="write" type="button" class="btn btn-dark" onclick="goWriteForm()">글쓰기</button>
    	</c:if>
    	<c:if test="${sessionScope.login == 'admin'}">
    		<button id="write" type="button" class="btn btn-dark" onclick="goWriteNoticeForm()">공지사항 작성</button>
    	</c:if>
    </div>
    <script type="text/javascript">
    	function goWriteForm() {
				location.href="writeForm?boardType=${sessionScope.boardType}" 
			}
    	function goWriteNoticeForm() {
			location.href="writeForm?boardType=4" 
		}
    </script>

    <!-- Pagination -->
      <!-- paging -->
		  
		  <div class="w3-center w3-padding-32">
		    <div class="w3-bar">
			    <c:if test="${startPage <= 1}">
						<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('이전 페이지가 없습니다.');">&laquo;</a>
					</c:if>
					<c:if test="${startPage > 1}">
						<a class="w3-bar-item w3-button w3-hover-black" href="list?pageNum=${startPage-1}&f=${param.f}&q=${param.q}">&laquo;</a>
					</c:if>
					
					<c:forEach var="a" begin="${startPage}" end="${endPage}">
						<c:if test="${a <= maxPage}">
							<a class="w3-bar-item w3-button w3-hover-black ${a == pageNum ? 'w3-black' : '' }" href="list?pageNum=${a}&f=${param.f}&q=${param.q}">${a}</a>
						</c:if>
					</c:forEach>
						
					<c:if test="${startPage+4 >= maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('다음 페이지가 없습니다.');">&raquo;</a>
					</c:if>
					<c:if test="${startPage+4 < maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" href="list?pageNum=${startPage+5}&f=${param.f}&q=${param.q}">&raquo;</a>
					</c:if>
		    </div>
		  </div>
    
  </div>
</body>
</html>