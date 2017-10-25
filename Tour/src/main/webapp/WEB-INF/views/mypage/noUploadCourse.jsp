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
	@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);
	html, body{overflow-x:hidden;}
	body {
		font-family: "Lato", sans-serif;
	}
	/* Set height of the grid so .sidenav can be 100% (adjust as needed) */
	.row.content {height: 450px}
    
	/* On small screens, set height to 'auto' for sidenav and grid */
	
	@media screen and (max-height: 450px) {
		.sidenav {padding-top: 15px;}
		.sidenav a {font-size: 18px;}
		.row.content {height:auto;} 
	}

	.mypageDiv {
		padding-top:10px;
		background-color:#FFFFFF;
		padding-left:350px;
		width:1100px;
		margin-top:20px;
		margin-left:400px;
	}
	.selectCourseName {
		width:200px;
	}
	.mycourse {
		text-align:right;
	}
	table{
	width:100%;
	min-height:250px;
	border-bottom-right-radius: 15px 25px;
	}
	table th{
	padding:10px;
	}
	table td{
	padding:20px;
	}
	.courseView{
	width:100%;
	resize:none;
	padding:50px;
	padding-top:0px;
	margin:auto;
	}
	.planTables{
	background-color:white;
	padding:20px;
	display:inline-block;
	width:40%;
	}
	.planTable{
	margin:20px 20px 50px 20px;
    position: relative;
    z-index: 0;
	border:1px solid #E8E8E8;
	border-bottom-right-radius: 100px 30px;
	}
	.planTable:after{
	content: "";
	position: absolute;
    z-index: -1;
    right: 1px;
    bottom: 45px;
    width: 90%;
    height: 20%;
    background: #F2F2F2;
    box-shadow: 2px 50px 5px rgba(0, 0, 0, 0.40);
    transform: matrix(1, 0.07, -0.1, 1, 0, 0);
    border-bottom-right-radius: 10px 20px;
	}
	.goto{
	font-family:'Nanum Pen Script', serif;
	font-size:250%;
	}
	.infoContent{
	padding-left:30px;
	display:inline-block;
	width:60%;
	}
	.mapView{
	height:220px;
	width:100%;
	}
	.mapContent{
	height:90%;
	width:100%;
	}
	.infoView{
	height:400px;
	width:100%;
	display:none;
	margin-top:10px;
	border: 1px solid green;
	}
	.imageView{
	width:100%;
	height:82%;
	background-color:black;
	text-align:center;
	vertical-align:middle;
	}
	.imageContent{
	max-width:100%;
	height:auto;
	max-height:100%;
	}
	.noImageContent{
	font-size:100%;
	position:relative;
	background-color:black;
	color:white;
	top:50%;
	}
	.info{
	width:100%;
	height:18%;
	padding:10px;
	}
	.symbolButton{
  	font-size: 14px;
  	text-align: center;
  	vertical-align: middle;
  	border: 1px solid transparent;
  	background-color:#ffffff;
  	outline:0
	}
	.story{
	border:1px solid gold;
	padding:20px;
	line-height:200%;
	}
	.symbol{
	font-size:30px;
	color:#000000;
	}
	.media{
	border-top:1px solid #FFCCCC;
	padding:20px;
	padding-bottom:0px;
	}
	.replyInputForm{
	margin-top:20px;
	border-top:1px solid #FFCCCC;
	padding:15px;
	padding-bottom:0px;
	display:none;
	}
	.inputForm{
	margin:10px;
	width:97%;
	padding:10px;
	}
	.replyInputFormButton{
	text-align:right;
	padding-bottom:15px;
	padding-right:20px;
	display:none;
	}
	.bg-grey {
		background-color: #f6f6f6;
	}
	.header {
		padding-top:5px;
		padding-bottom:5px;
		border-bottom:1px solid #337ab7;
	}
	.allView {
		padding-top:30px;
	}
	.courseView-header {
		margin-bottom:50px;
	}
	</style>
	
	<!-- map처리 -->
