<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">

<head>
  <title>MemCox</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
  body {
      font: 400 15px Lato, sans-serif;
      line-height: 1.8;
      color: #818181;
  }
  h2 {
      font-size: 24px;
      text-transform: uppercase;
      color: #303030;
      font-weight: 600;
      margin-bottom: 30px;
  }
  h4 {
      font-size: 19px;
      line-height: 1.375em;
      color: #303030;
      font-weight: 400;
      margin-bottom: 30px;
  }
  .jumbotron {
  	  background-color:#337ab7;
      color: #fff;
      padding: 100px 25px;
      font-family: Montserrat, sans-serif;
  }
  .container-fluid {
      padding: 60px 50px;
  }
  #pop .container-fluid {
  	padding: 25px 50px;
  }
  .bg-grey {
      background-color: #f6f6f6;
  }
  .logo-small {
      color: #337ab7;
      font-size: 50px;
  }
  .logo {
      color: #337ab7;
      font-size: 200px;
  }
  .thumbnail {
      padding: 0 0 15px 0;
      border: none;
      border-radius: 0;
  }
  .thumbnail img {
      width: 100%;
      height: 100%;
      margin-bottom: 10px;
  }
  .carousel-control.right, .carousel-control.left {
      background-image: none;
      color: #f4511e;
  }
  .carousel-indicators li {
      border-color: #f4511e;
  }
  .carousel-indicators li.active {
      background-color: #f4511e;
  }
  .item h4 {
      font-size: 19px;
      line-height: 1.375em;
      font-weight: 400;
      font-style: italic;
      margin: 70px 0;
  }
  .item span {
      font-style: normal;
  }
  .panel {
      border: 1px solid #f4511e; 
      border-radius:0 !important;
      transition: box-shadow 0.5s;
  }
  .panel:hover {
      box-shadow: 5px 0px 40px rgba(0,0,0, .2);
  }
  .panel-footer .btn:hover {
      border: 1px solid #f4511e;
      background-color: #fff !important;
      color: #f4511e;
  }
  .panel-heading {
      color: #fff !important;
      background-color: #f4511e !important;
      padding: 25px;
      border-bottom: 1px solid transparent;
      border-top-left-radius: 0px;
      border-top-right-radius: 0px;
      border-bottom-left-radius: 0px;
      border-bottom-right-radius: 0px;
  }
  .panel-footer {
      background-color: white !important;
  }
  .panel-footer h3 {
      font-size: 32px;
  }
  .panel-footer h4 {
      color: #aaa;
      font-size: 14px;
  }
  .panel-footer .btn {
      margin: 15px 0;
      background-color: #f4511e;
      color: #fff;
  }
  .navbar {
      margin-bottom: 0;
      background-color: #337ab7;
      z-index: 9999;
      border: 0;
      font-size: 12px !important;
      line-height: 1.42857143 !important;
      letter-spacing: 4px;
      border-radius: 0;
      font-family: Montserrat, sans-serif;
  }
  .navbar li a, .navbar .navbar-brand {
      color: #fff !important;
  }
  .navbar-nav li a:hover, .navbar-nav li.active a {
      color: #337ab7 !important;
      background-color: #fff !important;
  }
  .navbar-default .navbar-toggle {
      border-color: transparent;
      color: #fff !important;
  }
  footer .glyphicon {
      font-size: 20px;
      margin-bottom: 20px;
      color: #337ab7;
  }
  .slideanim {visibility:hidden;}
  .slide {
      animation-name: slide;
      -webkit-animation-name: slide;
      animation-duration: 1s;
      -webkit-animation-duration: 1s;
      visibility: visible;
  }
  @keyframes slide {
    0% {
      opacity: 0;
      transform: translateY(70%);
    } 
    100% {
      opacity: 1;
      transform: translateY(0%);
    }
  }
  @-webkit-keyframes slide {
    0% {
      opacity: 0;
      -webkit-transform: translateY(70%);
    } 
    100% {
      opacity: 1;
      -webkit-transform: translateY(0%);
    }
  }
  @media screen and (max-width: 768px) {
    .col-sm-4 {
      text-align: center;
      margin: 25px 0;
    }
    .btn-lg {
        width: 100%;
        margin-bottom: 35px;
    }
  }
  @media screen and (max-width: 480px) {
    .logo {
        font-size: 150px;
    }
  }
  .image {
    position: relative;
    text-align: center;
    color: white;
  }
  .centered {
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
  }
  #loginModal {
   position: absolute;
   top: 20%;
   bottom: auto;
	}	
 #registerModal {
   position: absolute;
   top: 20%;
   bottom: auto;
	}
  </style>
