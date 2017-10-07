<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<style type="text/css">
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
	margin: auto;
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
	.popover{
	display:;
	padding:5px;
	text-align:cente;
	}
	.mapView{
	margin:30px;
	height:250px;
	}
	.storyView{
	border:1px solid gold;
	padding:20px;
	line-height:200%;
	}
	.representativeCheck{
	color:LightGray;
	}
	.floating {
	position: fixed;
	right: 60%;
	top: 150px;
	margin-right:-750px;
	text-align:center;
	width: 150px;
	border:2px solid #4E7AC7;
	}
	.representativeListOne{
	border-top:1px solid lightgray;
	padding:5px 10px 5px 10px;
	font-size:10px;
	}
	.addImage{
	color:LightGray;
	}
</style>

<head>
	<meta charset="UTF-8">
	<title>course upload</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<!-- map처리 -->
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
	var markerIndex = 0;
	var gotoNumberMapMarker = new Map();
	function makeMarker(locationX, locationY, image, title, gotoNumber){
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
			
			} else{
				var contentString = "<div style='float:left;'></div><div style='float:right; padding: 10px;'>" + title +"</div>";
			}
			var infowindow = new google.maps.InfoWindow({
									content: contentString,
									size: new google.maps.Size(200,100)});
			infowindows.push(infowindow);
			markerListener(marker, infowindow);
			gotoNumberMapMarker.set(gotoNumber, markerIndex);
			markerIndex++;
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
</head>
<body>

<div class="content">
	<div class="courseView">
	
		<div class="courseView-header" style="text-align:center;padding:20px">
			<input id="courseName" type="text" maxlength="20" value="${courseVO.courseName}" 
					data-toggle="tooltip" data-placement="top" title="200자 내외" style="text-align:center;padding:10px 20px;font-size:24px">
		</div><!-- /courseView-header -->
        
        <div class="courseView-body">
        	<div class="courseMaker" style="text-align:left">
        		<h5>
        			${loginUser.userName}
        		</h5>
        	</div><!-- /courseMaker -->
        	
       		<div class="planTables">
       			<c:set var="gotoID" value="0"></c:set>
        		<c:forEach var="date" items="${plan.keySet()}">
        			<div class="planTable">
        				<table style="background-color:#ffff99">
        					<tr class="dtaeField" >
        						<th style="text-align:center;height:30px;background-color:#ffff80">${date}</th>
        					</tr>
        					<tr class="gotoField">
        						<td>
        							<c:set var="gotoList" value="${plan.get(date)}"></c:set>
        							<c:forEach var="gotoOne" items="${gotoList}">
        								<div style="text-align:left;float:left;">
        									<i class="goto" id="${gotoID}" style="">${gotoOne.gotoName}</i>
        								</div>
        								<div style="text-align:right">
        									<span class="glyphicon glyphicon-check representativeCheck" id="check-${gotoID}-${gotoOne.gotoNumber}" style=""></span>
        									<span class="glyphicon glyphicon-picture addImage" id="picture-${gotoOne.gotoNumber}-${gotoOne.gotoName}" style=""></span>
        									<!-- 
        									<span class="glyphicon glyphicon-picture addImage" id="picture-${gotoOne.gotoNumber}-modify"
        									data-toggle="popover" data-placement="top"></span>
        									 -->
        								</div>
        								<br><br>
        								<c:set var="gotoID" value="${gotoID + 1}"></c:set>
        							</c:forEach>
        						</td>
        					</tr>
        				</table>
        			</div>
        		</c:forEach>
        	</div><!-- /planTable -->
        	<!-- 
        	<div class="popover fade top in" id="imageControl">
        		<div class="imageGotoNumber" style="display:none"></div>
        		<button type="button" class="btn btn-default btn-xs" id="modifyImageBtn">수정</button>
				<button type="button" class="btn btn-default btn-xs" id="deleteImageBtn">삭제</button>
        	</div>
        	 -->
        	<!-- 지도 -->
        	<div class="mapView" id="map">
        			<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdkQ3O7ZOpSt2RjwxkSVzgF1NGSHyqkuM&callback=initMap"></script>
        			<c:forEach var="date" items="${plan.keySet()}">
        				<c:set var="gotoList" value="${plan.get(date)}"></c:set>
        				<c:forEach var="gotoOne" items="${gotoList}">
        					<script>
        						makeMarker("${gotoOne.locationX}", "${gotoOne.locationY}", "${gotoOne.gotoImage}", "${gotoOne.gotoName}", "${gotoOne.gotoNumber}");
        					</script>
        				</c:forEach>
        			</c:forEach>
        	</div>
        	
        	<div class="storyView">
        		<textarea id="story" rows="9" cols="120" maxlength="1000" placeholder="1000자 내외" style="border:0px;resize:none;outline:none"></textarea>
        	</div>
        			
        </div><!-- /courseView-body -->
        		
        <div class="courseView-footer" style="text-align:right; clear:left; margin-top:10px;">
        	<button type="button" class="btn btn-success" id="postCourse" style="outline:0">게시</button>
		</div><!-- /courseView-footer -->
        
	</div><!-- /courseView -->
	<div class="floating" data-toggle="tooltip" data-placement="top" title="다른 사람들에게 가장 먼저 보여주고 싶은 코스를 정해주세요">
		<h5>대표코스</h5>
		<div class="representativeList"></div>
	</div>
