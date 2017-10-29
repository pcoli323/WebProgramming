<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>코스 생성중 - 3단계</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style>
.content {
	display:flex;
}
#map {
	width: 750px;
	height: 750px;
	margin-right: 60px;
}
.course {
	float:right;
	background-color: #f2f2f2;
	padding: 30px;
	overflow: auto;
	height: 375px;
}
.course h3 {
	text-align:center;
}
.course input {
	height:23px;
	width:175px;
}
.schedule {
	float:right;
	background-color: #f2f2f2;
	padding: 30px;
	overflow: auto;
	height: 375px;
}
button {
	height: 1.7em;
	border: none;
}
</style>
<body>

<!-- header -->
<%@include file="../../include/navbar.jsp" %>

<div class="container" style="padding:10px; border:2px solid #F5F5F5;">
	<!-- 소개 -->
	<div>
		<h1>세 번째 단계 : 일정 선택 단계입니다.</h1>
		<p>여행 일정을 선택하여 주세요.</p>
	</div>
	
	<!-- 내용 -->
	<div class="content">
		<!-- map 출력 -->
		<div id="map"></div>
		
		<!-- 선택 여행지 출력 -->
		<div class="course">
			<h3>선택한 여행지</h3><br>
			<form id="gotoData"></form>
		</div>
		
		<!-- 전체 일정 출력 -->
		<div class="schedule">
	
		</div>
	</div>
</div>

<!-- 버튼 출력 -->

<!-- footer -->
<%@include file="../../include/footer.jsp" %>

</body>
<script>

// google map
var map;
function initMap() {
	var mapcenter = {lat: 36.350527, lng: 128.122559};
	map = new google.maps.Map(document.getElementById('map'), {
		zoom: 7,
		center: mapcenter
	});
}
function pinSymbol(color) {
	return {
		path: 'M 0,0 C -2,-20 -10,-22 -10,-30 A 10,10 0 1,1 10,-30 C 10,-22 2,-20 0,0 z M -2,-30 a 2,2 0 1,1 4,0 2,2 0 1,1 -4,0',
		fillColor: color,
		fillOpacity: 1,
		strokeColor: '#000',
		strokeWeight: 1,
		scale: 1,
	};
}
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdkQ3O7ZOpSt2RjwxkSVzgF1NGSHyqkuM&callback=initMap" async defer></script>
<script>
var jsonArr = JSON.parse('${list}');
var dateJson = JSON.parse('${idList}');
$(document).ready(function(){
	// 여행지 출력
	var gotoDataStr = "";
	for(var i=0; i<jsonArr.length; i++){
		gotoDataStr += "<input value='" + jsonArr[i].title + "' border=none readonly>";
		gotoDataStr += "<button type='button' class='calBtn'><span class='glyphicon glyphicon-calendar'></span></button>";
		gotoDataStr += "<button type='button' class='delBtn'><span class='glyphicon glyphicon-remove'></span></button><br><br>"
	}
	document.getElementById('gotoData').innerHTML = gotoDataStr;
});
</script>
</html>