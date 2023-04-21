<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원목록</title>
<style type="text/css">
	/* userList.jsp에 들어갈 css속성임 */
  body{font-size: 12px;}
  #title{
    font-family: 'Dongle', sans-serif; 
    text-align: center; 
    font-size: 5em;
    margin-bottom: 7vh;
  }
  .btn{font-size: 12px;}
  a{text-decoration: none;}
  .container{width: 60vw;}
  .table-form {display: flex;}
  .table-form .input-group * {height: 30px; font-size: 12px;}
  tr th:nth-child(1){width: 8vw;}
  tr th:nth-child(2) {width: 6vw;}
  tr th:nth-child(3) {width: 8vw;}
  tr th:nth-child(4) {width: 6vw;}
  tr th:nth-child(5){width: 10vw;}
  #profile{width: 30px; height: 30px; border-radius: 50%;}
  /* ************************************ */
</style>
</head>
<body>
 <!-- About Section -->
  <div class="container">
    <h1 id="title">회원목록</h1>

    <div style="display: flex; justify-content: space-between; margin-bottom: -7px;">
      <div></div>

      <form class="table-form">
        <div class="input-group mb-3 ms-1">
          <input type="text" class="form-control" name="nickname" placeholder="닉네임 검색">
          <button class="btn btn-outline-secondary" type="submit" id="button-addon2"><i class="fa fa-search"></i></button>
        </div>
      </form>
    </div>

    <table class="table table-hover text-center">

      <thead>
        <tr class="table-dark">
          <th>이메일</th>
          <th>사진</th>
          <th>닉네임</th>
          <th>가입일자</th>
          <th>수정 / 탈퇴</th>
        </tr>
      </thead>

      <tbody>
        
        <tr>
          <td scope="row">khb@naver.com</td>
          <td><img id="profile" src="./images/basic-profile.JPG"></td>
          <td><a href="myPage?email1=">고현빈</a></td>
          <td>2023/04/16</td>
          <td>
            <a class="btn btn-dark" href="updateForm?id=${mem.email1 }">수정</a>
            <!-- 관리자 일 때 -->
            <a class="btn btn-dark"href="deleteForm?id=${mem.email1 }">강제탈퇴</a>
          </td>
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