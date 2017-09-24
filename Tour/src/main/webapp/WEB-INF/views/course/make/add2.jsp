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
.floating { position: fixed; right: 50%; top: 150px; margin-right: -750px; text-align:center; width: 150px; border:2px solid #4E7AC7;}
.floating2 { position: fixed; right: 50%; bottom: 50px; margin-right: -750px; text-align:center; width: 150px;}
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
			<!-- 여행지 선택 (버튼) -->
			<div class="tab-content" id="checkboxes" style="padding:10px"></div>
		</div>
		<!-- 다음 단계 이동 -->
		<div class="floating2">
			<button type="button" class="btn btn-default" id="cancel">취소</button>
			<button type="button" class="btn btn-default" id="next">다음</button>
		</div>
		<div class="floating" id="selected">
			<h4>선택한 여행지</h4>
		</div>
	</div>
	<!-- footer -->
	<div></div>
</body>
<script>
var jsonItems; // Ajax 호출 후 데이터를 저장하는 변수 (jsonArray)
var selectedList = new Array(); // 선택한 여행지 정보 (jsonArray)
var total;
var presentPage;

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
	var url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?serviceKey="+'${serviceKey}'+"&MobileOS=ETC&MobileApp=Tour&arrange=B&areaCode=" + codes[0];
	if(codes[1]!="0")
		url += "&sigunguCode="+codes[1];
	url += "&_type=json";
	
	console.log(url);
	
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
    jsonItems = data.response.body.items.item;
    total = data.response.body.totalCount;
    presentPage = data.response.body.pageNo;
    
    var str ="";
	for(var i=0; i<jsonItems.length; i++){
		var json = jsonItems[i];
		if(json.firstimage!=null)
			str += "<div style='margin:10px; padding:5px; border:2px solid #F5F5F5; height:500px; weight=800px;'><img src='" + json.firstimage + "' style='height:485px; weight:auto;float:left;'>";
		else
			str += "<div style='margin:10px; padding:5px; border:2px solid #F5F5F5; height:500px; weight=800px;'><div style='height:485px;width:70%;background-color:#F5F5F5;float:left;text-align:center;padding: 200px 0px;'>이미지 파일이 없습니다.</div>"
		str += "<div style='padding:100px 0px;text-align:center'><h4>"+json.title+"</h4><br><p>";
		if(json.addr1!=null)
			str += "주소 : "+json.addr1;
		if(json.addr2!=null)
			str += " "+json.addr2;
		if(json.tel!=null)
			str += "<br> 전화번호 : "+json.tel;
		str += "</p>"+"<button type='button' class='btn btn-primary' id='"+json.contentid+"'> 선택 </button>"+"</div></div>";
	}
	
	// 페이징
	str += "<ul class='pagination'>";
	var max = ((total/10)+1) - (((total/10)+1)%5);
	var num;
	for(var i=0; i<5; i++){
		if((presentPage-1)%5==i){
			num = i;
		}
	}
	if(presentPage>5){
		var s = id+"_"+(presentPage-(num+5));
		str += "<li><a href='#' id='"+s+"'onclick='callpage(this)');'>이전</a></li>";
	}
	for(var i=0; i<5; i++){
		if((presentPage-1)%5==i){
			num = i;
			var s = id+"_"+presentPage;
			str += "<li class='active'><a href='#' id='"+s+"'onclick='callpage(this)'>"+presentPage+"</a></li>";
		}
		else{
			if((presentPage-(num-i))<=max){
				var s = id+"_"+(presentPage-(num-i));
				str += "<li><a href='#' id='"+s+"'onclick='callpage(this)'>"+(presentPage-(num-i))+"</a></li>";
			}		
		}
	}
	if(presentPage<=max){
		var s = id+"_"+(presentPage+(5-num));
		str += "<li><a href='#' id='"+s+"'onclick='callpage(this)');'>다음</a></li>";
	}
	str += "</ul>";

	document.getElementById(id).innerHTML = str;
}

// 페이징 처리
function callpage(param){
	
	// ajax를 사용한 공공 API 호출 및 저장
	var id = param.id.split("_")[0];
	var codes = id.split("-");
	var url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?serviceKey="+'${serviceKey}'+"&MobileOS=ETC&MobileApp=Tour&arrange=B&areaCode=" + codes[0];
	if(codes[1]!="0")
		url += "&sigunguCode="+codes[1];
	url += "&pageNo="+param.id.split("_")[1];
	url += "&_type=json";
	
	console.log(url);
	
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
}

// 여행지 선택 이벤트 처리
$(document).on("click","#checkboxes :button",function(){
	for(var i=0; i<jsonItems.length; i++){
		var json = jsonItems[i];
		if(this.id==json.contentid){
			var exist = false;
			for(var j=0; j<selectedList.length; j++){
				if(this.id==selectedList[j].contentid){
					exist = true;
					break;
				}
			}
			if(exist==false){
				selectedList.push(json);
				alert("여행지가 추가되었습니다.");
			}
			else{
				alert("이미 추가된 여행지입니다.");
			}
		}
	}
	
	printList();
});

// 여행지 삭제 이벤트 처리
$(document).on("click","#selected :button",function(){
	for(var i=0; i<selectedList.length; i++){
		if(this.id.split("-")[1]==selectedList[i].contentid){
			alert("여행지를 삭제했습니다.");
			selectedList.splice(i,1);
			break;
		}
	}
	printList();
});

// 여행지 출력 처리
function printList() {
	var str=" <h4>선택한 여행지</h4> <hr style='margin:1px;border-top: 1px solid #F5F5F5;'>";
	for(var i=0; i<selectedList.length; i++){
		var selected = selectedList[i];
		str += "<button type='button' class='close pull-right' aria-label='Close' id='X-"+selected.contentid+"'><span aria-hidden='true'>&times;</span></button>";
		str += "<font size='1em'>" + selected.title + "</font>";
		str += "<hr style='margin:1px; border-top: 1px solid #F5F5F5;'>";
	}
	
	document.getElementById("selected").innerHTML = str;
}

//다음 버튼 처리 이벤트
$("#next").click(function(){  
	if(selectedList.length==0){
		alert("여행지를 선택해주세요.");
	}	
	else {
		var jsonData = JSON.stringify(selectedList);
		
		$.ajax({      
        	type:"POST",  
        	url:"/course/make/add2/save",
        	dataType:"json",
        	data:jsonData,
        	contentType:"application/json; charset=utf-8",
        	success:function(){
        		location.href="/course/make/modify";
    		},
			 error:function(){
     			location.href="/course/make/modify";
 			}
  		 });
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
</html>