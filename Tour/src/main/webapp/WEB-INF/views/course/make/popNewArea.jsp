<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	<title>새로운 여행지 추가</title>
	<style>
	.popContainer {
		padding: 30px 30px 10px 30px;
		display: flex;
	}
	.addImage {
		padding:20px;
		height: 320px;
	}
	.info {
		padding: 10px;
		width: 300px;
		height: auto;
		float: right;
	}
	.button {
		float: right;
		margin: 10px;
	}
	#map {
		height: auto;
		width: 70%;
		float: left;
	}
	.fileDrop{
	border: 1px dotted blue;
	margin-left:20px;
	padding:10px;
	height:100%;
	}
	.explain{
	margin:10px;
	}
	.previewImage{
	width:100%;
	height:100%;
	display:none;
	}
	.imageView{
	width:500px;
	height:285px;
	text-align:center;
	margin:auto;
	}
	.imageContent{
	max-width:100%;
	height:auto;
	max-height:100%;
	}
	@keyframes arrow{
	0% {top:0px;}
	100% {top:5px;}
	}
	</style>
</head>
<body>
	<div class="popContainer">
	
		<div id="map"></div>
		<div class="info">
			<form>
				장 소 이 름 : <br><input type="text" id="title"><br><br>
				주 소 :
				<select id="areaCode"><option value='0'> 시 / 도 </option></select>
				<select id="sigunguCode"><option value='0'>시 / 군 / 구</option></select><br><br>
				상 세 주 소 : <br><textarea rows="3" cols="22" id="address"></textarea><br><br>
				전 화 번 호 : <br><input type="text" id="number"><br><br>
			</form>
			<p id="latlng"></p>
		</div>
	</div>
	<div class="addImage">
		<!-- sue~ -->
		<div class="fileDrop">
			<div class="explain">
				<div style="display:inline-block;">사진을 여기에 놓아주세요.</div>
				<span class="glyphicon glyphicon-arrow-down" style="animation:arrow 0.5s linear infinite alternate;"></span>
			</div>
			<div class="previewImage">
				<button type="button" class="btn btn-default btn-xs pull-right" id="removeImageBtn" style="outline:0">
					<i class="fa fa-fw fa-remove"></i></button>
				<div class="imageView" id="imagePreview">
					<img class="imageContent" id="previewImageContent" src="">
				</div>
			</div><!-- /imagePreview -->
		</div><!-- /fileDrop -->
	</div>
	<div class="button">
		<button type=button class="btn btn-default registBtn" data-dismiss="modal" style="height:35px;">등록</button>
		<button type=button class="btn btn-default cancelBtn" data-dismiss="modal" style="height:35px;">취소</button>
	</div>
</body>

<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdkQ3O7ZOpSt2RjwxkSVzgF1NGSHyqkuM&callback=initMap" async defer></script>
<script type="text/javascript">
var map;
var markers = [];
var markerCount = 0;
var lat = "";
var lng = "";

function initMap() {
	var mapcenter = {lat: 36.350527, lng: 128.122559};
	map = new google.maps.Map(document.getElementById('map'), {
	zoom: 7,
	center: mapcenter
	});
		
	//클릭시 map 위치 정보 가져옴
	google.maps.event.addListener(map, 'click', function(event) {
		removeMarker();
		placeMarker(event.latLng);
		showLatLng();
	});
}
   
// 마커 생성 함수
function placeMarker(location) { 
	var clickedLocation = new google.maps.LatLng(location);
	var marker = new google.maps.Marker({
		position: location,
		map: map
	});
	markers[markerCount] = marker;
	markerCount++;
}
	
function removeMarker(location) {
	if(markerCount != 0){
		markers[(markerCount-1)].setMap(null);
	}
}

function showLatLng() {
	lat = markers[(markerCount-1)].getPosition().lat();
	lng = markers[(markerCount-1)].getPosition().lng();
	
	var latlng = "위도 : " + lat + "<br>경도 : " + lng;
	
	document.getElementById('latlng').innerHTML = latlng;
}

// image추가
	$(".fileDrop").on("dragenter dragover", function(event){
		event.preventDefault();
	});
	var file = null;
	$(".fileDrop").on("drop", function(event){
		event.preventDefault();
		
		var imageFileType = ["jpg", "jpeg", "png", "gif"];
		var files = event.originalEvent.dataTransfer.files;
		file = files[0];
		console.log(file);
		console.log(file.size);
		var fileType = file.type.split('/');
		
		var fileTest = false;
		if(fileType[0] == "image"){
			for(var i=0; i<imageFileType.length; i++){
				if(fileType[1].toLowerCase() == imageFileType[i]){
					fileTest = true;
				}
			}
		}
		
		if(fileTest == false){
			alert("JPG/JPEG, PNG, GIF 형식만 가능합니다.");
		}
		else if(file.size > 10485760){
			alert("최대파일크기 : 10MB");
		}
		else{
			$('.explain').hide();
			$('#previewImageContent').attr("src", URL.createObjectURL(file));
			$('.previewImage').show();
			isPreviewImage = true;
		}
		
	});
	
	$('#removeImageBtn').on("click", function(){
		console.log("removeImageBtn 누름");
		$('#previewImageContent').attr("src", '');
		$('.previewImage').hide();
		$('.explain').show();
		file = null;
		isPreviewImage = false;
	});
	
