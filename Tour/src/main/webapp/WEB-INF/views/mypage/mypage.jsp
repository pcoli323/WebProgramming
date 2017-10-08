<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>마이페이지</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<style>
	.navbar {
		margin-bottom: 0;
		border-radius: 0;
		background-color: #000000;
		border: none;
		color:#FFFFFF;
	}
	.navbar2 {
		margin-bottom: 0;
		border-radius: 0;
		background-color : pink;
		border: none;
		color: #FFFFFF;
		height: 70px;
		top: 50px;
	}
	/* Set height of the grid so .sidenav can be 100% (adjust as needed) */
	.row.content {height: 450px}
    
	/* Set gray background color and 100% height */
	.sidenav {
		padding-top: 100px;
		background-color: #f1f1f1;
		height: 200%;
		text-align: center;
	}
    
	/* Set black background color, white text and some padding */
	footer {
		background-color: #555;
		color: white;
		padding: 15px;
	}
    
	/* On small screens, set height to 'auto' for sidenav and grid */
	@media screen and (max-width: 767px) {
		.sidenav {
			height: auto;
			padding-top: 20px;
		}
		.row.content {height:auto;} 
	}
	.mypageDiv {
		padding-top:10px;
	}
	.selectCourseName {
		width:200px;
	}
	
	html, body{overflow-x:hidden;}
	
	table{
	width:170px;
	height:250px;
	}
	table th{
	padding:10px;
	}
	table td{
	padding:20px;
	}
	
	.courseView{
	width:1010px;
	resize:none;
	padding:20px;
	margin:auto;
	}
	.planTables{
	background-color:#F2F2F2;
	padding:20px;
	}
	.planTable{
	background-color:#F2F2F2;
	width:20%;
	display:inline-block;
	margin:20px;
	}
	.mapView{
	margin:30px;
	height:250px;
	}
	.media{
	border-top:1px solid #FFCCCC;
	padding:20px;
	padding-bottom:0px;
	}
	</style>
</head>
<body>
<script>
var courseName = ${courseName };
var courseNumByName = ${courseNumByName };
</script>
<nav class="navbar navbar-inverse">
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
						<li id="logout"><a href="/"> 로그아웃 </a></li>
					</ul>
				</c:otherwise>
			</c:choose>
	      
		</div>
	</div>
</nav>


<nav class="navbar2 navbar-inverse">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>                        
			</button>
      <a class="navbar-brand" style="margin:0;padding:0;" href="/"><h2>WebsiteName</h2></a>
		</div>
		<div class="collapse navbar-collapse" id="myNavbar">
	      
		</div>
	</div>
</nav>

<script>
	var map;
	function initMap() {
		var mapcenter = {lat: 37.3422186, lng: 127.92016209999997};
		map = new google.maps.Map(document.getElementById('map'), {
			zoom: 5,
			center: mapcenter
		});
	}
	var markers = [];
	var infowindows = [];
	function makeMarker(locationX, locationY, image, title){
		if(locationX != ""){
			var mapPositions = new google.maps.LatLng(locationY, locationX);
			var marker = new google.maps.Marker({
				position: mapPositions,
				map: map,
				title:title,
			});
			markers.push(marker);
			if(image != ""){
				var contentString = "<div style='float:left;'><img style='width:150px; height:100px;' src=" + image 
										+ "></div><div style='float:right; padding: 10px;'>" + title +"</div>";
			
			} else
				var contentString = "<div style='float:left;'></div><div style='float:right; padding: 10px;'>" + title +"</div>";
			var infowindow = new google.maps.InfoWindow({
									content: contentString,
									size: new google.maps.Size(200,100)});
			infowindows.push(infowindow);
			markerListener(marker, infowindow);
		}
	}
	function markerListener(localmarker, infowindow){    
	      	google.maps.event.addListener(localmarker, 'click', function() {
				infowindow.open(map, localmarker);
				localmarker.setAnimation(google.maps.Animation.BOUNCE);
				});
	      	google.maps.event.addListener(infowindow, 'closeclick', function(){
				localmarker.setAnimation(null);
			});
	}
</script>

<div class="container-fluid" style="padding-right:15%; padding-left:15%;">
	<div class="row content">
		<div class="col-sm-2 sidenav">
			<p><a href="/mypage">코    스     관    리</a></p><br><br><br><br><br><br>
			<p><a href="/course/make/add1">코    스     생    성</a></p><br><br><br><br><br><br>
			<p><a href="#">팔  로  우   관  리</a></p><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
			<p><a href="#">개 인 정 보  수 정</a></p>
		</div>
		<div class="mypageDiv col-sm-8 text-center"> 
			<!-- My course -->
			<div>
				<form>
					<select class="selectCourseName" id="selectCourseName">
					
					</select>
				</form>
			</div>
		</div>
	</div>
</div>
<script>
var loginCheck;
var loginUserNumber;
var courseNumber;
var following;
$(document).ready(function(){
	// 변수 초기화
	loginCheck = ${loginCheck};
	if(loginCheck == false){
		loginUserNumber = null;
	}
	else{
		loginUserNumber = ${loginUser.userNumber};
	}
});

var str = "";
str += "<option value=" + -1 + ">코스를 선택하세요.</option>"
for(var i=0; i<courseName.length; i++){
	str += "<option value=" + courseNumByName[i] + ">" + courseName[i] + "</option>";
}
document.getElementById("selectCourseName").innerHTML = str;

$(document).on("change",".selectCourseName",function(){
	var courseNumber = document.getElementById('selectCourseName').value;
	document.getElementById('selectCourseName').select = courseNumber;
    location.href="/mypage/" + courseNumber;
});
</script>
</body>
</html>