</head>

<body id="home" data-spy="scroll" data-target=".navbar" data-offset="60">

<!-- Navbar -->
<nav class="navbar navbar-default navbar-fixed-top">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" style="padding:0px;" href="#home"><img src="/resources/img/logo.png" height="100%"></a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav navbar-left">
      	<li><a href="#popular">인기코스보기</a></li>
        <li><a href="#create">코스만들기</a></li>
        <li><a href="#search">코스검색</a></li>
      </ul>
      <ul class="nav navbar-nav navbar-right">
      	<c:choose>
  			<c:when test="${empty login}">
    			<ul class="nav navbar-nav navbar-right">
      				<li id="register"><a href="#">회원가입</a></li>
        			<li id="login"><a href="#">로그인</a></li>
    			</ul>
  			</c:when>
  			<c:otherwise>
  				<ul class="nav navbar-nav navbar-right">
      				<li id="mypage"><a href=""  class="gotoNoUploadMypage">${login.userName}</a></li>
        			<li id="logout"><a href="#">로그아웃</a></li>
    			</ul>
  			</c:otherwise>
		</c:choose>
        
      </ul>
    </div>
  </div>
</nav>

<!-- Container (Introduction Section) -->
<div class="image">
	<img src="/resources/img/main.jpg" width="100%">
	<div class="centered">
		<h1 style="font-size:3em; font-weight: bold;">내 마음에 꼭 드는 여행 코스! 맴콕!</h1> 
  		<p style="font-size:2em; font-weight: bold;">자신만의 여행 코스를 만들고 다른사람들과 공유해보세요!</p> 
	</div>
</div>

<!-- Container (Popular Section) -->
<div id="pop">
	<div id="popular" class="container-fluid text-center" style="background-color:#337ab7;"></div>
	<div class="container-fluid text-center" style="background-color:#ffffff;">
  		<h2 style="color:#337ab7;">이달의 인기 코스</h2>
	</div>
	<!-- Top 1 -->
	<div id="top1" class="container-fluid text-center bg-grey">
		<h2>Top 1</h2>
	</div>
	<!-- Top 2 -->
	<div id="top2" class="container-fluid text-center">
		<h2>Top 2</h2>
	</div>
	<!-- Top 3 -->
	<div id="top3" class="container-fluid text-center bg-grey">
		<h2>Top 3</h2>
	</div>
	<!-- more -->
	<div id="more" class="container-fluid text-center">
		<button class="btn btn-default" id="courseMore">인기코스 더보기</button>
	</div>
</div>

<!-- Container (Create Section) -->
<div id="create" class="container-fluid">
  <div class="row">
    <div class="col-sm-6 col-sm-offset-2">
      <h2>코스 만들기</h2><br><br>
      <h4>자신만의 여행지를 선택하여 코스를 만들어 보아요~</h4>
      <p>지역과 여행지를 선택하고 날짜를 선택하면 끝!</p>
      <c:choose>
  			<c:when test="${empty login}">
    			<br><button class="btn btn-default btn-lg" id="courseMake" value="0">코스 만들러가기</button>
  			</c:when>
  			<c:otherwise>
  				<br><button class="btn btn-default btn-lg" id="courseMake" value="1">코스 만들러가기</button>
  			</c:otherwise>
		</c:choose>
    </div>
    <div class="col-sm-4">
      <span class="glyphicon glyphicon-flag logo"></span>
    </div>
  </div>
</div>

<!-- Container (Search Section) -->
<div id="search" class="container-fluid bg-grey">
  <div class="row">
  	<div class="col-sm-4 col-sm-offset-2">
      <span class="glyphicon glyphicon-search logo"></span>
    </div>
    <div class="col-sm-6">
      <h2>코스 검색</h2><br><br>
      <h4>다른 사람들이 만든 여행 코스를 검색해 보아요~</h4>
      <p>지역,닉네임 등으로 검색!</p>
      <br><button class="btn btn-default btn-lg" id="courseSearch">코스 검색하기</button>
    </div>
    
  </div>
</div>