function color(arr){
	var jsonArr = opener.jsonArr;
	var dateJson = opener.dateJson;
	var areacode = Number(document.getElementById('areaCode').value);
	var sigungucode = Number(document.getElementById('sigunguCode').value);
	for(var i=0; i<dateJson.length; i++){
		if((dateJson[i].areaCode == areacode && dateJson[i].sigunguCode == sigungucode) ||
				(dateJson[i].areaCode == areacode && dateJson[i].areaCode == 1) ||
				(dateJson[i].areaCode == areacode && dateJson[i].areaCode == 2) ||
				(dateJson[i].areaCode == areacode && dateJson[i].areaCode == 3) ||
				(dateJson[i].areaCode == areacode && dateJson[i].areaCode == 4) ||
				(dateJson[i].areaCode == areacode && dateJson[i].areaCode == 5) ||
				(dateJson[i].areaCode == areacode && dateJson[i].areaCode == 6) ||
				(dateJson[i].areaCode == areacode && dateJson[i].areaCode == 7) ||
				(dateJson[i].areaCode == areacode && dateJson[i].areaCode == 8)) {
			arr.pinColor = dateJson[i].color;
			arr.titleColor = dateJson[i].textColor;
		}
	}
	/*
	for(var i=0; i<jsonArr.length; i++){
		var last = jsonArr.length-1;
		var areacode = Number(document.getElementById('areaCode').value);
		var sigungucode = Number(document.getElementById('sigunguCode').value);
		if((jsonArr[i].areacode == areacode && jsonArr[i].sigungucode == sigungucode) ||
				(jsonArr[i].areacode == areacode && jsonArr[i].areacode == 1) ||
				(jsonArr[i].areacode == areacode && jsonArr[i].areacode == 2) ||
				(jsonArr[i].areacode == areacode && jsonArr[i].areacode == 3) ||
				(jsonArr[i].areacode == areacode && jsonArr[i].areacode == 4) ||
				(jsonArr[i].areacode == areacode && jsonArr[i].areacode == 5) ||
				(jsonArr[i].areacode == areacode && jsonArr[i].areacode == 6) ||
				(jsonArr[i].areacode == areacode && jsonArr[i].areacode == 7) ||
				(jsonArr[i].areacode == areacode && jsonArr[i].areacode == 8) ){
//			arr.pinColor = jsonArr[i].pinColor;
			arr.pinColor = opener.dateJson[i];
			arr.titleColor = jsonArr[i].titleColor;
		}
	}*/
	return arr;
}
</script>

<script>
var dateJson = JSON.parse('${idList}');
$(document).ready(function(){
	var areaNameStr = "<option value='-1'> 시 / 도 </option>";
	var checkArr = [];
	var check = 1;
	for(var i=0; i<dateJson.length; i++){
		if(checkArr.length != 0){
			for(var j=0; j<checkArr.length; j++){
				if(checkArr[j] == dateJson[i].areaName){
					check = 0;
					break;
				} else
					check = 1;
			}
		}
		if(check == 1){
			areaNameStr += "<option value=" + dateJson[i].areaCode + ">" + dateJson[i].areaName + "</option>";
			checkArr[checkArr.length] = dateJson[i].areaName;
		}
	}
	document.getElementById('areaCode').innerHTML = areaNameStr;
});

$(document).on("click","#areaCode",function(){
	areaSelected = this.value;
	var sigunguNameStr = "<option value='-1'>시 / 군 / 구</option>";
	for(var i=0; i<dateJson.length; i++){
		if(areaSelected == dateJson[i].areaCode){
			sigunguNameStr += "<option value=" + dateJson[i].sigunguCode + ">" + dateJson[i].sigunguName + "</option>";
		}
	}
	document.getElementById('sigunguCode').innerHTML = sigunguNameStr;
});

$(document).on("click",".registBtn",function(){
	// 필수 정보 입력
	if(markers.length == 0){
		alert("지도에 위치를 표시해주세요");
	} else if(document.getElementById('title').value == ""){
		alert("장소이름을 입력해주세요");
	} else if(Number(document.getElementById('areaCode').value) == -1){
		alert("시/도를 선택해주세요.");
	} else if(Number(document.getElementById('sigunguCode').value) == -1){
		alert("시/군/구를 선택해주세요.")
	} else {
		// modify에 list 값 추가
		var arr = new Object();
		arr.addr1 = document.getElementById('address').value;
		arr.addr2 = "";
		arr.areacode = Number(document.getElementById('areaCode').value);
		arr.contentid = Number(0);
		arr.contenttypeid = Number(0);
		arr.createdtime = Number(0);
		if(file != null){
			arr.firstimage = URL.createObjectURL(file);
			arr.firstimage2 = URL.createObjectURL(file);
		}
		else{
			arr.firstimage = null;
			arr.firstimage2 = null;
		}
		arr.modifiedtime = Number(0);
		arr.readcount = Number(0);
		arr.sigungucode = Number(document.getElementById('sigunguCode').value);
		arr.tel = document.getElementById('number').value;
		arr.title = document.getElementById('title').value;
		arr.mapx = String(markers[(markerCount-1)].getPosition().lng());
		arr.mapy = String(markers[(markerCount-1)].getPosition().lat());
		arr = color(arr);
		opener.jsonArr.push(arr);
		// image list에 추가
		if(file != null){
			opener.addImageList.set(opener.jsonArr.length-1, file);
		}
		
		// modify 함수 재 실행
		opener.color();
		opener.initTitle();
		opener.inputTitleBorder();
		opener.initScheduleTable();
		opener.orderRangeSchedule();
		opener.initMap();
		opener.orderPolyLine();
		
		// 창 닫기
		self.close();
	}
});

$(document).on("click",".cancelBtn",function(){
	self.close();
});
</script>

</html>