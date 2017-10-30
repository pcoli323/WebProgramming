<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<style type="text/css">
	@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);
	@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);
	html, body{overflow-x:hidden;}
	
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
	
	.content{
	width:65%;
	margin:0% 15% 0% 12%;
	display:flex;
	}
	.representativeView{
	display:inline-block;
	width:150px;
	padding-top:250px;
	padding-bottom:400px;
	margin-right:10px;
	}
	.representativeContent{
	width: 150px;
	border:2px solid #4E7AC7;
	text-align:center;
	position:relative;
	}
	.representativeListOne{
	border-top:1px solid lightgray;
	padding:5px 10px 5px 10px;
	font-size:10px;
	}
	.courseView{
	display:inline-block;
	width:100%;
	padding-bottom:50px;
	}
	.planTables{
	background-color:#F2F2F2;
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
	font-family:'Nanum Pen Script';
	font-size:250%;
	}
	.infoContent{
	padding-left:30px;
	display:inline-block;
	width:60%;
	}
	.mapView{
	height:350px;
	width:100%;
	}
	.mapContent{
	height:90%;
	width:100%;
	}
	.infoView{
	height:350px;
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
	padding:5px 10px;
	}
	.storyView{
	border:1px solid gold;
	padding:20px;
	line-height:200%;
	}
	.representativeCheck{
	color:LightGray;
	font-size:150%;
	top:25% !important;
	}
	.addImage{
	color:LightGray;
	font-size:150%;
	top:25% !important;
	}
</style>

<head>
	<meta charset="UTF-8">
	<title>course upload</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js">
<!-- map처리 -->
<script>
</script>
<script>
	var map;
	function initMap() {
		var mapcenter = {lat: 37.3422186, lng: 127.92016209999997};
		map = new google.maps.Map(document.getElementById('map'), {
			zoom: 6,
			center: mapcenter
		});
	}
	var markers = [];
	var markerIndex = 0;
	var gotoNumberMapMarker = new Map();
	var pathArray = [];
	var pathArrayIndex = 0;
	
	function pinSymbol(color) {
		return {
			path: google.maps.SymbolPath.CIRCLE,
			fillColor: color,
			fillOpacity: 1,
			strokeColor: color,
			strokeWeight: 2,
			scale: 4,
		};
	}
	function makePath(){
		var flightPath = new google.maps.Polyline({
			path: pathArray,
			geodesic: true,
			strokeColor: '#FF0000',
			strokeOpacity: 1.0,
			strokeWeight: 2
		});
		flightPath.setMap(map);
		
		pathArray = [];
		pathArrayIndex = 0;
	}
	function makeMarker(locationX, locationY, image, title, address, tel, id, color){
		if(locationX != ""){
			var mapPositions = new google.maps.LatLng(locationY, locationX);
			pathArray[pathArrayIndex++] = mapPositions; // map에서 경로 연결
			var marker = new google.maps.Marker({
				position: mapPositions,
				map: map,
				title:title,
				animation:null,
				icon:pinSymbol(color)
			});
			markers.push(marker);
			if(image != ""){
				var contentString = "<div style='float:left;'><img style='width:150px; height:100px;' src=" + image 
										+ "></div><div style='float:right; padding: 10px;'>" + title +"</div>";
				
			} else{
				var contentString = "<div style='float:left;'></div><div style='float:right; padding: 10px;'>" + title +"</div>";
			}
			markerListener(marker, id);
			gotoNumberMapMarker.set(id, markerIndex);
			markerIndex++;
		}
	}
	function markerListener(localmarker, id){
		google.maps.event.addListener(localmarker, 'click', function() {
			showInfo(id);
		});
	}
</script>
<script>
	//planTable의 글자크기 자동조절
	var representatives = [];
	var representativeIDs = [];
	var images = [];
	var infos = new Map();
	function fitFontSize(id, length){
		var size = length - 13;
		fontSize = 250 - size*10;
		var str = $('#'+id).attr("style");
		str += ";font-size:"+fontSize+"%";
		$('#'+id).attr("style", str);
	}
</script>
</head>