<script>
	var map;
	function initMap() {
		var mapcenter = {lat: 35.6867229, lng: 127.9095155};
		map = new google.maps.Map(document.getElementById('map'), {
			zoom: 6,
			center: mapcenter
		});
	}

	function pinSymbol(color) {
		return {
			path: google.maps.SymbolPath.CIRCLE,
			fillColor: color,
			fillOpacity: 1,
			strokeColor: color,
			strokeWeight: 1,
			scale: 5,
		};
	}
	var markers = [];
	var infowindows = [];
	var markerIndex = 0;
	var gotoNumberMapMarker = new Map();
	var flightPlanCoordinates = [];
	var polyLineCount = 0;
	
	function makeMarker(locationX, locationY, image, title, tel, address, id){
		if(locationX != ""){
			
			var mapPositions = new google.maps.LatLng(locationY, locationX);
			var marker = new google.maps.Marker({
				position: mapPositions,
				map: map,
				title:title,
				icon:pinSymbol("red"),
				animation:null
			});
			
			markers.push(marker);
			if(image != ""){
				var contentString = "<div style='float:left;'><img style='width:150px; height:100px;' src=" + image 
										+ "></div><div style='float:right; padding: 10px;'>" + title + "<br>" + address + "<br>" + tel +"</div>";
			
			} else
				var contentString = "<div style='float:left;'></div><div style='float:right; padding: 10px;'>" + title + "<br>" + address + "<br>" + tel + "</div>";
			var infowindow = new google.maps.InfoWindow({
									content: contentString,
									size: new google.maps.Size(200,100)});
			infowindows.push(infowindow);
			markerListener(marker, infowindow, id);
			gotoNumberMapMarker.set(id, markerIndex);
			markerIndex++;
			
			flightPlanCoordinates[polyLineCount] = new google.maps.LatLng(locationY, locationX);
			polyLineCount++;
			
			var flightPath = new google.maps.Polyline({
				path: flightPlanCoordinates,
				geodesic: true,
				strokeColor: '#FF0000',
				strokeOpacity: 1.0,
				strokeWeight: 2
			});
			flightPath.setMap(map);
		}
	}
	function markerListener(localmarker, infowindow, id){    
		google.maps.event.addListener(localmarker, 'click', function() {
			//infowindow.open(map, localmarker);
			for(var i=0; i<markers.length; i++){
				markers[i].setAnimation(null);
			}
			showInfo(id);
			localmarker.setAnimation(google.maps.Animation.BOUNCE);
		});
		google.maps.event.addListener(infowindow, 'closeclick', function(){
			localmarker.setAnimation(null);
		});
	}
</script>
<script>
	//planTable의 글자크기 자동조절
	var images = [];
	var infos = new Map();
	function fitFontSize(id, length){
		var size = length - 12;
		fontSize = 250 - size*10;
		$('#'+id).attr("style", "font-size:"+fontSize+"%;");
	}
</script>

</head>
<body class="bg-grey">
<!-- header -->
<%@include file="../include/navbar.jsp" %>
<script>
var courseName = ${courseName };
var courseNumByName = ${courseNumByName };
</script>

<!-- sidenav -->
<%@include file="../include/sidenav.jsp" %>
		
<div class="container-fluid mypageDiv">
	<div class="header">
		<h1>코 스 관 리</h1>
		<p>게시 전 코스</p>
	</div>
	<!-- My course -->
	<div class="allView">
		<div class="mycourse">
			<form>
				<select class="selectCourseName" id="selectCourseName">
				
				</select>
			</form>
		</div>
		<div class="courseView">
			<div class="courseView-header">
			
				<h2 class="courseName" style="text-align:center">
					${courseVO.courseName}
				</h2>
			</div><!-- /courseView-header -->
	        
	        <div class="courseView-body">
	        
	        	<div class="main" style="display:flex;margin-bottom:35px;">
	       			<div class="planTables">
	       				<c:set var="gotoID" value="0"></c:set>
	        			<c:forEach var="date" items="${plan.keySet()}">
	        				<div class="planTable">
	        					<table style="background-color:#ffff99">
	        						<tr class="dtaeField" >
	        							<th style="text-align:center;height:30px;background-color:#ffff80">${date}</th>
	        						</tr>
	        						<tr class="gotoField">
	        							<td style="text-align:center">
	        								<c:set var="gotoList" value="${plan.get(date)}"></c:set>
        									<c:forEach var="gotoOne" items="${gotoList}">
	        									<div><span class="goto" id="${gotoID}">${gotoOne.gotoName}</span></div>
	        									<script>
	        										var length = ${gotoOne.gotoName.length()};
	        										var id = ${gotoID};
	        										if(length>13){
	        											fitFontSize(id, length);
	        										}
	        										var image = "${gotoOne.gotoImage}";
	        										var info = [];
	        										info.push("${gotoOne.gotoName}");
	        										info.push("${gotoOne.address}");
	        										info.push("${gotoOne.tel}");
	        										images.push(image);
	        										infos.set(id, info);
	        									</script>
        										<c:set var="gotoID" value="${gotoID + 1}"></c:set>
        									</c:forEach>
        								</td>
        							</tr>
        						</table>
        					</div>
        				</c:forEach>
        			</div><!-- /planTable -->
        		
	        		<div class="infoContent">
	        			<div class="move" style="position:relative;">
	        				<div class="mapView">
	        					<div class="mapContent" id="map">
	        					<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdkQ3O7ZOpSt2RjwxkSVzgF1NGSHyqkuM&callback=initMap"></script>
	        					<c:set var="gotoID" value="0"></c:set>
	        					<c:forEach var="date" items="${plan.keySet()}">
	        						<c:set var="gotoList" value="${plan.get(date)}"></c:set>
        								<c:forEach var="gotoOne" items="${gotoList}">
        									<script>
        										makeMarker("${gotoOne.locationX}", "${gotoOne.locationY}", "${gotoOne.gotoImage}", "${gotoOne.gotoName}", "${gotoOne.tel}", "${gotoOne.address}", "${gotoID}");
        									</script>
        									<c:set var="gotoID" value="${gotoID + 1}"></c:set>
        								</c:forEach>
        							</c:forEach>
        						</div>
        						<div class="mapInfo" style="text-align:right;color:red;font-size:13px;display:none">
        							위치정보가 없습니다.
        						</div>
        					</div><!-- /mapView -->
        				
        					<div class="infoView">
        						<div class="imageView">
        						</div>
        						<div class="info">
        						</div>
        					</div><!-- /infoView -->
        				</div><!-- move -->
        			</div><!-- /infoContent -->
				</div><!-- /main -->

        		<c:if test="${courseVO.story ne null}">
        			<div class="story" style="margin-bottom:10px;">
        				${courseVO.story}
					</div>
				</c:if>
        			
			</div><!-- /courseView-body -->
        
			<div class="courseView-footer" style="text-align:right; clear:left">
				<button type="button" class="btn btn-default modify">수정</button>
				<button type="button" class="btn btn-default delete">삭제</button>
				<button type="button" class="btn btn-default post">게시</button>
			</div><!-- /courseView-footer -->
		</div><!-- /courseView -->
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
	courseNumber = ${courseVO.courseNumber};
	following = ${userVO.userNumber};
});

