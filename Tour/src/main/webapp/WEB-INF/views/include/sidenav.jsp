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
	    width: 300px;
	    background-color: #111;
	    padding-top: 70px;
	    float:left;
	    margin-top: -30px;
	}

	.sidenav a {
	    padding: 6px 6px 6px 32px;
	    text-decoration: none;
	    font-size: 25px;
	    color: #818181;
		display: block;
	}
	
	.sidenav a:hover {
		color: #f1f1f1;
	}
	</style>
</head>

<div class="sidenav">
	<a class="sidenavAd">코    스     관    리</a><br>
	<ul>
		<li class="hideview" style="display:none;"><a class="gotoNoUploadMypage">게시 안 된 코스</a></li><br>
		<li class="hideview" style="display:none;"><a href="/uploadMypage">게시 된 코스</a></li><br>
	</ul>
	<a href="#">코    스     생    성</a><br><br><br><br>
	<a href="#">팔  로  우   관  리</a><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
	<a href="#">개 인 정 보  수 정</a>
</div>


<script>
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
$('.sidenavAd').on("click", function(){
	var str = "";
	if($('.hideview').attr("style")=="display:none;"){
		str = "display:block;";
		$('.hideview').attr("style", str);
	} else {
		str = "display:none;";
		$('.hideview').attr("style", str);
	}
});
$('.sidenavAd').mouseover(function(){
	var str = $(this).attr("style");
	
	str = str + ";cursor:pointer;";
	$(this).attr("style", str);
});
$('.sidenavAd').mouseout(function(){
	
	$(this).attr("style", "");
});
</script>
</html>