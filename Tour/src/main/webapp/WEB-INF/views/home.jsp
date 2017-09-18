<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>WebSiteName</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style>
* {
	margin:0;
	padding:0;
	weight:100%;
}
html,#fullD {
	height:100%;
	background-color:white;
}
body {
	height:100%;
	background-color:white;

}
#topD {
	height:25px;
	background-color:#000000;
}
#smallD {
	height:70%;
}
#secondD {
	height:300px;
	background-color:#2c3e50;
}
#thirdD {
	height:300px;
	background-color:#e74c3c;
}
#fourthD {
	height:300px;
	background-color:#3498db;
}
#fifthD {
	height:300px;
	background-color:#ecf0f1;
}
</style>
<body>
<div id="fullD">
	<!-- Topbar -->
	<div id="topD"></div>
	
	<!-- 1 : Navbar -->
	<%@include file="include/nav.jsp"%>
	
	<!-- 2 : Carousel -->
	<div id="smallD">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
    		<!-- Indicators -->
    		<ol class="carousel-indicators">
      			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      			<li data-target="#myCarousel" data-slide-to="1"></li>
      			<li data-target="#myCarousel" data-slide-to="2"></li>
   	 		</ol>
    		<!-- Wrapper for slides -->
    		<div class="carousel-inner">
      			<div class="item active">
        			<img src="/resources/Test/img/R1.jpg" alt="Los Angeles" style="width:100%;">
        			<div class="carousel-caption">
          				<h3>Los Angeles</h3>
          				<p>LA is always so much fun!</p>
        			</div>
      			</div>
      			<div class="item">
        			<img src="/resources/Test/img/R2.jpg" alt="Chicago" style="width:100%;">
        			<div class="carousel-caption">
          				<h3>Chicago</h3>
          				<p>Thank you, Chicago!</p>
        			</div>
      			</div>
      			<div class="item">
        			<img src="/resources/Test/img/R3.jpg" alt="New York" style="width:100%;">
        			<div class="carousel-caption">
          				<h3>New York</h3>
          				<p>We love the Big Apple!</p>
        			</div>
      			</div>
  			</div>
			<!-- Left and right controls -->
    		<a class="left carousel-control" href="#myCarousel" data-slide="prev">
      			<span class="glyphicon glyphicon-chevron-left"></span>
      			<span class="sr-only">Previous</span>
    		</a>
    		<a class="right carousel-control" href="#myCarousel" data-slide="next">
      			<span class="glyphicon glyphicon-chevron-right"></span>
      			<span class="sr-only">Next</span>
    		</a>
  		</div> <!-- Carousel -->
	</div> <!-- SmallD -->
	<div id="secondD">
		
	</div>
	<div id="thirdD">
		<button id="courseView" type="button" class="btn btn-default"> 코스 보기 </button>
		<button id="courseMake" type="button" class="btn btn-default"> 코스 만들기 </button>
	</div>
	<div id="fourthD"></div>
	<div id="fifthD"></div>
		
</div> <!-- fullD -->

<!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="padding:35px 50px;">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4><span class="glyphicon glyphicon-lock"></span> 로그인 </h4>
        </div>
        
        <div class="modal-body" style="padding:40px 50px;">
          <form role="form" action="/login" method="post">
            <div class="form-group">
              <label for="usrname"><span class="glyphicon glyphicon-user"></span> 이메일 </label>
              <input type="text" class="form-control" id="usrname" placeholder="이메일을 입력해주세요." name="email">
            </div>
            <div class="form-group">
              <label for="psw"><span class="glyphicon glyphicon-eye-open"></span> 비밀번호 </label>
              <input type="password" class="form-control" id="psw" placeholder="비밀번호를 입력해주세요" name="pwd">
            </div>
            
              <button type="submit" class="btn btn-primary btn-block"><span class="glyphicon glyphicon-off"></span> 로그인 </button>
          </form>
        </div>
        
        <div class="modal-footer">
          <button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> 취소 </button>
        </div>
      </div>
      
    </div>
  </div> 
  
</body>
<script>
$(document).ready(function(){
    $("#reg").click(function(){
        //
    });
    $("#login").click(function(){
    	$("#myModal").modal();
    });
    $("#mypage").click(function(){
        //
    });
    $("#logout").click(function(){
    	location.href="/logout";
    });
    $("#courseView").click(function(){
    	location.href="/course/view/simple?courseNumber=1";
    });
    $("#courseMake").click(function(){
    	location.href="/course/make/add1";
    });
});
</script>
</html>