// map이 scroll 따라 다니도록
$(window).scroll(function(){
	var position = $(window).scrollTop();
	var maxPosition = $(".infoContent").height() - $(".move").height();
	if(position < maxPosition){
		$(".move").stop().animate({"top":position+"px"},1000);
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

// goto 마우스로 over되면 색 변하도록
$('.goto').mouseover(function(){
	var id = $(this).attr("id");
	var str = $(this).attr("style");
	
	str = str + ";background-color:#d9ff66;cursor:pointer;";
	$(this).attr("style", str);
	markers[id].setIcon((pinSymbol("green")));
});
$('.goto').mouseout(function(){
	var id = $(this).attr("id");
	var str = $(this).attr("style").split(';');
	
	$(this).attr("style", str[0]);
	markers[id].setIcon((pinSymbol("red")));
});

// goto 누르면 지도에 해당하는 marker에 대해 작동하도록
// markers[]
$('.goto').on("click", function(){
	var id = $(this).attr("id");
	
	showMap(id);
	showInfo(id);
});

// map의 정보 보여주기
function showMap(id){
	if(gotoNumberMapMarker.has(id) == true){
		//infowindows[index].open(map, markers[index]);
		var index = gotoNumberMapMarker.get(id);
		if(markers[index].getAnimation() == null){
			for(var i=0; i<markers.length; i++){
				if(i != index){
					markers[i].setAnimation(null);
				}
			}
			markers[index].setAnimation(google.maps.Animation.BOUNCE);
			map.setCenter(markers[index].getPosition());
			map.setZoom(10);
			$('.mapInfo').hide();
		}
	}
	else{
		for(var i=0; i<markers.length; i++){
			markers[i].setAnimation(null);
		}
		$('.mapInfo').show();
	}
}
// info 보여주기
function showInfo(id){
	var image = images[id];
	var str;
	if(image != null && image != ""){	
		str = "<image src='" + image + "' class='imageContent'>";
		$('.imageView').html(str);
	}
	else{
		str = "<div class='noImageContent'>사진이 없습니다</div>";
		$('.imageView').html(str);
	}
	
	// info
	var info = [];
	info = infos.get(Number(id));
	str = "<div style='font-size:15px;'>"+info[0]+"</div>"
		+ "<div style='font-size:13px;'>주소 : "+info[1]+"</div>"
		+ "<div style='font-size:13px;'>전화번호 : "+info[2]+"</div>";
	$('.info').html(str);
	
	$('.infoView').show();
}

$('.delete').on("click",function(){
	$.ajax({
		type:'POST',
		url:'/mypage/delete/'+courseNumber,
		headers: { "Content-Type": "application/json" },
		success: function(result){
			alert("삭제되었습니다.");
			location.href='/mypage/' + result;
		}
    });
})

$('.modify').on("click",function(){
	$.ajax({
    	type:'post',
        url: '/mypage/modify/${courseNumber }',
        headers: {
			"Content-Type": "application/json",
			"X-HTTP-Method-Override": "POST"
		},
		success: function(result){
			 location.href="/course/make/add1";
		}
    });
})
</script>		
<!-- footer -->
<%@include file="../include/footer.jsp" %>
</body>
</html>