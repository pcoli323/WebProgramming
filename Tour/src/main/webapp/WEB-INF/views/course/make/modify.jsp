<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
  <style>
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {height: 450px}
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {
    	padding-top: 30px;
    	height: 780px;
    }
    
    /* Set gray background color and 100% height */
    .sidenav {
      padding-top: 20px;
      background-color: #f1f1f1;
      height: 375px;
      width: 27%;
      float: right;
      overflow:auto;
      padding-right:3%;
      padding-left:3%;
    }
    
    .schedule {
      padding-top: 10px;
      margin-top: 20px;
      background-color: #f1f1f1;
      height: 375px;
      width: 27%;
      float: right;
      overflow:auto;
    }
    
    #scheduleDate {
      padding-top: 10px;
    }

    .text-center {
        padding-right:15%;
        padding-left:15%;
    }
    
    /* On small screens, set height to 'auto' for sidenav and grid */
   /* @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height:auto;} 
    }*/
    #map {
      height: 770px;
      width: 70%;
      float: left;
    }
    
    .gotoList {
    	padding-top: 30px;
    }
    input {
    	border: none;
    	padding-left: 2px;
    }
    button {
    	height: 1.7em;
    	border: none;
    }
    .gotoTitle { 
    	margin-bottom: 25px;
    }
    #modDiv {
    	width:300px;
    	height:100px;
    	background-color:lightgray;
    	position: absolute;
    	top: 50%;
    	left: 50%;
    	margin-top: -50px;
    	margin-left: -150px;
    	padding: 10px;
    	z-index: 1000;
    }
    table td {
    	padding-left: 20px;
    }
    
    .scheduleSize {
    	width:330px;
    	height:40px;
		margin:auto;
    }
    .scheduleSize th {
    	text-align:center;
    	background-color:#c8dbdd;
    	font-size:15px;
    }
    .updown {
    	font-size:7px;
    	margin:0;
    	padding:0;
    	width:20px;
    	height:12px;
    }
    #complete {
    	padding-top:30px;
    	align:right;
    	height:50px;
    	float:right;
    }
  </style>
</head>
<body>

<script>
var jsonArr = JSON.parse('${list}');
var dateJson = JSON.parse('${idList}');
var realDate = [];
var realDateCount = 0;
</script>

