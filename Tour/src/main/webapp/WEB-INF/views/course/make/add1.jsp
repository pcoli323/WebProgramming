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
				<h1>첫번째 단계 : 지역 선택 단계입니다.</h1>
				<p>여행하고 싶은 지역을 선택해 추가해주세요.</p>
			</div>
			<!-- 지역과 시군구를 보여주는 부분 -->
			<div style="padding:10px; border:2px solid #F5F5F5;">
				<!-- 지역 선택 부분 (탭) -->
				<ul class="nav nav-tabs" id="myTab" role="tablist" style="padding:10px;">
					<li class="nav-item">
    					<a class="nav-link active" data-toggle="tab" href="#${areacodeList[0].areaCode}" role="tab">${areacodeList[0].areaName}</a>
    					<input type="hidden" id="N${areacodeList[0].areaCode}" value="${areacodeList[0].sAreaNum}" name="${areacodeList[0].areaName}">
  					</li>
					<c:forEach var="list" items="${areacodeList}" begin="1">
						<li class="nav-item">
    						<a class="nav-link" data-toggle="tab" href="#${list.areaCode}" role="tab">${list.areaName}</a>
    						<input type="hidden" id="N${list.areaCode}" value="${list.sAreaNum}" name="${list.areaName}">
  						</li>
					</c:forEach>
				</ul>
				<!-- 상세 지역 선택 부분 -->
				<div class="tab-content" id="checkboxes" style="padding:10px">
					<div class="tab-pane active" id="${areacodeList[0].areaCode}" role="tabpanel">
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary" id="B${areacodeList[0].areaCode}-0">
  								<input type="checkbox" autocomplete="off" id="${areacodeList[0].areaCode}-0" name="${areacodeList[0].areaName}"> 전체
  							</label>
  							<c:if test="${areacodeList[0].sAreaNum > 1}">
								<c:forEach var="slist" items="${areacodeList[0].sAreaList}">
  									<label class="btn btn-primary" id="B${areacodeList[0].areaCode}-${slist.sAreaCode}">
  										<input type="checkbox" autocomplete="off" id="${areacodeList[0].areaCode}-${slist.sAreaCode}" name="${slist.sAreaName}"> ${slist.sAreaName}
  									</label>
  								</c:forEach>
  							</c:if>
						</div>
					</div>
					<c:forEach var="list" items="${areacodeList}" begin="1">
						<div class="tab-pane" id="${list.areaCode}" role="tabpanel">
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-primary" id="B${list.areaCode}-0">
  									<input type="checkbox" autocomplete="off" id="${list.areaCode}-0"  name="${list.areaName}"> 전체
  								</label>
  								<c:if test="${list.sAreaNum > 1}">
								<c:forEach var="slist" items="${list.sAreaList}">
  									<label class="btn btn-primary" id="B${list.areaCode}-${slist.sAreaCode}">
  										<input type="checkbox" autocomplete="off" id="${list.areaCode}-${slist.sAreaCode}"  name="${slist.sAreaName}"> ${slist.sAreaName}
  									</label>
  								</c:forEach>
  								</c:if>
							</div>
						</div>
					</c:forEach>
				</div>
			</div>
			<!-- 선택한 지역을 출력해주는 부분 -->
			<div class="well" id="checked" style="padding:10px;">
				<p> 지역을 추가해주세요. </p>
			</div>
		</div>
		<!-- 날짜 선택 부분 -->
		<div id="dayList"></div>
		<!-- 다음 단계 이동 부분 -->
		<div>
			<form action="/course/make/add2" id="nextF">
				<input type="hidden" id="arrCode" name = "arrCode" value="">
  				<input type="hidden" id="arrName" name = "arrName"  value="">
  				<input type="hidden" id="arrSDate" name = "arrSDate"  value="">
  				<input type="hidden" id="arrEDate" name = "arrEDate"  value="">
  				<button type="button" class="btn btn-default" id="nextB">다음</button>
			</form>
		</div>
	</div>
	<!-- footer 추가 부분 -->
<script>
$('#myTab a').click(function (e) {
	e.preventDefault()
	$(this).tab('show')
})
	
