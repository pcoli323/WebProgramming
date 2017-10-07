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
		padding-left : 15%;
		padding-right : 15%;
		background-color : pink;
		border: none;
	}
	/* Set height of the grid so .sidenav can be 100% (adjust as needed) */
	.row.content {height: 450px}
    
	/* Set gray background color and 100% height */
	.sidenav {
		padding-top: 100px;
		background-color: #f1f1f1;
		height: 900px;
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
		padding-top:80px;
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
	padding:50px;
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
	</style>
</head>
<body>
<script>
var arr = ${courseName };
</script>
<nav class="navbar navbar-inverse">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>                        
			</button>
			<a class="navbar-brand" href="#">WebsiteName</a>
		</div>
		<div class="collapse navbar-collapse" id="myNavbar">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="#"><span class="glyphicon glyphicon-log-in"></span> 로그아웃</a></li>
			</ul>
		</div>
	</div>
</nav>

<div class="container-fluid" style="padding-right:15%; padding-left:15%;">
	<div class="row content">
		<div class="col-sm-2 sidenav">
			<p><a href="#">코    스     관    리</a></p><br><br><br><br><br><br>
			<p><a href="#">코    스     생    성</a></p><br><br><br><br><br><br>
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
				<div class="courseView">
					<div class="courseView-header">
						<h2 class="courseName" style="text-align:center">
							${courseVO.courseName}
						</h2>
					</div><!-- /courseView-header -->
			        
			        <div class="courseView-body">
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
			        								<i class="goto" id="${gotoID}" style="">${gotoOne.gotoName}</i><br><br>
			        								<c:set var="gotoID" value="${gotoID + 1}"></c:set>
			        							</c:forEach>
			        						</td>
			        					</tr>
			        				</table>
			        			</div>
			        		</c:forEach>
			        	</div><!-- /planTable -->
			        	
			        	<!-- 지도 -->
			        	<div class="mapView" id="map">
			        			<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdkQ3O7ZOpSt2RjwxkSVzgF1NGSHyqkuM&callback=initMap"></script>
			        			<c:forEach var="date" items="${plan.keySet()}">
			        				<c:set var="gotoList" value="${plan.get(date)}"></c:set>
			        				<c:forEach var="gotoOne" items="${gotoList}">
			        					<script>
			        						makeMarker("${gotoOne.locationX}", "${gotoOne.locationY}", "${gotoOne.gotoImage}", "${gotoOne.gotoName}");
			        					</script>
			        				</c:forEach>
			        			</c:forEach>
			        	</div>
			        	
			        	
			        	<c:if test="${courseVO.story ne null}">
			        		<div class="story">
			        			${courseVO.story}
			        		</div>
			        	</c:if>
			        			
			        </div><!-- /courseView-body -->
			        		
			        <div class="courseView-footer" style="text-align:right; clear:left">
			        	<button type="button" class="symbolButton" id="like">
							<span class="glyphicon symbol" id="like_symbol" style="color:#ff0000"></span>
							<small class="likeNum"></small>
						</button>
						<button type="button" class="symbolButton" id="reply">
							<span class="glyphicon glyphicon-comment symbol"></span>
							<small class="replyNum"></small>
						</button>
						<button type="button" class="symbolButton" id="getCourse">
							<span class="glyphicon glyphicon-share-alt symbol"></span>
						</button>
					</div><!-- /courseView-footer -->
					
					<!-- reply button click으로 추가되는 부분 -->
					<div class="replySection">
						<div class="replyInputForm">
							<input class="inputForm" type="text" placeholder="댓글을 입력하세요" id="newReply">
						</div>
						<div class="replyInputFormButton text-right">
							<button type="submit" class="btn btn-sm" id="addReplyBtn" style="outline:0">등록</button>
						</div>
						<div class="replise">
						</div>
						<div class='text-center'>
							<ul id="pagination" class="pagination pagination-sm no-margin "></ul>
						</div>
					</div><!-- /replySection -->
					
					<!-- 댓글 수정을 위한 Modal -->
					<div class="modal fade" id="replyModifyModal" role="dialog">
						<div class="modal-dialog">
							<!-- Modal content -->
							<div class="modal-content">
								
								<div class="modal-header">
									<button type="button" class="close" data-dismiss="modal">&times;</button>
									<div class="modal-title" style="display:none"></div>
								</div><!-- modal-header -->
								
								<div class="modal-body">
									<input class="inputForm" type="text" id="modifyReply">
								</div><!-- modal-body -->
									
								<div class="modal-footer text-right">
									<button type="button" class="btn btn-success" id="modifyReplyBtn">수정</button>
									<button type="button" class="btn btn-danger" id="deleteReplyBtn">삭제</button>
								</div><!-- /modal-footer -->
								
							</div><!-- modal-content -->
						</div><!-- /modal-dialog -->
					</div><!-- replyModifyModal -->
			        
				</div><!-- /courseView -->
			</div>
		</div>
	</div>
</div>
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
<script>
var str = "";
for(var i=0; i<arr.length; i++){
	str += "<option value=" + i + ">" + arr[i] + "</option>";
}
document.getElementById("selectCourseName").innerHTML = str;

//예제 긁어온거(수정해야함)
$(document).on("change","#selectCourseName",function(){
	$.ajax({
		type:"POST",
		url:"/mypage/{courseNumber}",
		data:courseName,
    	contentType:"application/json; charset=utf-8",
    	success:function(){
    		var jsonData = JSON.stringify(jsonArr);
    		
		},
		error:function(){
			alert("실패");
		},
	});
});
</script>
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
	// view 초기화
	followCheck();
	likeCheck();
	likeNumber();
	replyNumber();
});