<!-- Footer -->
<footer class="container-fluid text-center">
  <a href="#home" title="To Top">
    <span class="glyphicon glyphicon-chevron-up"></span>
  </a>
  <p>이 사이트는 한국관광공사의 Tour API를 활용하여 제작되었습니다. <a href="http://api.visitkorea.or.kr/main.do" title="Visit TourAPI">http://api.visitkorea.or.kr/main.do</a></p>
</footer>

<!-- Modals -->
  <!-- Modal 로그인 -->
  <div class="modal fade" id="loginModal" role="dialog">
    <div class="modal-dialog"> 
      <!-- Modal content-->
      <div class="modal-content">
      	<div class="modal-header">
          	<button type="button" class="close" data-dismiss="modal">&times;</button>
          	<h4 class="modal-title" style="text-align:center;">로그인</h4>
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
          <button type="submit" class="btn btn-default pull-right" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> 취소 </button>
        </div>
      </div>
      
    </div>
  </div>
  
  <!-- Modal - 회원가입 -->
  <div class="modal fade" id="registerModal" role="dialog" >
  	<div class="modal-dialog" style="height:500px; width:800px" >
    	<!-- Modal content-->
     	<div class="modal-content">
        	<div class="modal-header">
          		<button type="button" class="close" data-dismiss="modal">&times;</button>
          		<h4 class="modal-title" style="text-align:center;">회원가입</h4>
        	</div>
       		<div class="modal-body">
        		<form class="form-horizontal">
    				<div class="form-group">
      					<label class="control-label col-sm-2">이메일:</label>
      					<div class="col-sm-8">
        					<input type="email" class="form-control" id="email" placeholder="이메일을 입력해주세요.">
      					</div>
    				</div>
    				<div class="form-group">
    					<button type="button" class="btn btn-default col-sm-2 col-sm-offset-2" id="authMail">인증메일보내기</button>
      					<label class="control-label col-sm-2" for="auth">인증번호 </label>
      					<div class="col-sm-4">
        					<input type="text" class="form-control" id="auth" placeholder="인증번호를 입력해주세요." name="auth">
      					</div>
    				</div>
    				<div class="form-group">
      					<label class="control-label col-sm-2">비밀번호:</label>
      					<div class="col-sm-8" >          
        					<input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력해주세요.">
      					</div>
      					<label class="control-label col-sm-8 col-sm-offset-2" id="pwdC"></label>
    				</div>
    				<div class="form-group">
      					<label class="control-label col-sm-2">비밀번호 확인:</label>
      					<div class="col-sm-8">          
        					<input type="password" class="form-control" id="pwd2" placeholder="다시한번 비밀번호를 입력해주세요.">
      					</div>
      					<label class="control-label col-sm-8 col-sm-offset-2" id="pwdC2"></label>
    				</div>
    				<div class="form-group">
      					<label class="control-label col-sm-2">닉네임:</label>
      					<div class="col-sm-8">
        					<input type="text" class="form-control" id="name" placeholder="사용할 닉네임을 입력해주세요.">
      					</div>
      					<label class="control-label col-sm-8 col-sm-offset-2" id="nameC"></label>
    				</div>
  				</form>
        	</div>
        	<div class="modal-footer">
        		<button type="button" class="btn btn-default" id="checkRegister">완료</button>
        		<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
        	</div>
      </div>
    </div>
  </div>

</body>

<script>
$(document).ready(function(){
	if('${loginCheck}'==1)
		alert("로그인되었습니다.");
    $("#register").click(function(){
    	$("#registerModal").modal();    	
    });
    $("#login").click(function(){
    	$("#loginModal").modal();
    });
    $("#logout").click(function(){
    	alert("로그아웃되었습니다.");
    	location.href="/logout";
    });
    $("#courseMore").click(function(){
    });
    $("#courseMake").click(function(){
    	if(this.value=="0")
    		alert("로그인을 해주세요.");
    	else
    		location.href="/course/make/add1";
    });
    $("#courseSearch").click(function(){
    });
});

//mypage click
$('.gotoNoUploadMypage').on("click", function(){
	$.ajax({
    	type:'post',
        url: '/mypageNum',
        headers: {
			"Content-Type": "application/json",
			"X-HTTP-Method-Override": "POST"
		},
		success: function(result){
			 location.href="/mypage/" + result;
		}
    });
});

var checkpwd = false;
var checkpwd2 = false;
var checkname = false;

