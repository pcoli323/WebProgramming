<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>마이페이지</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<style>
	html, body {
		height: 84%;
	}
	.bg-grey {
		background-color: #f6f6f6;
	}
	.header {
		padding-top:5px;
		padding-bottom:5px;
		border-bottom:1px solid #3f2018;
	}

	.mypageDiv {
		padding-top:10px;
		background-color:#FFFFFF;
		padding-left:350px;
		width:1100px;
		margin-top:20px;
		margin-left:300px !important;
		height:100%;
	}
	</style>
</head>
<body class="bg-grey">
<!-- header -->
<%@include file="../include/navbar.jsp" %>
<!-- sidenav -->
<%@include file="../include/sidenav.jsp" %>

<div class="container-fluid mypageDiv">
	<div class="header">
		<h1>코 스 관 리</h1>
		<p>게시 전 코스</p>
	</div>
</div>
<!-- footer -->
<%@include file="../include/footer.jsp" %>
</body>
</html>