<%@include file="../include/navbar.jsp" %>
<body>
<div class="content">
	<div class="representativeView">
		<div class="representativeContent"  data-toggle="tooltip" data-placement="top" title="다른 사람들에게 가장 먼저 보여주고 싶은 코스를 정해주세요">
			<h5>대표코스</h5>
			<div class="representativeList"></div>
		</div><!-- /representativeContent -->
	</div><!-- /representativeView -->
	
	<div class="courseView">
	
		<div class="courseView-header" style="text-align:center;padding:20px">
			<input id="courseName" type="text" maxlength="20" value="${courseVO.courseName}" 
					data-toggle="tooltip" data-placement="bottom" title="200자 내외" style="text-align:center;padding:10px 20px;font-size:24px;font-family:'Jeju Gothic';">
		</div><!-- /courseView-header -->
        
        <div class="courseView-body">
        	<div class="courseMaker" style="text-align:left;font-family:'Jeju Gothic';">
        		<h4>
        			${loginUser.userName}
        		</h4>
        	</div><!-- /courseMaker -->
        	
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
        						<td>
        							<c:set var="gotoList" value="${plan.get(date)}"></c:set>
        							<c:forEach var="gotoOne" items="${gotoList}">
        								<div style="display:flex;margin:10px 0px 10px 0px;">
        								<div style="text-align:left;width:80%;display:inline-block;">
        									<span class="goto" id="${gotoID}" style="color:${gotoOne.color}">${gotoOne.gotoName}</span>
        								</div>
        								<script>
        									var length = ${gotoOne.gotoName.length()};
        									var id = ${gotoID};
        									if(length>13){
        										fitFontSize(id, length);
        									}
        									var image = "${gotoOne.gotoImage}";
        									images.push(image);
        									var info = [];
        									info.push("${gotoOne.gotoName}");
        									info.push("${gotoOne.address}");
        									info.push("${gotoOne.tel}");
        									infos.set(id, info);
        								</script>
        								<div style="text-align:right;width:20%;display:inline-block;">
        									<c:choose>
        										<c:when test="${gotoOne.isRepresented eq true}">
        											<span class="representativeCheck glyphicon glyphicon-check active" id="check-${gotoID}-${gotoOne.gotoNumber}" style="cursor:pointer;color:#6495ED"></span>
        											<script>
        												var order = ${gotoOne.representedOrder};
        												var gotoNumber = ${gotoOne.gotoNumber};
        												representatives[order-1] = gotoNumber.toString();
        												representativeIDs[order-1] = ${gotoID};
        											</script>
        										</c:when>
        										<c:otherwise>
        											<span class="representativeCheck glyphicon glyphicon-check" id="check-${gotoID}-${gotoOne.gotoNumber}" style="cursor:pointer;"></span>
        										</c:otherwise>
        									</c:choose>
        									<span class="glyphicon glyphicon-picture addImage" id="picture-${gotoID}-${gotoOne.gotoNumber}-${gotoOne.gotoName}" style="cursor:pointer;"></span>
        								</div>
        								</div>
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
        							makeMarker("${gotoOne.locationX}", "${gotoOne.locationY}", "${gotoOne.gotoImage}", "${gotoOne.gotoName}", "${gotoOne.address}", "${gotoOne.tel}", "${gotoID}", "${gotoOne.color}");
        						</script>
        						<c:set var="gotoID" value="${gotoID + 1}"></c:set>
        					</c:forEach>
        					<script>
        						makePath();
        					</script>
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
        	
        	<div class="storyView">
        		<textarea id="story" rows="9" cols="120" maxlength="1000" data-toggle="tooltip" data-placement="top" title="1000자 내외" style="border:0px;resize:none;outline:none">${courseVO.story}</textarea>
        	</div>
        			
        </div><!-- /courseView-body -->
        		
        <div class="courseView-footer" style="text-align:right; clear:left; margin-top:10px;">
        	<button type="button" class="btn btn-danger" id="cancel" style="outline:0">취소</button>
        	<button type="button" class="btn btn-success" id="postCourse" style="outline:0">게시</button>
		</div><!-- /courseView-footer -->
        
	</div><!-- /courseView -->
</div><!-- /content -->

