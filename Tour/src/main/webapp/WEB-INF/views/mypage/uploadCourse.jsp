<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>마이페이지</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<style>
	html, body {
		height: 84%;
	}
	#lastImageView {
		height:120px;
		text-align:center;
		color:gray;
	}
	.header {
		border-bottom:1px solid #3f2018;
	}
	.headerContent {
		background-color:#FFFFFF;
		padding:10px 30px 10px 30px;
	}

	.mypageDiv {
		padding-top:10px;
		background-color:#FFFFFF;
		padding-left:350px;
		width:1100px;
		margin-top:20px;
		margin-left:300px !important;
		height: auto;
	}
	.bg-grey {
		background-color:#f6f6f6;
	}
</style>
<body class="bg-grey" id='home'>
<!-- header -->
<%@include file="../include/navbar.jsp" %>

<!-- sidenav -->
<%@include file="../include/sidenav.jsp" %>

<div class="container-fluid mypageDiv">
	<div class="headerContent">
		<div class="header">
			<h1>코 스 관 리</h1>
			<p>게시 된 코스</p>
		</div>
	</div>
	
	<div class="mypageSimpleView">
	</div>		
	
	<div id="lastImageView">
		<br><br><br><br><p>End</p>
	</div>

</div>

<script>
	var loginCheck;
	var loginUserNumber;
	$(document).ready(function(){
		// 변수 초기화
		loginCheck = ${loginCheck};
		if(loginCheck == false){
			loginUserNumber = null;
		}
		else{
			loginUserNumber = ${loginUser.userNumber};
		}
		
		var mypage = true;
		var position = ".mypageSimpleView";
		var result = ${courseNumber };
		console.log(result);
		simpleView(result, mypage, position);
		
	});
</script>

<%@include file="../course/view/simple.jsp" %>

<!-- footer -->
<%@include file="../include/footer.jsp" %>

</body>
</html>