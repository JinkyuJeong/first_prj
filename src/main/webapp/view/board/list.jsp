<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
  /* ************************************ */
</style>
</head>
<body>
	 <!-- About Section -->
  <div class="container">
    <h1 id="title">자유게시판</h1>

    <div style="display: flex; justify-content: space-between; margin-bottom: -7px;">

      <div>
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
        <tr class="notice">
          <th class="fw-bold"><span class="blue">공지</span></th>
          <td class="fw-bold"><a href="">게시판 규정을 지켜주세요.</a></td>
          <td class="fw-bold"><img id="profile" src="${path }/images/basic-profile.JPG"> 운영자</td>
          <td>2023/04/16</td>
          <td>100</td>
          <td>10</td>
        </tr>
        <tr>
          <td scope="row">1</td>
          <td><i class="fa fa-image"></i> <a href="">안녕?</a> <span class="orange">[5]</span></td>
          <td><img id="profile" src="${path }/images/basic-profile.JPG"> 고현빈</td>
          <td>2023/04/16</td>
          <td>100</td>
          <td>10</td>
        </tr>
      </tbody>

    </table>

    <div align="right"><button id="write" type="button" class="btn btn-dark" onclick="location.href='writeForm'">글쓰기</button></div>

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
</body>
</html>