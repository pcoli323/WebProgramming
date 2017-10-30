<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html lang="en">
<head>
	<meta charset="UTF-8">
	<title>팔로우 관리</title>
  <meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<style>
.followAdContainer {
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
	display: inline-block;
}
.followList {
	width:1100px;
	height: 150px;
	background-color: white;
	margin: 20px 20px 10px 40px;
	padding: 10px;
}
.followList i {
	font-size:100px;
	color: gray;
	float : left;
	margin : 10px;
}
.followList p {
	font-size:50px;
	float : left;
}
.followList button {
	margin: 10px;
	float : right;
}
</style>
<body style='background-color:#f2f2f2'>

<!-- header -->
<%@include file="../include/navbar.jsp" %>

<!-- sidenav -->
<%@include file="../include/sidenav.jsp" %>


<div class="followAdContainer">
	<div class="headerContent">
		<div class="header">
			<h1>팔로우 관 리</h1>
			<p>팔로우를 관리합니다.</p>
		</div>
	</div>
	<div class="bodyContent" id="bodyContent">
	</div>
</div>

<!-- unfollow Modal -->
<div class="modal fade" id="unfollow" role="dialog">
	<div class="modal-dialog" style="width:300px;">
  
		<!-- Modal content-->
		<div class="modal-content">
			<div class="modal-header" style="height:50px;">
				<button type="button" class="close" data-dismiss="modal">&times;</button>
				<h4 class="modal-title">확인창</h4>
			</div>
			<div class="modal-body" style="height:70px;">
				<p>팔로우 취소하시겠습니까?</p>
			</div>
			<div class="modal-footer" style="height:60px;">
				<button type="button" class="btn btn-default unfollow" data-dismiss="modal" style="height:35px;">네</button>
				<button type="button" class="btn btn-default no" data-dismiss="modal" style="height:35px;">아니오</button>
			</div>
		</div>
    
	</div>
</div>

</body>
<script>
var users = JSON.parse('${users}');

followList();
function followList(){
	var str ="";
	for(var i=0; i<users.length; i++){
		str += "<div class='followList'><i class='material-icons'>person</i><p>" + users[i].userName + "</p>";
		str += "<br><br><button type=button class='btn btn-default unfollowbtn' id='" + users[i].userNumber + "-" + i + "'style='height:35px;'>팔로우 끊기</button>"
		str += "<button type=button class='btn btn-default searchViewbtn' id='" + users[i].userName + "'style='height:35px;'>코스 보기</button></div>";
	}
	document.getElementById('bodyContent').innerHTML = str;
}

var deleteUserNumber = -1;
var index = -1;
$(document).on("click",".unfollowbtn",function(){
	var id = this.id;
	id.split("-");
	deleteUserNumber = id[0];
	index = id[1];
	
	console.log(deleteUserNumber);
	$('#unfollow').modal();
});
$(document).on("click",".searchViewbtn",function(){
	var keyword = this.id;
	
	location.href = "/search?where='follow'&keyword='" + keyword + "'";
});

$('.unfollow').click(function(){
	$.ajax({      
		type:"POST",
		url:"/unfollowUser/" + deleteUserNumber,
		success:function(){
			users.splice(index, 1);
			followList();
		},
	 	error:function(){
	 		alert("실패");
	 	}
	});
});
</script>
</html>