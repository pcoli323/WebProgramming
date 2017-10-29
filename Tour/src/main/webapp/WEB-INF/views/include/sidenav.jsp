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
	.sidenav {
		height: 100%;
	    width: 270px;
	    position: fixed;
	    z-index: 1;
	    top: 0;
	    left: 0;
	    background-color: #FFFFFF;
	    overflow-x: hidden;
	    padding-top: 250px;
	    padding-left: 40px;
	}

	.sidenav a {
	    padding: 6px 6px 6px 32px;
	    text-decoration: none;
	    font-size: 18px;
	    color: #337ab7;
		display: block;
	}
	
	.sidenav a:hover {
		color: #f1f1f1;
		background-color: #337ab7;
	}
	
	.hideview {
	    text-decoration: none;
	    font-size: 10px;
	    color: #337ab7;
		display: block;
	}
	</style>
</head>

<div class="sidenav">
	<a>코    스     관    리</a><br>
	<ul>
		<li class="hideview"><a href="#" class="gotoNoUploadMypage">게시 전 코스</a></li><br>
		<li class="hideview"><a href="/uploadMypage">게시 된 코스</a></li><br>
	</ul>
	<a href="#">팔  로  우   관  리</a><br>
	<a href="#" class="userInfo">개 인 정 보  관 리</a>
</div>


<script>
$('.gotoNoUploadMypage').on("click", function(){
    location.href="/mypage/0";
});
$('.userInfo').on("click", function(){
	location.href="/mypage/userInfo";
});
</script>
</html>