<script>
	var loginCheck;
	var loginUserNumber;
	var changeImages = [];
	
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
		
		representativeList();
		
		for(var i=0; i<images.length; i++){
			changeImages[i] = -1;
		}
	});
	
	// info가 scroll 따라 다니도록
	$(window).scroll(function(){
		var position = $(window).scrollTop();
		var maxPosition = $(".infoContent").height() - $(".move").height() + 150;
		var representativeMaxPosition = $(".infoContent").height() - $(".representativeContent").height() - 250;
		if(position <= 100){
			position = 0;
			$(".move").stop().animate({"top":position+"px"},1000);
			$(".representativeContent").stop().animate({"top":position+"px"},1000);
		}
		else if(position > 150 && position < maxPosition){
			movePosition = position-150;
			$(".move").stop().animate({"top":movePosition+"px"},1000);
			if(position < representativeMaxPosition){
				$(".representativeContent").stop().animate({"top":position+"px"},1000);
			}
		}
		else if(position < representativeMaxPosition){
			$(".representativeContent").stop().animate({"top":position+"px"},1000);
		}
	});
	
	// goto 마우스로 over되면 색 변하도록
	$('.goto').mouseover(function(){
		var id = $(this).attr("id");
		var str = $(this).attr("style");
		
		str = str + ";background-color:#d9ff66;cursor:pointer;";
		$(this).attr("style", str);
	});
	$('.goto').mouseout(function(){
		var id = $(this).attr("id");
		var str = $(this).attr("style").split(';');
		
		if(str.length > 4){
			$(this).attr("style", str[0]+';'+str[1]);
		}
		else{
			$(this).attr("style", str[0]);
		}
	});
	
	// goto 누르면 지도에 해당하는 marker에 대해 작동하도록
	$('.goto').on("click", function(){
		var id = $(this).attr("id");
		
		showMap(id);
		showInfo(id);
	});
	
	// map의 정보 보여주기
	function showMap(id){
		if(gotoNumberMapMarker.has(id) == true){
			var index = gotoNumberMapMarker.get(id);
			map.setCenter(markers[index].getPosition());
			map.setZoom(10);
			$('.mapInfo').hide();
		}
		else{
			$('.mapInfo').show();
		}
	}
	// info 보여주기
	function showInfo(id){
		var image;
		var str;
		
		// image가 바뀌었는지 여부
		if(changeImages[id] == -1){
			image = images[id];
		}
		else{
			var gotoNumber = changeImages[id];
			image = URL.createObjectURL(addImageList.get(gotoNumber));
		}
		
		// image가 있는지 여부에 따라 다른 이미지 놓기
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
	
	// 대표코스 설정
	$('.representativeCheck').on("click", function(){
		var checkCheck = $(this).hasClass("active");
		var idStr = $(this).attr('id').split('-');
		var gotoID = idStr[1];
		var gotoNumber = idStr[2];
		
		if(checkCheck == 0){
			if(representatives.length == 6){
				alert("대표코스는 최대 6개까지 입니다.")
			}
			else{
				representativeIDs.push(gotoID);
				representatives.push(gotoNumber);
				$(this).addClass("active");
				
				var styleStr = $(this).attr("style");
				styleStr += ";color:#6495ED";
				$(this).attr("style", styleStr);
				representativeList();
			}
		}
		else{
			for(var i=0; i<representatives.length; i++){
				if(representatives[i] == gotoNumber){
					representatives.splice(i, 1);
					representativeIDs.splice(i, 1);
					break;
				}
			}
			$(this).removeClass("active");
			
			var styleStr = $(this).attr("style").split(";");
			$(this).attr("style", styleStr[0]);
			representativeList();
		}
	});
	function representativeList(){
		var str = "";
		for(var i=0; i<representatives.length; i++){
			var id = representativeIDs[i];
			var gotoName = $("#"+id).text();
			str += "<div class='representativeListOne'>" + gotoName + "</div>";
		}
		$(".representativeList").html(str);
	}
	
	// image 추가하기
	var gotoID;
	var gotoNumber;
	var gotoName;
	var isModify;
	var addImageList = new Map();
	$('.addImage').on("click", function(){
		var checkImage = $(this).hasClass("active");
		var idStr = $(this).attr('id').split('-');
		gotoID = idStr[1];
		gotoNumber = idStr[2];
		gotoName = idStr[3];
		
		if(checkImage == 0){
			isModify = false;
		}
		else{
			isModify = true;
		}
		var url="/imageUpload";
		window.open(url, "startpop", "width=1160, height=512");
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
			// success로 끝나면 게시된 거 보여주기
			updateCourse(courseNumber, courseName, story);
			representativeMark(courseNumber);
			addImages();
			location.href = "/uploadMypage";
		}
	});
	function updateCourse(courseNumber, courseName, story){
		if(story == ""){
			story = null;
		}
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
	function representativeMark(courseNumber){
		$.ajax({
			type: 'POST',
			url: '/mypage/representativeMark',
			headers: {
				"Content-Type": "application/json",
				"X-HTTP-Method-Override": "POST"
			},
			data: JSON.stringify({
				courseNumber:courseNumber,
				representatives:representatives
			}),
			dataType:'text',
			success: function(){
				console.log("representativeMark");
			}
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
	
	// 게시 취소
	$('#cancel').on("click", function(){
		var courseNumber = ${courseNumber};
		location.href = "/mypage/"+courseNumber;
	})
</script>
<%@include file="../include/footer.jsp" %>
</body>
</html>