</div><!-- /content -->

<script>
	var loginCheck;
	var loginUserNumber;
	
	$(document).ready(function(){
		$('[data-toggle="tooltip"]').tooltip();
		// 변수 초기화
		loginCheck = ${loginCheck};
		if(loginCheck == false){
			loginUserNumber = null;
		}
		else{
			loginUserNumber = ${loginUser.userNumber};
		}
	});
	
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

	// 대표코스 설정
	var representatives = [];
	var representativeIDs = [];
	$('.representativeCheck').on("click", function(){
		var checkCheck = $(this).hasClass("active");
		
		if(checkCheck == 0){
			if(representatives.length == 4){
				alert("대표코스는 최대 6개까지 입니다.")
			}
			else{
				var idStr = $(this).attr('id').split('-');
				var gotoNameID = idStr[1];
				var gotoNumber = idStr[2];
				console.log(gotoNameID + " : " + gotoNumber);
				representativeIDs.push(gotoNameID);
				representatives.push(gotoNumber);
				console.log(representatives);
				$(this).addClass("active");
				$(this).attr("style", "color:#6495ED");
				representativeList();
			}
		}
		else{
			var idStr = $(this).attr('id').split('-');
			var gotoNameID = idStr[1];
			var gotoNumber = idStr[2];
			console.log(gotoNameID + " : " + gotoNumber);
			for(var i=0; i<representatives.length; i++){
				if(representatives[i] == gotoNumber){
					representatives.splice(i, 1);
					representativeIDs.splice(i, 1);
					console.log(representatives);
					console.log(representativeIDs);
					break;
				}
			}
			$(this).removeClass("active");
			$(this).attr("style", "");
			representativeList();
		}
	});
	function representativeList(){
		var str = "";
		for(var i=0; i<representatives.length; i++){
			var id = representativeIDs[i];
			var gotoName = $("#"+id).text();
			console.log(gotoName);
			str += "<div class='representativeListOne'>" + gotoName + "</div>";
		}
		$(".representativeList").html(str);
	}
	
	// image 추가하기
	var gotoNumber;
	var gotoName;
	var isModify;
	var addImageList = new Map();
	$('.addImage').on("click", function(){
		var checkImage = $(this).hasClass("active");
		var idStr = $(this).attr('id').split('-');
		gotoNumber = idStr[1];
		gotoName = idStr[2];
		
		if(checkImage == 0){
			isModify = false;
			var url="/imageUpload";
			window.open(url, "startpop", "width=600, height=400");
		}
		else{
			isModify = true;
			var url="/imageUpload";
			window.open(url, "startpop", "width=600, height=400");
			/*
			$('[data-toggle="popover"]').popover({
				html: true, 
				content: function() {
					return $('#imageControl').html();
				},
				$('.imageGotoNumber').html(gotoNumber);
			});
			var idStr = $(this).attr('id').split('-');
			var gotoNumber = idStr[1];
			
			$('.imageGotoNumber').html(gotoNumber);
			$('#imageControl').popover();
			*/
		}
	});
	
	//게시
	$('#postCourse').on("click", function(){
		var courseNumber = ${courseNumber};
		var courseName = $('#courseName').val();
		var story = $('#story').val();
		if(courseName == ""){
			alert("코스 이름을 만들어주세요");
		}
		else if(representatives.length == 0){
			alert("하나 이상의 대표코스를 정해주세요");
		}
		else{
			// courseName, story (course를 변경) & representatives(courseInfo를 변경) json형태로 coursePostController에서 처리
			// image는 imageController에서 처리
			// success로 끝나면 게시된 거 보여주기
			updateCourse(courseNumber, courseName, story);
			representativeMark();
			addImages();
		}
	});
	function updateCourse(courseNumber, courseName, story){
		$.ajax({
			type: 'POST',
			url: '/mypage/updateCourse',
			headers: {
				"Content-Type": "application/json",
				"X-HTTP-Method-Override": "POST"
			},
			data: JSON.stringify({
				courseNumber:courseNumber,
				courseName:courseName,
				story:story
			}),
			dataType:'text',
			success: function(){
				console.log("courseUpdate");
			}
		});
	}
	function representativeMark(){
		representatives.forEach(function(value, order){
			order = order + 1;
			$.ajax({
				type: 'POST',
				url: '/mypage/representativeMark',
				headers: {
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "POST"
				},
				data: JSON.stringify({
					gotoNumber:value,
					representedOrder:order
				}),
				dataType:'text',
				success: function(){
					console.log("representativeMark");
				}
			})
		});
	}
	function addImages(){
		addImageList.forEach(function(value, key){
			var formData = new FormData();
			formData.append("file", value);
			
			$.ajax({
				url: '/imageUpload/'+loginUserNumber+'/'+key,
				data: formData,
				dataType:'text',
				processData: false,
				contentType: false,
				type: 'POST',
				success: function(){
					console.log("image")
				}
			});
		});
	}
</script>
</body>
</html>