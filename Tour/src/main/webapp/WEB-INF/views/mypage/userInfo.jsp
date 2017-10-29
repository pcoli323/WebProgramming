<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>개인 정보 수정</title>
</head>
<body>
	<div class="modal-body">
		<form class="form-horizontal">
			<div class="form-group">
				<label class="control-label col-sm-2">이메일:</label>
				<div class="col-sm-8">
					<input type="email" class="form-control" id="email" placeholder="이메일을 입력해주세요.">
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