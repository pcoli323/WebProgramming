<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta charset="UTF-8">
	<title>개인정보 수정</title>
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
</head>
<style>
.userInfoContainer {
    margin-left: 300px;
    margin-right: 300px;
    padding: 50px;
    padding-top: 10px;
    height: 700px;
}
.header {
	border-bottom:1px solid #337ab7;
}
.headerContent {
	background-color:#FFFFFF;
	padding:10px 30px 50px 30px;
}
.bodyContent {
	margin-bottom:30px;
}
.footerContent btn {
	margin-right:5px;
}
</style>
<body>

<!-- header -->
<%@include file="../include/navbar.jsp" %>

<!-- sidenav -->
<%@include file="../include/sidenav.jsp" %>

<div class="userInfoContainer">
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
					<input type="email" class="form-control" id="email" value="${user.getEmail() }" readonly>
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
	<div class="footerContent">
		<button type="button" class="btn btn-default deleteUser" style="float:left;">회원 탈퇴</button>
		<button type="button" class="btn btn-default modifyUser" style="float:right;">완료</button>
		<button type="button" class="btn btn-default cancel" style="float:right; margin-right:5px;">취소</button>
	</div>
</div>

<!-- footer -->
<%@include file="../include/footer.jsp" %>

</body>
<script>
var checkpwd = false;
var checkpwd2 = false;
var checkname = false;

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
</script>
</html>