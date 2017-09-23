<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
<body>
	<!-- header 1,2 -->
	<div></div>
	<!-- /course/make/add1 -->
	<div class="container" style="padding:10px; border:2px solid #F5F5F5;">
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
		<!-- 날짜 선택 -->
		<div style="padding:10px;">
			<!-- 소개 -->
			<div id="dsIntro"></div>
			<!-- 선택 -->
			<div id="dsList" style="margin-top: 10px;"></div>		
		</div>	
		<!-- 다음 단계 이동 -->
		<div style="padding:10px;">
			<button type="button" class="btn btn-default pull-right" id="next">다음</button>
		</div>
	</div>		
	<!-- footer -->
	<div></div>
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
		str += "<li class='nav-item'>" + "<a class='nav-link' data-toggle='tab' href='#" + json.areaCode + "' role='tab'>" + json.areaName + "</a>" + "</li>";
	}
	document.getElementById("myTab").innerHTML = str;
	
	// 시군구 선택 (체크-버튼) 추가
	str = "";
	for(var i=0; i<jsonAreaArr.length; i++){
		var json = jsonAreaArr[i];
		str += "<div class='tab-pane' id='" + json.areaCode + "' role='tabpanel'>" + "<div class='btn-group' data-toggle='buttons'>";
		if(String(json.isServicedAll)=="true")
			str += "<label class='btn btn-primary'>" + "<input id='" + json.areaCode + "-0-" + json.areaName + "-전체' type='checkbox' autocomplete='off'>" + json.areaName + " 전체" + "</label>";
		for(var j=0; j<jsonSigunguArr.length; j++){
			var json2 = jsonSigunguArr[j];
			if(String(json.areaCode)==String(json2.areaCode)){
				if(String(json2.isServiced)=="true")
					str += "<label class='btn btn-primary'>" + "<input id='" + json.areaCode + "-" + json2.sigunguCode + "-" + json.areaName + "-" + json2.sigunguName + "' type='checkbox' autocomplete='off'>" + json2.sigunguName + "</label>";		
			}
		}
		str += "</div>" + "</div>";
	}
	document.getElementById("checkboxes").innerHTML = str;
});

// 체크-버튼 이벤트 처리 부분
$(document).on("change","#checkboxes :checkbox",function(){
	
	// 알림, 리스트 저장 및 삭제 부분
	var strs = this.id.split("-");
	if (this.checked) {
		alert(strs[2] + " " + strs[3] + " 이(가) 추가되었습니다.");
		idList.push(this.id);
	}
	else{
		alert(strs[2] + " " + strs[3] + " 이(가) 삭제되었습니다.");
		idList.splice(idList.indexOf(this.id),1);
	}
	
	// 날짜 선택 추가 부분
	var str2 ="";
	for(var i=0; i<idList.length; i++){
		var strs3 = idList[i].split("-");
		var tagL = "<label>" + strs3[2] + " " + strs3[3] + "</label> ";
    	var tagSI = "여행 시작일 : <input class='datepicker' data-provide='datepicker' id='D" + idList[i] + "S'>"
    	var tagEI = "여행 종료일 : <input class='datepicker' data-provide='datepicker' id='D" + idList[i] + "E'>"
    	str2 += tagL + tagSI + tagEI + "<br>";
    }
	if(idList.length>0) $("#dsIntro").html("여행지의 날짜를 선택해주세요.");
	else $("#dsIntro").html("");
	$("#dsList").html(str2);
});

//달력 이벤트 처리 부분
$(document).on("focus",".datepicker",function(){ 
	$(".datepicker").datepicker();
});

//다음 버튼 처리 이벤트
$("#next").click(function(){  
	if(idList.length==0){
		alert("지역을 선택해주세요.");
	}	
	else {
		var stop = false;
		for(var i=0; i<idList.length; i++){
			var sd = $("#D" + idList[i] + "S").datepicker( 'getDate' );
			var ed = $("#D" + idList[i] + "E").datepicker( 'getDate' );
			if(sd==null || ed==null){
				alert("날짜를 선택하지 않은 것이 있습니다.");
				stop = true;
				break;
			}
			else if(sd > ed){
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
</script>
</html>