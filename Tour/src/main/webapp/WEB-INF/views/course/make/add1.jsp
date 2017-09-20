<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html lang="en">
<head>
	<title>코스 생성 중 - 단계 1</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<style>
</style>
</head>
<body>
	<!-- header 1,2 추가 부분 -->
	<!-- /course/make/add1 부분 -->
	<div class="container" style="padding:10px; border:2px solid #F5F5F5;">	
		<!-- 지역 선택 부분 -->
		<div>	
			<!-- 지역 선택 단계를 소개해주는 부분 -->
			<div>
				<h1>첫 번째 단계 : 지역 선택 단계입니다.</h1>
				<p>여행하고 싶은 지역을 선택해주세요.</p>
			</div>			
			<!-- 지역과 시군구를 보여주는 부분 -->
			<div style="padding:10px; border:2px solid #F5F5F5;">
				<!-- 지역 선택 부분 (탭) -->
				<ul class="nav nav-tabs" id="myTab" role="tablist" style="padding:10px;">
					<c:forEach var="list" items="${areaList}">
						<li class="nav-item">
    						<a class="nav-link" data-toggle="tab" href="#${list.areaCode}" role="tab">${list.areaName}</a>
  						</li>
					</c:forEach>
				</ul>
				<!-- 시군구 선택 부분 (체크-버튼) -->
				<div class="tab-content" id="checkboxes" style="padding:10px">
					<c:forEach var="list" items="${areaList}">
						<div class="tab-pane" id="${list.areaCode}" role="tabpanel">
							<div class="btn-group" data-toggle="buttons">
								<c:if test="${list.isServicedAll == true}">
									<label class="btn btn-primary">
  										<input id="${list.areaCode}-0-${list.areaName}-전체" type="checkbox" autocomplete="off"> ${list.areaName} 전체
  									</label>
								</c:if>
								<c:forEach var="slist" items="${sigunguList}">
									<c:if test="${list.areaCode == slist.areaCode}">
										<c:if test="${slist.isServiced == true}">
											<label class="btn btn-primary">
  												<input id="${list.areaCode}-${slist.sigunguCode}-${list.areaName}-${slist.sigunguName}" type="checkbox" autocomplete="off"> ${slist.sigunguName}
  											</label>
										</c:if>
									</c:if>
  								</c:forEach>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>		
		</div>
		<!-- 날짜 선택 부분 -->
		<div style="margin-top: 20px;">
			<!-- 날짜 선택 단계를 소개해주는 부분 -->
			<div id="introDateSelect"></div>
			<!-- 날짜 선택 부분을 보여주는 부분 -->
			<div id="selectDateList" style="margin-top: 10px;"></div>	
		</div>
		<!-- 다음 단계 이동 부분 -->
		<div style="margin-top: 10px;">
			<form action="/course/make/add2" id="nextF">
				<button type="button" class="btn btn-default pull-right" id="nextB">다음</button>
				<input type="hidden" id="idList" name="idList">
			</form>
		</div>	
	</div>
	<!-- footer 추가 부분 -->
<script>

var idList = new Array();		// 선택된 id 정보 저장 ("areaCode-sigunguCode-areaName-sigunguName-startDate-endDate" 형식의 String 배열)

// 초기값 로딩 부분(추가 예정)
$( document ).ready(function() {
});

// 체크-버튼 이벤트 처리 부분
$('#checkboxes :checkbox').change(function() {
	
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
	console.log( idList );
	
	// 날짜 선택 추가 부분
	var str2 ="";
	for(var i=0; i<idList.length; i++){
		var strs3 = idList[i].split("-");
		var tagL = "<label>" + strs3[2] + " " + strs3[3] + "</label> ";
    	var tagSI = "여행 시작일 : <input class='datepicker' data-provide='datepicker' id='D" + idList[i] + "S'>"
    	var tagEI = "여행 종료일 : <input class='datepicker' data-provide='datepicker' id='D" + idList[i] + "E'>"
    	str2 += tagL + tagSI + tagEI + "<br>";
    }
	if(idList.length>0) $("#introDateSelect").html("여행지의 날짜를 선택해주세요.");
	else $("#introDateSelect").html("");
	$("#selectDateList").html(str2);
	
});

// 달력 이벤트 처리 부분
$(document).on("focus",".datepicker",function(){ 
	$( ".datepicker" ).datepicker();
} );

// 다음 버튼 처리 이벤트
$("#nextB").click(function(){  
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
			document.getElementById("idList").value=idList;
			document.getElementById('nextF').submit();
		}
	}
}); 

</script>
</body>
</html>