// courseView를 보는 사용자가 팔로우를 한 사용자인가?
function followCheck(){
	if(loginCheck == true){
		if(loginUserNumber != ${courseVO.userNumber}){
			$.ajax({
				type:'post',
				url:'/follow/check',
				headers:{
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "POST"
				},
				dataType:'text',
				data: JSON.stringify({
					following:following,
					followed:loginUserNumber
				}),
				success:function(result){
					console.log("result:" + result);
					if(result == 0){
						// 사용자가 팔로우를 하지 않은 상태
						followToggle("non-follow");
					}
					else{
						followToggle("follow");
					}
				}
			});
		}
	}
	else{
		followToggle("non-follow");
	}
}

// like 수
function likeNumber(){
	$.ajax({
		type:'get',
		url:'/like/count/'+courseNumber,
		headers: { "Content-Type": "application/json" },
		success:function(result){
			$('.likeNum').html(result);
		}
	});
}
// courseView를 보는 사용자가 종아요를 누른 사용자인가?
function likeCheck(){
	if(loginCheck == true){
		$.ajax({
			type:'post',
			url:'/like/check',
			headers:{
				"Content-Type": "application/json",
				"X-HTTP-Method-Override": "POST"
			},
			dataType:'text',
			data: JSON.stringify({
				courseNumber:courseNumber,
				userNumber:loginUserNumber
			}),
			success:function(result){
				console.log("result:" + result);
				if(result == 0){
					// 사용자가 좋아요를 누르지 않은 상태
					likeToggle("non-active");
				}
				else if(result == 1){
					// 사용자가 좋아요를 누른 상태
					likeToggle("ative");
				}
				else{
					console.log("check user number in like");
				}
			}
		});
	}
	else{
		likeToggle("non-active");
	}
}

// reply 수
function replyNumber(){
	$.ajax({
		type:'get',
		url:'/replise/count/'+courseNumber,
		headers: { "Content-Type": "application/json" },
		success:function(result){
			$('.replyNum').html(result);
		}
	});
}

// goto 마우스로 over되면 색 변하도록
$('.goto').mouseover(function(){
	var index = $(this).attr("id");
	
	if(index < markers.length){
		$(this).attr("style", "background-color:#d9ff66;cursor:pointer");
	}
	else{
		$(this).attr("style", "cursor:not-allowed");
	}
});
$('.goto').mouseout(function(){
	var index = $(this).attr("id");
	
	if(index < markers.length){
		$(this).attr("style", "");
	}
});

// goto 누르면 지도에 해당하는 marker에 대해 작동하도록
// markers[]
$('.goto').on("click", function(){
	var index = $(this).attr("id");
	
	if(index < markers.length){
		infowindows[index].open(map, markers[index]);
		markers[index].setAnimation(google.maps.Animation.BOUNCE);
	}
});
</script>
</body>
</html>
