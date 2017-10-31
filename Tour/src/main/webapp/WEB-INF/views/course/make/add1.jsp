<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
	<title>코스 생성중 - 1단계</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<style>
</style>
<body id="home">
	<!-- header -->
	<%@include file="../../include/navbar.jsp" %>
	<!-- /course/make/add1 -->
	<div class="container" style="padding:10px; border:2px solid #F5F5F5; margin-top:40px;">
		<!-- 지역 선택 -->
		<div>
			<!-- 소개 -->
			<div>
				<h1>첫 번째 단계 : 지역 선택 단계입니다.</h1>
				<p>여행하고 싶은 지역을 선택해주세요.</p>
			</div>			
			<!-- 선택 -->
			<div style="padding:10px; border:2px solid #F5F5F5;">
				<!-- 지역 선택 (탭) -->
				<ul class="nav nav-tabs" id="myTab" role="tablist" style="padding:10px;"></ul>
				<!-- 시군구 선택 (체크-버튼) -->
				<div class="tab-content" id="checkboxes" style="padding:10px"></div>
			</div>		
		</div>	
		
		<!-- 지도 및 날짜 선택 -->
		<div class="container-fluid" style="padding:10px;">
			<!-- 구글맵 -->
			<div class="col-sm-6" id="map" style="height:500px;width:50%;"></div>
		
			<!-- 날짜 선택 -->
			<div class="col-sm-6" style="padding:10px;">
				<!-- 소개 -->
				<div id="dsIntro"></div>
				<!-- 선택 -->
				<div id="dsList" style="margin-top: 10px;"></div>		
			</div>
		</div>
			
		<!-- 다음 단계 이동 -->
		<div style="padding:10px; float:right">
			<button type="button" class="btn btn-default puul-left" id="cancel">취소</button>
			<button type="button" class="btn btn-default pull-right" id="next">다음</button>
		</div>
	</div>		
	<!-- footer -->
	<%@include file="../../include/footer.jsp" %>
</body>

<script>
var idList = new Array();		// 선택된 id 정보 저장 ("areaCode-sigunguCode-areaName-sigunguName-startDate-endDate" 형식의 String 배열)

// 초기 화면 생성 부분
$(document).ready(function(){
	var jsonAreaArr = JSON.parse('${areaList}');
	var jsonSigunguArr = JSON.parse('${sigunguList}');
	
	// 지역 선택 (탭) 추가
	var str ="";
	for(var i=0; i<jsonAreaArr.length; i++){
		var json = jsonAreaArr[i];
		str += "<li class='nav-item'>" + "<a class='nav-link' data-toggle='tab' style='color:#3f2018;' href='#" + json.areaCode + "' role='tab'>" + json.areaName + "</a>" + "</li>";
	}
	document.getElementById("myTab").innerHTML = str;
	
	// 시군구 선택 (체크-버튼) 추가
	str = "";
	for(var i=0; i<jsonAreaArr.length; i++){
		var json = jsonAreaArr[i];
		str += "<div class='tab-pane' id='" + json.areaCode + "' role='tabpanel'>" + "<div class='btn-group' data-toggle='buttons'>";
		if(String(json.isServicedAll)=="true")
			str += "<label class='btn' style='background-color:#3f2018;'>" + "<input id='" + json.areaCode + "-0-" + json.areaName + "-전체' type='checkbox' autocomplete='off'>" + "<font color='#ffffff'>" + json.areaName + " 전체" + "</font></label>";
		for(var j=0; j<jsonSigunguArr.length; j++){
			var json2 = jsonSigunguArr[j];
			if(String(json.areaCode)==String(json2.areaCode)){
				if(String(json2.isServiced)=="true")
					str += "<label class='btn' style='background-color:#3f2018;'>" + "<input id='" + json.areaCode + "-" + json2.sigunguCode + "-" + json.areaName + "-" + json2.sigunguName + "' type='checkbox' autocomplete='off'>" + "<font color='#ffffff'>" + json2.sigunguName + "</font></label>";		
			}
		}
		str += "</div>" + "</div>";
	}
	document.getElementById("checkboxes").innerHTML = str;
	
	
	// 초기 데이터 설정 (for 수정용)
	var jsona = JSON.parse('${idList}');
	for(var i=0; i<jsona.length; i++){
		var json = jsona[i];
		var str = json.areaCode + "-" + json.sigunguCode + "-" + json.areaName + "-" + json.sigunguName;
		idList.push(str);
		printDay(str.split("-"),str);
		document.getElementById(str).checked = true;
		document.getElementById(str).parentElement.classList.add('active');
		
		var date = new Date(json.startDate);
		var parsedDate = date.getMonth()+1 + "/" + date.getDate() + "/" + date.getFullYear();
		json.startDate = parsedDate;
		date = new Date(json.endDate);
		parsedDate = date.getMonth()+1 + "/" + date.getDate() + "/" + date.getFullYear();
		json.endDate = parsedDate;
			
		document.getElementById("D"+str+"S").value=json.startDate;
		document.getElementById("D"+str+"E").value=json.endDate;
	}
	
});