var checked = new Array();
var checkedN = new Array();
var regions = new Array();
$('#checkboxes :checkbox').change(function() { 
    if (this.checked) {
    	alert("추가되었습니다.");
    	if(this.id.charAt(this.id.indexOf("-")+1)=='0'){
    		var strs = this.id.split("-");
    		var areacode = parseFloat(strs[0]);
    		var id = "N"+areacode;
    		var leng = document.getElementById(id).value;
    		if(leng==1){
    			var id2 = areacode+"-"+0;
    			checked.push(id2);
    			checkedN.push(document.getElementById(id2).name);
    		}
    		else{
    			var pos = 1;
    			for(var i=1; pos<=leng; i++){
    				var id2 = areacode + "-" + i;
    				var bid = "B" + areacode + "-" + i;
    				if(document.getElementById(id2)){
    					if(!document.getElementById(id2).checked){
    						document.getElementById(id2).checked = true;
    						$(document.getElementById(bid)).addClass("active");
    						checked.push(id2);
        					checkedN.push(document.getElementById(id2).name);
    					}
    					pos++;
    				}
    			}
    		}
    	}
    	else{
    		checked.push(this.id);
    		checkedN.push(this.name);
       	}
    }    
    else {
    	alert("삭제되었습니다.");
    	if(this.id.charAt(this.id.indexOf("-")+1)=='0'){
    		var strs = this.id.split("-");
    		var areacode = parseFloat(strs[0]);
    		var id = "N"+areacode;
    		var leng = document.getElementById(id).value;
    		if(leng==1){
    			var id2 = areacode+"-"+0;
    			checked.splice(checked.indexOf(id2),1);
	    		checkedN.splice(checkedN.indexOf(document.getElementById(id2).name),1);
    		}
    		else {
    			var pos = 1;
    			for(var i=1; pos<=leng; i++){
    				var id2 = areacode + "-" + i;
    				var bid = "B" + areacode + "-" + i;
    				if(document.getElementById(id2)){
    					if(document.getElementById(id2).checked){
    						document.getElementById(id2).checked = false;
    						$(document.getElementById(bid)).removeClass("active");
    						checked.splice(checked.indexOf(id2),1);
    	    				checkedN.splice(checkedN.indexOf(document.getElementById(id2).name),1);
    					}
    					pos++;
    				}
    			}
    		}
    	}
    	else{
    		checked.splice(checked.indexOf(this.id),1);
    		checkedN.splice(checkedN.indexOf(this.name),1);
    	}
    }
    	
    if(checkedN.length>0){
    	document.getElementById("checked").innerHTML = "선택한 지역 : " + checkedN.join(" ");
    }
    else{
    	document.getElementById("checked").innerHTML = "지역을 추가해주세요.";
    }
    
    for(var i=0; i<checked.length; i++){
    	var ids = checked[i].split("-");
    	var id = ids[0];
    	var found = false;
    	for(var j=0; j<regions.length; j++){
    		if(regions[j]==id)
    			found = true;
    	}
    	if(found==false){
    		regions.push(id);
    	}
    }
    var dayList = document.getElementById("dayList");
    regions.sort();
    var strs = "";
    for(var i=0; i<regions.length; i++){
    	var tagL = "<label for='DL"+regions[i]+"'>"+document.getElementById("N"+regions[i]).name+"</label> ";
    	var tagSI = "여행 시작일 : <input class='datepicker' data-provide='datepicker' id='D"+regions[i]+"'>"
    	var tagEI = "여행 종료일 : <input class='datepicker' data-provide='datepicker' id='D"+regions[i]+"X'>"
    	strs = strs + tagL + tagSI + tagEI +"<br>";
    }
    $("#dayList").html(strs);
});


window.onload = function() { 
	document.getElementById('nextB').onclick = function() {
		
		var isNull = false;
		for(var i=0; i<regions.length; i++){
			if(document.getElementById("D"+regions[i]).value==""
					|| document.getElementById("D"+regions[i]+"X").value==""){
				isNull = true;
				break;
			}
		}
		
		if(regions.length==0){
			alert("지역을 선택해주세요.");
		}
		else if(isNull == true){
			alert("날짜를 선택하지 않은 것이 있습니다.");
		}
		else{
			var sdate = new Array();
			var edate = new Array();
			for(var i=0; i<checked.length; i++){
				var ids = checked[i].split("-");
				var id = ids[0];
				sdate.push(document.getElementById("D"+id).value);
				edate.push(document.getElementById("D"+id+"X").value);
			}
			
			document.getElementById("arrCode").value=checked;
			document.getElementById("arrName").value=checkedN;
			document.getElementById("arrSDate").value=sdate;
			document.getElementById("arrEDate").value=edate;
			
			document.getElementById('nextF').submit(); 
			return false;
		}
		
	}; 
};

$(document).on("focus",".datepicker",function(){ 
	$( ".datepicker" ).datepicker();
} );


</script>
</body>
</html>
