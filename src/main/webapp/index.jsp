<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SHOERACE</title>
<style type="text/css">
	/* index.jsp에 들어갈 css속성임 */
  #jumbo{
    background-image: url('./images/jumbo.jpg');
    background-position: center;
    background-size: cover;
    min-height: 100vh;
    margin: -30px -20px 0;
  }
  #jumbo h3, #jumbo p {color: white}
  #jumbo h3{font-size: 70px; padding-top: 10%; text-shadow: 3px 3px 3px rgba(0, 0, 0, 0.5);}
  #jumbo p{font-size: 20px; font-weight: bold;text-shadow: 3px 3px 3px rgba(0, 0, 0, 0.4);}
  /* ************************************ */
	
</style>
</head>
<body>
	 <!-- About Section -->
  <div id="jumbo" class="w3-container w3-padding-32 w3-center"> 
    <h3 class="display-4 fw-bold mb-4">SHOERACE</h3>
    <p class="lead mb-4">
      신발을 좋아하는 사람들의 커뮤니티 사이트입니다. <br>
    </p>
    <a class="btn btn-primary btn-lg" href="board/list?boardType=1" role="button">바로가기</a>
  </div>
</body>
</html>