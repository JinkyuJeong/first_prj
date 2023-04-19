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
  .table-form #sel{width: 90px; height: 30px; font-size: 12px;}
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
      	전체 게시물 <span style="color:red">${boardCnt }</span>개
      </div>

      <form class="table-form">
        <select id="sel" class="form-select" name="f">
          <option selected value="title">제목</option>
          <option value="writerId">작성자</option>
        </select>
        <div class="input-group mb-3 ms-1">
          <input type="text" class="form-control" name="q" placeholder="검색어">
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
      	<tr class="notice">
          <th class="fw-bold"><span class="blue">공지</span></th>
          <td class="fw-bold"><a href="">게시판 규정을 지켜주세요.</a></td>
          <td class="fw-bold"><img id="profile" src="${path }/images/basic-profile.JPG"> 운영자</td>
          <td>2023/04/16</td>
          <td>100</td>
          <td>10</td>
        </tr>
        <tr class="notice">
          <th class="fw-bold"><span class="blue">공지</span></th>
          <td class="fw-bold"><a href="">4월 셋째 주 이벤트 당첨자</a></td>
          <td class="fw-bold"><img id="profile" src="${path }/images/basic-profile.JPG"> 운영자</td>
          <td>2023/04/16</td>
          <td>100</td>
          <td>10</td>
        </tr>
        
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
		          	<!-- 댓글 조건처리 하기 -->
		          	<a href="detail?no=${b.no }">${b.title }</a> <span class="orange">[5]</span>
		          </td>
		          <td>
		          <!-- 이미지 조건처리 하기-->
		          	<img id="profile" src="${path}/images/basic-profile.JPG">
		          	${b.nickname }
		          </td>
		          
		          <fmt:formatDate value="${today }" pattern="yyyy-MM-dd" var="t"/>
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

    <div align="right"><button id="write" type="button" class="btn btn-dark" onclick="goWriteForm()">글쓰기</button></div>
    <script type="text/javascript">
    	function goWriteForm() {
				location.href="writeForm?boardType=${sessionScope.boardType}" 
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
						<a class="w3-bar-item w3-button w3-hover-black" href="list?pageNum=${startPage-1}">&laquo;</a>
					</c:if>
					
					<c:forEach var="a" begin="${startPage}" end="${endPage}">
						<c:if test="${a <= maxPage}">
							<a class="w3-bar-item w3-button w3-hover-black ${a == pageNum ? 'w3-black' : '' }" href="list?pageNum=${a}">${a}</a>
						</c:if>
					</c:forEach>
						
					<c:if test="${startPage+4 >= maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('다음 페이지가 없습니다.');">&raquo;</a>
					</c:if>
					<c:if test="${startPage+4 < maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" href="list?pageNum=${startPage+5}">&raquo;</a>
					</c:if>
		    </div>
		  </div>
    
  </div>
</body>
</html>