<div class="container" style="padding:10px; border:2px solid #F5F5F5;">
	<!-- 소개 -->
	<div>
		<h1>세 번째 단계 : 일정 선택 단계입니다.</h1>
		<p>여행 일정을 선택하여 주세요.</p>
	</div>
	<!-- <div class="row content text-center"> -->
	<div id="map"></div>
	<script>
	var map;
	var markers = [];
	function initMap() {
		var mapcenter = {lat: 36.350527, lng: 128.122559};
		map = new google.maps.Map(document.getElementById('map'), {
			zoom: 7,
			center: mapcenter
		});
			markerPosition();
	}
	function markerPosition(){
		for(var i=0; i<jsonArr.length; i++){
			var mapPositions = new google.maps.LatLng(Number(jsonArr[i].mapy), Number(jsonArr[i].mapx));
			var marker = new google.maps.Marker({
				position: mapPositions,
				map: map,
				title: jsonArr[i].title,
			});
			markers[i] = marker;
			var address = jsonArr[i].address;
			if(address == null)
				address = "";
			var tel = jsonArr[i].tel;
			if(tel == null)
				tel = "";
				
			//contentString[i] = document.getElementById("title[" + i + "]").value;
			if(jsonArr[i].firstimage2 != null){
				var contentString = "<div style='float:left;'><img style='width:150px; height:100px;' src=" + jsonArr[i].firstimage2 + "></div><div style='float:right; padding: 10px;'>" + jsonArr[i].title + "<br>" + address + "<br>" + tel + "</div>";
			} else if(jsonArr[i].firstimage != null){
					var contentString = "<div style='float:left;'><img style='width:150px; height:100px;' src=" + jsonArr[i].firstimage + "></div><div style='float:right; padding: 10px;'>"+ jsonArr[i].title + "<br>" + address + "<br>" + tel + "</div>";
			} else
				var contentString = "<div style='float:left;'></div><div style='float:right; padding: 10px;'>"+ jsonArr[i].title + "<br>" + address + "<br>" + tel + "</div>";
			var infowindow = new google.maps.InfoWindow({
				content: contentString,
				size: new google.maps.Size(200,100)
			}); 
		markerListener(marker, infowindow);
		}
	}
	function clearMarkers(i) {
		markers[i].setMap(null);
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
	<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdkQ3O7ZOpSt2RjwxkSVzgF1NGSHyqkuM&callback=initMap"
 	  async defer></script>
		<form name="inputForm">
		<div class="sidenav">
			<div class="gotoTitle">
				<h3>가고 싶은 곳</h3>
			</div>
			<table class = "gotoList" id="gotoList">
			
			</table>
	</div>
	</form>
	<script>
	initTitle();
	
	// 가고 싶은 곳 title 출력 문
	function initTitle(){
		var str = "";
		for(var i=0; i<jsonArr.length; i++){
			var str1 = "<tr style='height:20px;'><td><input id='title['" + i + "']' value='" + jsonArr[i].title + "' style='height:23px; width:175px' border=none readonly ></td>";
			var str2 = "<td><button type='button' class='calBtn' value=" + i + "><span class='glyphicon glyphicon-calendar'></span></button></td>";
			var str3 = "<td><button type='button' class='delBtn' value=" + i + "><span class='glyphicon glyphicon-remove'></span></button></td></tr>";
			var str4 = "<td style='height:20px;'></td></tr>";
			str += str1 + str2 + str3 + str4;
		}
		document.getElementById("gotoList").innerHTML = str;
	}
	</script>

	<!-- Delete Modal -->
	<div class="modal fade" id="delModal" role="dialog">
		<div class="modal-dialog" style="width:300px;">
   
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header" style="height:50px;">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">확인창</h4>
				</div>
				<div class="modal-body" style="height:45px;">
					<p>정말 삭제하시겠습니까?</p>
				</div>
				<div class="modal-footer" style="height:60px;">
					<button type=button class="btn btn-default" data-dismiss="modal" onClick="deleteLine()" style="height:35px;">네</button>
					<button type="button" class="btn btn-default" data-dismiss="modal" style="height:35px;">아니오</button>
				</div>
			</div>
     
		</div>
	</div>
	<script>
	// 삭제 버튼 클릭시 삭제 모달창
	var delBtnValue;
	$(document).on("focus",".delBtn",function(){ 
    	delBtnValue = this.value;
        $("#delModal").modal();
	});
		// 가고 싶은 곳 title 삭제 처리
	function deleteLine() {
		var Status = delBtnValue;
        clearMarkers(Status);
        jsonArr.splice(Status,1);
        markerPosition();
        initTitle();
        initScheduleTable();
        initSchedule();
    }
	</script>

	<!-- 일청 div -->
	<form>
		<div class="schedule">
			<h3>일정</h3>
			<div id="scheduleDate">
				
			</div>
		</div>
	</form>
	<script>
	// api데이터를 date로 변환
	function DateInvert(pdate){
		var date = pdate;
		var splitDate = date.split('/');
		var dateObj = new Date(Number(splitDate[2]), Number(splitDate[0])-1, Number(splitDate[1]));
		
		return dateObj;
	}
	// String 값을 date로 변환
	function StringDateInvert(pdate){
		var date = pdate;
		var splitDate = date.split('/');
		var dateObj = new Date(Number(splitDate[0]), Number(splitDate[1])-1, Number(splitDate[2]));
		
		return dateObj;
	}
	
	// 시작 날짜와 끝 날짜 계산(아예 완전히!!!!)
	var scheduleStrDate = dateJson[0].startDate;
	var splitScheduleStrDate = scheduleStrDate.split('/');
		
	var scheduleStrDateObj = new Date(Number(splitScheduleStrDate[2]), Number(splitScheduleStrDate[0])-1, Number(splitScheduleStrDate[1]));
	var scheduleEndDateObj = DateInvert(dateJson[(dateJson.length-1)].endDate);
		
	var scheduleBetweenDay =((scheduleEndDateObj.getTime() - scheduleStrDateObj.getTime())/1000/60/60/24)+1;
	var str = [];
	
	for(var i=0; i<scheduleBetweenDay; i++){
		var dateObj = new Date(Number(splitScheduleStrDate[2]), Number(splitScheduleStrDate[0])-1, Number(splitScheduleStrDate[1]));
		dateObj.setDate(dateObj.getDate()+i);
		str[i] = dateObj.getFullYear() + "/" + (dateObj.getMonth()+1) + "/" + dateObj.getDate();
	}
	
	// 일정 부분 날짜 출력("2017/09/26")
	initScheduleTable();
	function initScheduleTable(){
		var scheduleDateTable = "";
		for(var i=0; i<dateJson.length; i++){
			var start = DateInvert(dateJson[i].startDate);
			var end = DateInvert(dateJson[i].endDate);
			for(var j=0; j<scheduleBetweenDay; j++){
				var date = StringDateInvert(str[j]);
				if(start <= date){
					scheduleDateTable += "<div style='height:20px;'><p style='font-size:18px; background-color:pink; font-weight: bold;'>" + str[j] + "</p></div><div style='height:16em; padding-top:10px; padding-right:8%; padding-left:8%;'><table style='width:100%;' id=" + str[j] + "></table></div>";
					realDate[realDateCount] = str[j];
					realDateCount++;
					if(date >= end){
						break;
					}
				}
			}
		}
		document.getElementById("scheduleDate").innerHTML = scheduleDateTable;
	}
	</script>
	
	<!-- Calendar Modal -->
	<div class="modal fade" id="calModal" role="dialog">
		<div class="modal-dialog" style="width:300px;">
   
			<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-body" style="height:45px;">
					<form name="dateForm">
						<select class="selectDate" id="selectDate">
							
						</select>
					</form>
				</div>
				<div class="modal-footer" style="height:60px;">
					<button type=button class="btn btn-default" data-dismiss="modal" onClick="insertDate()" style="height:35px;">확  인</button>
				</div>
			</div>
		</div>
	</div>

	<script>
	// calendar 버튼 클릭 시 날짜 선정 모달 띄움
	var calBtnValue;
	$(document).on("focus",".calBtn",function(){
	    calBtnValue = this.value;
	    $("#calModal").modal();
		for(var i=0; i<dateJson.length;i++){
			if(dateJson[i].areaCode == jsonArr[calBtnValue].areacode){
				var strDate = dateJson[i].startDate;
				var splitStrDate = strDate.split('/');
				
				var endDate = dateJson[i].endDate;
				var splitEndDate = endDate.split('/');
				
				var strDateObj = new Date(Number(splitStrDate[2]), Number(splitStrDate[0])-1, Number(splitStrDate[1]));
				var endDateObj = new Date(Number(splitEndDate[2]), Number(splitEndDate[0])-1, Number(splitEndDate[1]));
				
				var betweenDay =((endDateObj.getTime() - strDateObj.getTime())/1000/60/60/24)+1;
					
				var stringOption = "<option value=''>날짜를 선택하세요</option>";
				for(var optionDate=0; optionDate<betweenDay; optionDate++){
					var dateObj = new Date(Number(splitStrDate[2]), Number(splitStrDate[0])-1, Number(splitStrDate[1]));
					dateObj.setDate(dateObj.getDate()+optionDate);
					var str = dateObj.getFullYear() + "/" + (dateObj.getMonth()+1) + "/" + dateObj.getDate();
					stringOption += "<option class='setDate' value=" + str + ">" + str + "</option>";
				}
				break;
			}
		}
		document.getElementById("selectDate").innerHTML = stringOption;
    });
	var selectDateVar; // 날짜 선정 모달에서 선택한 날짜 value값
	$(document).ready(function(){
	    $(".selectDate").click(function(){
			selectDateVar = this.value;
		}); 
	});
		// calendar modal 창에서 확인 누를 시 동작
	function insertDate(){
		jsonArr[calBtnValue].gotoDate = selectDateVar;
		initSchedule();
	}

	// 일정 부분 td 출력
	var stringGoto = [];
	function initSchedule(){
		for(var j=0; j<scheduleBetweenDay; j++){
			stringGoto[j] = "";
			document.getElementById(str[j]).innerHTML = stringGoto[j];
			for(var i=0; i<jsonArr.length; i++){
				if(str[j] == jsonArr[i].gotoDate){
					var str1 = "<tr style='height:30px;'><td style='text-align:left; width:95%;'>" + jsonArr[i].title + "</td>";
					var str2 = "<td style='text-align:right;'><button type='button' class=" + i + " id =" + i + " onclick='moveUp(this)'><span class='glyphicon glyphicon-menu-up'></span></button>";
					var str3 = "<button type='button' id = " + i + "  onclick='moveDown(this)' class='updown'><span class='glyphicon glyphicon-menu-down'></span></button></td></tr>";
					stringGoto[j] += str1 + str2 + str3;
				} else {
					stringGoto[j] += "";
				}
			}
			if(stringGoto[j])
				document.getElementById(str[j]).innerHTML = stringGoto[j];
		}
	}

	function moveUp(el){
		var $tr = $(el).parent().parent(); // 클릭한 버튼이 속한 tr 요소
		$tr.prev().before($tr); // 현재 tr 의 이전 tr 앞에 선택한 tr 넣기
	}
	function moveDown(el){
		var $tr = $(el).parent().parent(); // 클릭한 버튼이 속한 tr 요소
		$tr.next().after($tr); // 현재 tr 의 다음 tr 뒤에 선택한 tr 넣기
	}
	/*
	function orderTable(){
		for(var j=0; j<scheduleBetweenDay; j++){ //완전한 날짜로 돌림
			var order = 0;
			for(var i=0; i<jsonArr.length; i++){
				if(str[j] == jsonArr[i].gotoDate){ //gotoDate 설정되어있는 날짜만
					var table = document.getElementById(str[j]);
					var rows = table.getElementsByTagName("TR");
					jsonArr[i].order = order;
					order++;
				}
			}
		}
	}
	*/
	function orderTable(){
		for(var i=0; i<realDate.length; i++){
			var table = document.getElementById(realDate[i]);
			var rows = table.getElementsByTagName("TR");
			for(var j=0; j<rows.length; j++){
				var x = rows[j].getElementsByTagName("TD")[0].innerHTML;
				for(var z=0; z<jsonArr.length; z++){
					if(jsonArr[z].title == x)
						jsonArr[z].order = j;
				}
			}
		}
	}
	</script>
	<div id="complete">
		<button type="button" id="completeBtn" class="btn btn-default" style="padding-bottom:2px; height:30px;">완료</button>
	</div>
	<!-- Complete Modal -->
	<div class="modal fade" id="completeModal" role="dialog">
		<div class="modal-dialog" style="width:300px;">
    
    		<!-- Modal content-->
			<div class="modal-content">
				<div class="modal-header" style="height:50px;">
					<button type="button" class="close" data-dismiss="modal">&times;</button>
					<h4 class="modal-title">코스 이름을 설정하세요.</h4>
				</div>
				<div class="modal-body" style="height:45px;">
					<input id="courseName" style="border:black">
				</div>
				<div class="modal-footer" style="height:60px;">
					<button type=button class="btn btn-default" data-dismiss="modal" onClick="completeName()" style="height:35px;">확인</button>
				</div>
			</div>
	    
		</div>
	</div>
	<script>
	// 완료 버튼 클릭시 코스 제목 모달창
	$(document).on("focus","#completeBtn",function(){
		orderTable();
		console.log(jsonArr);
        $("#completeModal").modal();
	});
	
	function completeName(){
		jsonArr.courseName = document.getElementById("courseName").value;
		var jsonData = JSON.stringify(jsonArr);
		$.ajax({      
	    	type:"POST",  
	    	url:"/course/make/modify/save",
	    	dataType:"json",
	    	data:jsonData,
	    	contentType:"application/json; charset=utf-8",
	    	success:function(){
    			alert("코스가 생성되었습니다.");
    			location.href="/mypage";
			},
			error:function(){
    			alert("실패");
			},
		});
	}
	</script>
</div>
</body>
</html>