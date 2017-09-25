<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
  <title>WebsiteName</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
  body {
      position: relative; 
  }
  .affix {
      top:0;
      width: 100%;
      z-index: 9999 !important;
  }
  .navbar {
      margin-bottom: 0px;
  }
  .affix ~ .container-fluid {
     position: relative;
     top: 70px;
  }
  #section1 {padding-top:120px;height:850px;color: #fff; background-color: #1E88E5;}
  #section2 {padding-top:120px;height:850px;color: #fff; background-color: #673ab7;}
  #section3 {padding-top:120px;height:350px;color: #fff; background-color: #ff9800;}
  #section41 {padding-top:120px;height:850px;color: #fff; background-color: #00bcd4;}
  #section42 {padding-top:120px;height:850px;color: #fff; background-color: #009688;}
  #section43 {padding-top:120px;height:850px;color: #fff; background-color: #1E88E5;}
  #section44 {padding-top:120px;height:850px;color: #fff; background-color: #673ab7;}
  #section45 {padding-top:120px;height:300px;color: #fff; background-color: #ff9800;}
  </style>
</head>
<body data-spy="scroll" data-target=".navbar">


<nav class="navbar navbar-inverse" data-spy="affix" style="background-color:#000000; color:#FFFFFF">
  <div class="container-fluid">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>                        
      </button>
    </div>
      <div class="collapse navbar-collapse" id="myNavbar">
      <c:choose>
  		<c:when test="${empty login}">
    		<ul class="nav navbar-nav navbar-right">
      			<li id="reg"><a href="#"><font size="2">회원가입</font></a></li>
      			<li id="login"><a href="#"></span><font size="2">로그인</font></a></li>
    		</ul>
  		</c:when>
  		<c:otherwise>
  			<ul class="nav navbar-nav navbar-right">
      			<li id="mypage"><a href="#"><span class="glyphicon glyphicon-user"></span> 마이페이지 </a></li>
      			<li id="logout"><a href="#"><span class="glyphicon glyphicon-log-in"></span> 로그아웃 </a></li>
    		</ul>
  		</c:otherwise>
	</c:choose>
      
      </div>
  </div>
</nav>
<nav class="navbar navbar-inverse" data-spy="affix" data-offset-top="70px" style="background-color:#FFFFFF; height:70px;top:50px;">
  <div class="container-fluid">
    <div class="navbar-header">
        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>
          <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" style="margin:0;padding:0;" href="#"><h2>WebsiteName</h2></a>
    </div>
    <div>
      <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav pull-right">
          <li><a href="#section1"><h4>코스 만들기</h4></a></li>
          <li><a href="#section2"><h4>코스 검색</h4></a></li>
          <li><a href="#section3"><h4>추천 코스 보기</h4></a></li>
        </ul>
      </div>
    </div>
  </div>
</nav>



<div class="container-fluid" style="padding:0px;">
	<!-- Carousel -->
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
</div>

    

<div id="section1" class="container-fluid">
	<div class="container">
		<h1> 코스 만들기 </h1>
		<p> 자신만의 코스를 만들어 보세요~ </p>
		<button class="btn btn-default" id="courseMake"> 코스 만들기 </button>
	</div>
</div>
<div id="section2" class="container-fluid">
	<div class="container">
		<h1> 코스 검색 </h1>
		<p> 지역명, 아이디명으로 다른 사용자의 코스를 검색해보세요~ </p>
		<button class="btn btn-default" id="courseView"> 코스 검색 </button>
	</div>  
</div>
<div id="section3" class="container-fluid">
 	<div class="container">
		<h1> 이달의 코스 </h1>
	</div> 
	</div>
<div id="section41" class="container-fluid">
 	<div class="container">
		<h1> 추천 코스  1 </h1>
	</div> 
</div>
<div id="section42" class="container-fluid">
   	<div class="container">
		<h1> 추천 코스  2 </h1>
	</div> 
</div>
<div id="section43" class="container-fluid">
   	<div class="container">
		<h1> 추천 코스 3 </h1>
	</div></div>
<div id="section44" class="container-fluid">
   	<div class="container">
		<button class="btn btn-default"> 더보기 </button>
	</div>
</div>
<div id="section45" class="container-fluid">
   	<div class="container">
		<p>Footer..</p>
	</div>
</div>

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
