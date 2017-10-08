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
  #section44 {padding-top:120px;height:200px;color: #fff; background-color: #673ab7;}
  #section45 {padding-top:120px;height:300px;color: #fff; background-color: #ff9800;}
  
  #loginModal {
   position: absolute;
   top: 100px;
   right: 450px;
   bottom: auto;
   left: auto;
	}
	
 #registerModal {
   position: absolute;
   top: 100px;
   left: 350px;
   bottom: auto;
   right: auto;
	}
	
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
      			<li id="mypage"><a href="#"> 마이페이지 </a></li>
      			<li id="logout"><a href="#"> 로그아웃 </a></li>
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
		<p>(Footer) API 제공 : 한국 관광공사</p>
	</div>
</div>

	<!-- Modal 로그인 -->
  <div class="modal fade" id="loginModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="padding:35px 50px;">
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
          <button type="submit" class="btn btn-danger btn-default pull-right" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> 취소 </button>
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
        		<button type="button" class="btn btn-default" id="checkR">완료</button>
        		<button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
        	</div>
      </div>
    </div>
  </div>
  
</body>
<script>
var checkpwd = false;
var checkpwd2 = false;
var checkname = false;

$(document).ready(function(){
    $("#reg").click(function(){
    	$("#registerModal").modal();    	
    });
    $("#login").click(function(){
    	$("#loginModal").modal();
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

$("#authMail").click(function(){
	var arr = new Array();
	var data = new Object();
	data.email = document.getElementById("email").value;
	arr.push(data);
	var email = JSON.stringify(arr);
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
	 		alert(msg);
	 	}
	});
	
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

$("#checkR").click(function(){
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

</script>
</html>