// 체크-버튼 이벤트 처리 부분
$(document).on("change","#checkboxes :checkbox",function(){
	
	// 알림, 리스트 저장 및 삭제 부분
	var strs = this.id.split("-");
	if (this.checked) {
		alert(strs[2] + " " + strs[3] + " 이(가) 추가되었습니다.");
		idList.push(this.id);
		printDay(strs,this.id);
	}
	else{
		alert(strs[2] + " " + strs[3] + " 이(가) 삭제되었습니다.");
		idList.splice(idList.indexOf(this.id),1);
		
		if(idList.length<=0) $("#dsIntro").html("");
		document.getElementById('dsList').removeChild(document.getElementById("D"+strs[2]+strs[3]));
	}
});

// 화면에 컴포넌트를 추가하는 부분
function printDay(strs,id){
	if(idList.length>0) $("#dsIntro").html("여행지의 날짜를 선택해주세요.");
	var str2 ="";
	var tagL = "<label>" + strs[2] + " " + strs[3] + "</label> ";
	var tagSI = "시작일 : <input class='datepicker' data-provide='datepicker' style='width:150px;' id='D" + id + "S'>"
	var tagEI = "종료일 : <input class='datepicker' data-provide='datepicker' style='width:150px;' id='D" + id + "E'>"
	str2 += tagL + tagSI + tagEI;
	str2 += "<button type='button' class='close' aria-label='Close' id='D_"+id+"'><span aria-hidden='true'>&times;</span></button>";
	var newD = document.createElement("div");
	newD.setAttribute("id","D"+strs[2]+strs[3]);
	newD.setAttribute("style","float:left");
	newD.innerHTML=str2;
	document.getElementById('dsList').appendChild(newD);
}

// 여행지 삭제 이벤트 처리
$(document).on("click","#dsList :button",function(){
	for(var i=0; i<idList.length; i++){
		if(this.id.split("_")[1]==idList[i]){
			alert("여행지를 삭제했습니다.");
			idList.splice(i,1);
			document.getElementById(this.id.split("_")[1]).checked = false;
			document.getElementById(this.id.split("_")[1]).parentElement.classList.remove('active');
			document.getElementById('dsList').removeChild(document.getElementById("D"+this.id.split("_")[1].split("-")[2]+this.id.split("_")[1].split("-")[3]));
			break;
		}
	}
});

// 달력 이벤트 처리 부분
$(document).on("focus",".datepicker",function(){ 
	$(".datepicker").datepicker();
});

// 다음 버튼 처리 이벤트
$("#next").click(function(){  
	if(idList.length==0){
		alert("지역을 선택해주세요.");
	}	
	else {
		var stop = false;
		for(var i=0; i<idList.length; i++){
			//var sd = $("#D" + idList[i] + "S").datepicker( 'getDate' );
			//var ed = $("#D" + idList[i] + "E").datepicker( 'getDate' );
			var sdate = document.getElementById("D"+idList[i]+"S").value.split("/");
			var sd = new Date(sdate[2],sdate[0],sdate[1]);	
			var edate = document.getElementById("D"+idList[i]+"E").value.split("/");
			var ed = new Date(edate[2],edate[0],edate[1]);
			if(sdate=="" || edate==""){
				alert("날짜를 선택하지 않은 것이 있습니다.");
				stop = true;
				break;
			}
			else if(sd.getTime() > ed.getTime()){
				alert("시작날짜와 끝날짜를 확인해주세요.");
				stop = true;
				break;
			}
		}
		
		if(stop==false){
			for(var i=0; i<idList.length; i++)
				idList[i] += "-" + document.getElementById("D" + idList[i] + "S").value + "-" + document.getElementById("D" + idList[i] + "E").value;
			
			var jsonIdArr = new Array();
			for(var i=0; i<idList.length; i++){
				var data = new Object();
				for(var j=0; j<idList[i].length; j++){
					var strs = idList[i].split("-");
					data.areaCode = strs[0];
					data.sigunguCode = strs[1];
					data.areaName = strs[2];
					data.sigunguName = strs[3];
					data.startDate = strs[4];
					data.endDate = strs[5];
				}
				jsonIdArr.push(data);
			}
			var jsonData = JSON.stringify(jsonIdArr);
			
			 $.ajax({      
        		type:"POST",  
        		url:"/course/make/add1/save",
        		dataType:"json",
        		data:jsonData,
        		contentType:"application/json; charset=utf-8",
        		success:function(){
        			location.href="/course/make/add2";
    			},
			 	error:function(){
     				location.href="/course/make/add2";
 				}
  		  	});
			
		}
	}
});


// 취소 버튼 이벤트 처리
$("#cancel").click(function(){
	$.ajax({      
     type:"GET",  
     url:"/course/make/cancel",
     success:function(){
     	location.href="/";
 	},
		 error:function(){
  		location.href="/";
		}
	});
});
</script>

<script>
	// 구글맵 생성
  	var map;
   	var markers = [];
   	function initMap() {
      	var mapcenter = {lat: 36.350527, lng: 128.122559};
      	map = new google.maps.Map(document.getElementById('map'), {
        	zoom: 7,
        	center: mapcenter
      	});
   	}
</script>
<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdkQ3O7ZOpSt2RjwxkSVzgF1NGSHyqkuM&callback=initMap" async defer></script>

</html>