<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <link href="https://fonts.googleapis.com/css?family=Montserrat" rel="stylesheet" type="text/css">
  <link href="https://fonts.googleapis.com/css?family=Lato" rel="stylesheet" type="text/css">

  <style>
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

<nav class="navbar navbar-default">
  <div class="container">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
      </button>
      <a class="navbar-brand" style="padding:0px;" href="#"><img src="/resources/img/ll.png" height="100%"></a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
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
      				<li><a class="gotoNoUploadMypage">마이페이지</a></li>
        			<li id="logout"><a href="#">로그아웃</a></li>
    			</ul>
  			</c:otherwise>
		</c:choose>
      </ul>
    </div>
  </div>
</nav>

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

<script>
$("#register").click(function(){
	$("#registerModal").modal();    	
});
$("#login").click(function(){
	$("#loginModal").modal();
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
$("#logout").click(function(){
	location.href="/logout";
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
</script>
</html>
