<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>내가 쓴 게시글</title>
<style type="text/css">
  body{font-size: 12px;}
  #title{
    font-family: 'Dongle', sans-serif; 
    text-align: center; 
    font-size: 5em;
    margin-bottom: 7vh;
  }
  h3{font-family: 'Dongle', sans-serif;}
  #cnt{color : red;}
  a{text-decoration: none;}
  .container{width: 70vw;}
  .input-group * {height: 30px; font-size: 12px;}
  tr th{text-align: center;}
  tr td:not(:nth-child(2)){text-align: center;}
  tr th:nth-child(1) {width: 5vw;}
  tr th:nth-child(2) {width: 20vw;}
  tr th:nth-child(3) {width: 8vw;}
  tr th:nth-child(4) {width: 6vw;}
  tr th:nth-child(5) {width: 5vw;}
</style>
</head>
<body>
	<!--  
		내가 만들어놓은 BoardListView에서 where nickname = ? 조건문 걸어서 쓰면 될 듯
	-->

	<!-- About Section -->
  <div class="container">
    <h1 id="title">내가 쓴 게시글</h1>

		<h3>내가 쓴 게시글 <span id="cnt">0</span>개</h3>
    <table class="table table-hover">

      <thead>
        <tr class="table-dark">
          <th scope="col">번호</th>
          <th scope="col">제목</th>
          <th scope="col">작성일</th>
          <th scope="col">조회수</th>
          <th scope="col">추천</th>
        </tr>
      </thead>

      <tbody>
        <tr>
          <th class="fw-bold"><span class="blue">1</span></th>
          <td><a href="">찍찍찍찍</a></td>
          <td>2023-04-16</td>
          <td>100</td>
          <td>10</td>
        </tr>
      </tbody>

    </table>

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