// 인증메일 보내기
$("#authMail").click(function(){
	if(document.getElementById("email").value!=""){
		var arr = new Array();
		var data = new Object();
		data.email = document.getElementById("email").value;
		arr.push(data);
		var email = JSON.stringify(arr);
		alert("잠시만 기다려주세요...");
		$.ajax({      
			type:"POST",  
			url:"/mail",
			dataType:"json",
			data:email,
			contentType:"application/json; charset=utf-8",
			success:function(msg){
				if(msg=="0")
					alert("이미 존재하는 이메일입니다.");
				else if(msg=="1")
					alert("인증번호를 보냈습니다. 메일을 확인해주세요.");
			},
		 	error:function(msg){
		 		alert("이메일을 다시확인해주세요.");
		 	}
		});
	}
	else {
		alert("이메일을 입력해주세요.");
	}
});
// 비밀번호 확인 1
$("#pwd").focusout(function(){
	var val = $(this).val(),
	regex = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{8,16}$/;
	
	var item = document.getElementById("pwdC");
	if(val=="" | val==null){
		item.innerHTML = "";
		checkpwd = false;
	}
	else if(!regex.test(val)){
		item.style.color = "red";
		item.innerHTML = "8자리 이상 16자리 이하, 영문자 + 숫자 혹은 특수 문자를 반드시 포함";
		checkpwd = false;
	}	
	else{	
		item.style.color = "green";
		item.innerHTML = "사용 가능";
		checkpwd = true;
	}
});
// 비밀번호 확인 2
$("#pwd2").focusout(function(){
	var val = $(this).val();
	var pwd = document.getElementById("pwd").value;

	var item = document.getElementById("pwdC2");
	if(val=="" | val==null){
		item.innerHTML = "";
		checkpwd2 = false;
	}
	else if(pwd==val){
		item.style.color = "green";
		item.innerHTML = "비밀번호 일치";
		checkpwd2 = true;
	}	
	else{	
		item.style.color = "red";
		item.innerHTML = "비밀번호 불일치";
		checkpwd2 = false;
	}
});
// 닉네임 확인
$("#name").focusout(function(){
	var val = $(this).val(),
	regex = /^[0-9a-zA-Z가-힣]{1,10}$/;

	var item = document.getElementById("nameC");
	if(val=="" | val==null){
		item.innerHTML = "";
		checkname = false;
	}
	else if(!regex.test(val)){
		item.style.color = "red";
		item.innerHTML = "최대 10자, 숫자,영문,한글 사용가능";
		checkname = false;
	}
	else{
		item.style.color = "green";
		item.innerHTML = "사용 가능";
		checkname = true;
	}
});
// 회원가입 확인
$("#checkRegister").click(function(){
	if(checkpwd==true && checkpwd2==true && checkname==true){
		var arr = new Array();
		var data = new Object();
		data.email = document.getElementById("email").value;
		data.authCode = document.getElementById("auth").value;
		data.pwd = document.getElementById("pwd").value;
		data.name = document.getElementById("name").value;
		
		arr.push(data);
		var authdata = JSON.stringify(arr);
		$.ajax({      
			type:"POST",  
			url:"/checkAuthCode",
			dataType:"json",
			data:authdata,
			contentType:"application/json; charset=utf-8",
			success:function(msg){
				if(msg=="0"){
					alert("인증번호를 확인해주세요.");
				}
				else if(msg=="1"){
					alert("회원가입이 완료되었습니다.");
					location.href="/";
				}
			},
	 		error:function(msg){
	 			alert(msg);
	 		}
		});
		
	}
	else{
		alert("다시 확인해주세요.");
	}
});

$(document).ready(function(){
  // Add smooth scrolling to all links in navbar + footer link
  $(".navbar a, footer a[href='#home']").on('click', function(event) {
    // Make sure this.hash has a value before overriding default behavior
    if (this.hash !== "") {
      // Prevent default anchor click behavior
      event.preventDefault();

      // Store hash
      var hash = this.hash;

      // Using jQuery's animate() method to add smooth page scroll
      // The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
      $('html, body').animate({
        scrollTop: $(hash).offset().top
      }, 900, function(){
   
        // Add hash (#) to URL when done scrolling (default click behavior)
        window.location.hash = hash;
      });
    } // End if
  });
  
  $(window).scroll(function() {
    $(".slideanim").each(function(){
      var pos = $(this).offset().top;

      var winTop = $(window).scrollTop();
        if (pos < winTop + 600) {
          $(this).addClass("slide");
        }
    });
  });
})
</script>

</html>
