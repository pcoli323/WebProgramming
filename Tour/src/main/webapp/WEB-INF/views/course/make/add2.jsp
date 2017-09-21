<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>코스 생성중 - 2단계</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<style>
.floating { position: fixed; right: 50%; top: 180px; margin-right: -780px; text-align:center; width: 150px; border:2px solid #4E7AC7;}
</style>
<body>
	<!-- header 1,2 -->
	<div></div>
	<!-- /course/make/add2 -->
	<div class="container" style="padding:10px; border:2px solid #F5F5F5;">
		<!-- 소개 -->
		<div>
			<h1>두 번째 단계 : 여행지 선택 단계입니다.</h1>
			<p>여행지를 선택해주세요.</p>
		</div>	
		<!-- 선택 -->
		<div style="padding:10px; border:2px solid #F5F5F5;">
			<!-- 지역 선택 (탭) -->
			<ul class="nav nav-tabs" id="myTab" role="tablist" style="padding:10px;"></ul>
			<!-- 여행지 선택 (체크박스) -->
			<div class="tab-content" id="checkboxes" style="padding:10px"></div>
		</div>
		<!-- 선택 출력 -->
		<div style="padding:10px;">		
			<!-- 소개 -->
			<div id="sIntro"></div>
			<!-- 출력 -->
			<div id="sList" style="margin-top: 10px;"></div>		
		</div>
		<!-- 다음 단계 이동 -->
		<div style="padding:10px;">
			<button type="button" class="btn btn-default pull-right" id="next">다음</button>
		</div>
	</div>
	<div class="floating"> 선택한 여행지 </div>:
	<!-- footer -->
	<div></div>
</body>
<script>

// 초기 화면 생성 부분
$(document).ready(function(){
	var jsonIDArr = JSON.parse('${idList}');
	
	// 지역 선택 (탭) 추가
	var str ="";
	for(var i=0; i<jsonIDArr.length; i++){
		var json = jsonIDArr[i];
		str += "<li class='nav-item'>" + "<a class='nav-link' data-toggle='tab' href='#" + json.areaCode + "-" + json.sigunguCode + "' role='tab'>" + json.areaName + " " + json.sigunguName + "</a>" + "</li>";
	}
	document.getElementById("myTab").innerHTML = str;
	
	// 여행지 선택 탭칸 추가
	str = "";
	for(var i=0; i<jsonIDArr.length; i++){
		var json = jsonIDArr[i];
		str += "<div class='tab-pane' id='" + json.areaCode + "-" + json.sigunguCode + "' role='tabpanel'></div>";
	}
	document.getElementById("checkboxes").innerHTML = str;
});

// 체크-버튼 이벤트 처리 부분
$(document).on("click",".nav-link",function(){
	var id = this.href.split("#")[1];
	
	// ajax를 사용한 공공 API 호출 및 저장
	var codes = id.split("-");
	var url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?serviceKey=ZMWqGPxD2Y1ds3Sr4PJcz62ZsAzs3Wwu2%2FIWwyGFvbQXC0wCQQHcyaYY%2B6H8LDIVst1GREAN9DNoE2mUHU2%2Ffg%3D%3D&MobileOS=ETC&MobileApp=Tour&arrange=B&areaCode=" + codes[0];
	if(codes[1]!="0")
		url += "&sigunguCode="+codes[1];
	url += "&_type=json";
	
	//console.log(url);
	
	$.ajax({      
        type:"GET",  
        url:url,
        success: function(data) {
        	saveAprint(data,id);
        },
        error:function(request,status,error){
            alert("다시 시도해주세요.\n" + "code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
        }
    });
});

// API 호출 후 화면 생성 부분
function saveAprint(data,id) {
    var jsonItems = data.response.body.items.item;
    var str ="";
	for(var i=0; i<jsonItems.length; i++){
		var json = jsonItems[i];
		if(json.firstimage!=null)
			str += "<div style='margin:10px; padding:5px; border:2px solid #F5F5F5; height:500px; weight=800px;'><img src='" + json.firstimage + "' style='height:485px; weight:auto;float:left;'>";
		else
			str += "<div style='margin:10px; padding:5px; border:2px solid #F5F5F5; height:500px; weight=800px;'><div style='height:485px;width:70%;background-color:#F5F5F5;float:left;'>이미지파일이 없습니다.</div>"
		str += "<div><p>"+json.title+"<br>"+json.addr1+"<br>"+json.addr2+"<br>"+json.tel+"</p>"+"</div></div>";
	}
	document.getElementById(id).innerHTML = str;
}
</script>
</html>