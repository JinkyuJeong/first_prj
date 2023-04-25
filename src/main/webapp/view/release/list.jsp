<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>실시간 발매정보 리스트</title>
<style type="text/css">
	body, h1, h2, h3, p{font-family: 'Dongle', sans-serif;}
	a{text-decoration: none;}
	h1 {font-weight : bold;}
	h3 {font-size : 1.7em;}
	.w3-quarter p{font-size : 1.5em; color:blue;}
	#title{
    font-family: 'Dongle', sans-serif; 
    text-align: center; 
    font-size: 5em;
    margin-bottom: -5vh;
  }
  .table-form {display: flex;}
  .table-form #sel{width: 120px; height: 40px; font-size: 16px;}
  .table-form .input-group * {height: 40px; font-size: 16px;}
  #msg{color:green; font-size : 1.7em;} 
  #head{
  	display : flex;
  	justify-content: space-between
  }
</style>
</head>
<body>
	<div class="container">
		<h1 id="title">실시간 발매정보</h1>
		
			<div class="w3-main w3-content w3-padding" style="max-width:1200px;margin-top:100px">
				<div id="head">
					<p id="msg"><i class="fa fa-info-circle"></i> 해당 이미지를 클릭하면 해당 상품의 상세정보를 볼 수 있습니다.</p>
					<form class="table-form">
		        <select id="sel" class="form-select" name="t">
		          <option ${(param.t == "name") ? "selected" : ""} value="name">상품명</option>
		          <option ${(param.t == "location") ? "selected" : ""} value="location">발매처</option>
		        </select>
		        <div class="input-group mb-3 ms-1">
		          <input type="text" class="form-control" name="q" placeholder="검색어" value="${param.q }">
		          <button class="btn btn-outline-secondary" type="submit" id="button-addon2"><i class="fa fa-search"></i></button>
		        </div>
		      </form>
		     </div>
			<c:if test="${maxPage == 0}">
				<h3 align="center">검색 결과가 없습니다.</h3>
			</c:if>
			<c:if test="${maxPage != 0}">
			  <div class="w3-row-padding w3-padding-16 w3-center" id="food">
				  <c:forEach var="rc" items="${list }" begin="${(pageNum-1)*4 }" end="${pageNum*4-1 }" varStatus="st">
				    <div class="w3-quarter">
				    	<h1>${rc.agentsite }</h1>
				      <a href="detail?no=${rc.no }"><img src="${rc.thumbnailUrl }" style="width:100%"></a>
				      <a href="detail?no=${rc.no }"><h3>${rc.productName }</h3></a>
				      
				      <c:set var="infos" value="${fn:split(rc.additionalInfo,'  +')}"/>
				      
				      <p>
					      <c:forEach var="n" items="${infos }">
					      	<span class="badge rounded-pill bg-warning text-dark">${n} </span>
					      </c:forEach> 
					      <br>
					     	<span class="fw-bold">${rc.releaseTime}</span> 
				      </p>
				    </div>
				   </c:forEach>
			  </div>
			  
			  <div class="w3-row-padding w3-padding-16 w3-center" id="food">
				  <c:forEach var="rc" items="${list }" begin="${(pageNum-1)*4+4 }" end="${pageNum*4-1+4 }" varStatus="st">
				    <div class="w3-quarter">
				    	<h1>${rc.agentsite }</h1>
				      <a href="detail?no=${rc.no }"><img src="${rc.thumbnailUrl }" style="width:100%"></a>
				      <a href="detail?no=${rc.no }"><h3>${rc.productName }</h3></a>
				     	<c:set var="infos" value="${fn:split(rc.additionalInfo,'  +')}"/>
				      
				      <p>
					      <c:forEach var="n" items="${infos }">
					      	<span class="badge rounded-pill bg-warning text-dark">${n} </span>
					      </c:forEach> 
					      <br>
					      <span class="fw-bold">${rc.releaseTime}</span>
				      </p>
				    </div>
				   </c:forEach>
			  </div>
		  </c:if>
		  
		  <!-- paging -->
		  
		  <div class="w3-center w3-padding-32">
		    <div class="w3-bar">
			    <c:if test="${pageNum <= 1}">
						<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('이전 페이지가 없습니다.');">&laquo;</a>
					</c:if>
					<c:if test="${pageNum > 1}">
						<a class="w3-bar-item w3-button w3-hover-black" href="list?pageNum=${pageNum-1}&t=${param.t}&q=${param.q}">&laquo;</a>
					</c:if>
					
					<c:forEach var="a" begin="${startPage}" end="${endPage}">
						<c:if test="${a <= maxPage}">
							<a class="w3-bar-item w3-button w3-hover-black ${a == pageNum ? 'w3-black' : '' }" href="list?pageNum=${a}&t=${param.t}&q=${param.q}">${a}</a>
						</c:if>
					</c:forEach>
						
					<c:if test="${startPage+4 >= maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" onclick="alert('다음 페이지가 없습니다.');">&raquo;</a>
					</c:if>
					<c:if test="${startPage+4 < maxPage}">
						<a class="w3-bar-item w3-button w3-hover-black" href="list?pageNum=${startPage+5}&t=${param.t}&q=${param.q}">&raquo;</a>
					</c:if>
		    </div>
		  </div>
		  
		</div>
	</div>
</body>
</html>