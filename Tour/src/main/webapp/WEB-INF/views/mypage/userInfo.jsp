<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>개인정보 수정</title>
  <meta charset="utf-8">
  <meta name="viewport">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<style>
html, body {
	height: 84%;
}
.userInfoContainer {
	padding-top:10px;
	background-color:#FFFFFF;
	padding-left:350px;
	width:1100px;
	margin-top:20px;
	margin-left:300px !important;
	height: 100%;
}
.header {
	border-bottom:1px solid #3f2018;
}
.headerContent {
	background-color:#FFFFFF;
	padding:10px 30px 50px 30px;
}
.bodyContent {
	margin-bottom:30px;
}

.footerContent {
	margin-top: 10px;
}

#userDelete {
	position:fixed;
	top:30%;
	left:30px;
}
</style>
<body style="background-color:#f2f2f2" id='home'>

<!-- header -->
<%@include file="../include/navbar.jsp" %>

<!-- sidenav -->
<%@include file="../include/sidenav.jsp" %>

<div class="container-fluid  userInfoContainer">
	<div class="headerContent">
		<div class="header">
			<h1>개인정보 관 리</h1>
			<p>개인정보를 수정합니다.</p>
		</div>
	</div>
	<div class="bodyContent">
		<form class="form-horizontal">
			<div class="form-group">
				<label class="control-label col-sm-2">이메일:</label>
				<div class="col-sm-8">
					<input type="email" class="form-control" id="userInfoEmail" value="${user.getEmail() }" readonly>
				</div>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2">비밀번호:</label>
				<div class="col-sm-8" >          
					<input type="password" class="form-control" id="userInfoPwd" placeholder="비밀번호를 입력해주세요.">
				</div>
				<label class="control-label col-sm-8 col-sm-offset-2" id="userInfoPwdC"></label>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2">비밀번호 확인:</label>
				<div class="col-sm-8">          
					<input type="password" class="form-control" id="userInfoPwd2" placeholder="다시한번 비밀번호를 입력해주세요.">
				</div>
				<label class="control-label col-sm-8 col-sm-offset-2" id="userInfoPwdC2"></label>
			</div>
			<div class="form-group">
				<label class="control-label col-sm-2">닉네임:</label>
				<div class="col-sm-8">
					<input type="text" class="form-control" id="userInfoName" value="${user.getUserName() }">
				</div>
				<label class="control-label col-sm-8 col-sm-offset-2" id="userInfoNameC"></label>
			</div>
		</form>
	</div>
	<div class="footerContent">
		<button type="button" class="btn btn-default deleteUser" style="float:left; background-color:#ffffff; color:#3f2018;">회원 탈퇴</button>
		<button type="button" class="btn btn-default modifyUser" style="float:right; background-color:#3f2018; color:#ffffff;">완료</button>
	</div>
</div>

<!-- footer -->
<%@include file="../include/footer.jsp" %>

<!-- userDelete Modal -->
<div class="modal fade" id="userDelete" role="dialog">
	<div class="modal-dialog" style="width:300px;">
  
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header" style="height:50px;">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">확인창</h4>
			</div>
			<div class="modal-body" style="height:70px;">
				<p>정말 탈퇴하시겠습니까?</p>
			</div>
			<div class="modal-footer" style="height:60px;">
				<button type="button" class="btn btn-default delete" data-dismiss="modal" style="height:35px; background-color:#3f2018; color:#ffffff;">네</button>
				<button type="button" class="btn btn-default no" data-dismiss="modal" style="height:35px; background-color:#3f2018; color:#ffffff;">아니오</button>
			</div>
		</div>
    
	</div>
</div>

</body>
<script>
var userInfoCheckpwd = false;
var userInfoCheckpwd2 = false;
var userInfoCheckname = true;

// 비밀번호 확인 1
$("#userInfoPwd").focusout(function(){
	var val = $(this).val();
	regex = /^(?=.*[a-zA-Z])((?=.*\d)|(?=.*\W)).{8,16}$/;
	
	var item = document.getElementById("userInfoPwdC");
	if(val=="" | val==null){
		item.innerHTML = "";
		userInfoCheckpwd = false;
	}
	else if(!regex.test(val)){
		item.style.color = "red";
		item.innerHTML = "8자리 이상 16자리 이하, 영문자 + 숫자 혹은 특수 문자를 반드시 포함";
		userInfoCheckpwd = false;
	}	
	else{
		item.style.color = "green";
		item.innerHTML = "사용 가능";
		userInfoCheckpwd = true;
	}
});
// 비밀번호 확인 2
$("#userInfoPwd2").focusout(function(){
	var val = $(this).val();
	var pwd = document.getElementById("userInfoPwd").value;

	var item = document.getElementById("userInfoPwdC2");
	if(val=="" | val==null){
		item.innerHTML = "";
		userInfoCheckpwd2 = false;
	}
	else if(pwd==val){
		item.style.color = "green";
		item.innerHTML = "비밀번호 일치";
		userInfoCheckpwd2 = true;
	}	
	else{	
		item.style.color = "red";
		item.innerHTML = "비밀번호 불일치";
		userInfoCheckpwd2 = false;
	}
});
// 닉네임 확인
$("#userInfoName").focusout(function(){
	var val = $(this).val();
	regex = /^[0-9a-zA-Z가-힣]{1,10}$/;

	var item = document.getElementById("userInfoNameC");
	if(val=="" | val==null){
		item.innerHTML = "";
		userInfoCheckname = false;
	}
	else if(!regex.test(val)){
		item.style.color = "red";
		item.innerHTML = "최대 10자, 숫자,영문,한글 사용가능";
		userInfoCheckname = false;
	}
	else{
		item.style.color = "green";
		item.innerHTML = "사용 가능";
		userInfoCheckname = true;
	}
});

$(".modifyUser").click(function(){
	if(userInfoCheckpwd==true && userInfoCheckpwd2==true && userInfoCheckname==true){
		var email = document.getElementById("userInfoEmail").value;
		var pwd = document.getElementById("userInfoPwd").value;
		var name = document.getElementById("userInfoName").value;
		var sendData = email + "/" + pwd + "/" + name + "/";
		
		$.ajax({      
			type:"POST",
			url:"/mypage/modify",
			dataType:"text",
			data: sendData,
			contentType:"application/text; charset=utf-8",
			success:function(){
				alert("회원정보가 수정되었습니다.");
				location.reload();
			},
	 		error:function(){
	 			alert("회원정보 수정 실패");
	 		}
		});
		
	}
	else{
		alert("다시 확인해주세요.");
	}
});
$(".deleteUser").click(function(){
	$('#userDelete').modal();
});
$('.delete').click(function(){
	$.ajax({      
		type:"POST",
		url:"/userDelete",
		success:function(){
			alert("회원탈퇴 성공");
			location.href="/";
		},
	 	error:function(){
	 		alert("회월탈퇴 실패");
	 	}
	});
});
</script>
</html>