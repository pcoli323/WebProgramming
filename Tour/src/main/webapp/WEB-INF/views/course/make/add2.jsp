<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>코스 생성중 - 2단계</title>
	<meta charset="utf-8">
	<meta name="viewport">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<style>
.floating { position: fixed; top: 60px; right: 1%; text-align:center; width: 150px; border:2px solid #3f2018; background-color:#ffffff;}
.floating2 { position: fixed; bottom: 220px; right: 1%; text-align:center; width: 150px;}
.box {
	font-size:20px;
	color:#3f2018;
	border:1px solid #3f2018;
	padding-right:20px;
	border-radius: 10px;
}
.selectedBox {
	font-size:20px;
	color:#ffffff;
	background-color:#3f2018;
	border:1px solid #024782;
	padding-right:20px;
	border-radius: 10px;
}
#sbox input {
	visibility:hidden;
}
#sbox li {
	margin-right: 15px;
}
.pagination>li>a{
    color: #3F2018 !important;
    }
    .pagination>.active>a{
    background-color: #3F2018 !important;
    border-color: #3F2018 !important;
    color: white !important;
   }
   .pagination a:hover:not(.active) {
   background-color: #e3beb5 !important;
   border-color: #e3beb5 !important;
   }
</style>
<body id="home">
	<!-- header -->
	<%@include file="../../include/navbar.jsp" %>
	<!-- /course/make/add2 -->
	<div class="container" style="padding:10px; border:2px solid #F5F5F5; min-height:500px;">
		<!-- 소개 -->
		<div>
			<h1>두 번째 단계 : 여행지 선택 단계입니다.</h1>
			<p>여행지를 선택해주세요.</p>
		</div>	
		<!-- 선택 -->
		<div style="padding:10px; border:2px solid #F5F5F5;">
			<!-- 지역 선택 (탭) -->
			<ul class="nav nav-tabs" id="myTab" role="tablist" style="padding:10px;"></ul>
			<div class="row" style="padding:10px;">
				<div class="col-sm-12">
					<form id="sbox">
    					<label class="radio-inline selectedBox">
      						<input type="radio" name="optradio" value="12" checked="checked">관광지
    					</label>
    					<label class="radio-inline box">
      						<input type="radio" name="optradio" value="14">문화시설
    					</label>
    					<label class="radio-inline box">
      						<input type="radio" name="optradio" value="28">레포츠
    					</label>
    					<label class="radio-inline box">
      						<input type="radio" name="optradio" value="38">쇼핑
    					</label>
    					<label class="radio-inline box">
      						<input type="radio" name="optradio" value="39">음식
    					</label>
 					</form>
				</div>
				<div class="col-sm-4 col-sm-offset-8" style="margin-top:10px;">
					<form>
    					<label class="radio-inline">
      						<input type="radio" name="optradio" value="A">제목순
    					</label>
    					<label class="radio-inline">
      						<input type="radio" name="optradio" value="B" checked="checked">조회순
    					</label>
    					<label class="radio-inline">
      						<input type="radio" name="optradio" value="C">수정일순
    					</label>
    					<label class="radio-inline">
      						<input type="radio" name="optradio" value="D">생성일순
    					</label>
 					</form>
				</div>
			</div>
			<!-- 여행지 선택 (버튼) -->
			<div class="tab-content" id="checkboxes" style="padding:10px"></div>
		</div>
		<!-- 다음 단계 이동 -->
		<div class="floating2">
			<button type="button" class="btn btn-default" id="prev">이전</button>
			<button type="button" class="btn btn-default" id="next">다음</button>
			<button type="button" class="btn btn-default" id="cancel">취소</button>
		</div>
		<div class="floating" style="overflow-y:auto; overflow-x:hidden; height:400px;" id="selected">
			<h4>선택한 여행지</h4>
		</div>
	</div>
	<!-- footer -->
	<%@include file="../../include/footer.jsp" %>
</body>

<script>
var jsonItems; // Ajax 호출 후 데이터를 저장하는 변수 (jsonArray)
var selectedList = new Array(); // 선택한 여행지 정보 (jsonArray)
var selectedListUser = new Array(); // 사용자가 추가한 여행지 정보 (jsonArray)
var total;
var totalPage;
var presentPage;
var contentType = "12";
var orderOptions = "B";
var nowTab = null;

// 초기 화면 생성 부분
$(document).ready(function(){
	var jsonIDArr = JSON.parse('${idList}');
	
	// 지역 선택 (탭) 추가
	var str ="";
	for(var i=0; i<jsonIDArr.length; i++){
		var json = jsonIDArr[i];
		str += "<li class='nav-item'>" + "<a class='nav-link' data-toggle='tab' style='color:#3f2018;' href='#" + json.areaCode + "-" + json.sigunguCode + "' role='tab'>" + json.areaName + " " + json.sigunguName + "</a>" + "</li>";
	}
	document.getElementById("myTab").innerHTML = str;
	
	// 여행지 선택 탭칸 추가
	str = "";
	for(var i=0; i<jsonIDArr.length; i++){
		var json = jsonIDArr[i];
		str += "<div class='tab-pane' id='" + json.areaCode + "-" + json.sigunguCode + "' role='tabpanel'></div>";
	}
	document.getElementById("checkboxes").innerHTML = str;

	$('#myTab a[href="#'+jsonIDArr[0].areaCode+'-'+jsonIDArr[0].sigunguCode+'"]').trigger('click');
	
	// 초기 데이터 설정 (for 수정용)
	var jsona = JSON.parse('${list}');
	for(var i=0; i<jsona.length; i++){
		var data = new Object();
		var json = jsona[i];
		
		data.addr1 = json.addr1;
		data.addr2 = json.addr2;
		data.areacode = json.areacode;
		data.contentid = json.contentid;
		data.contenttypeid = json.contenttypeid;
		data.createdtime = json.createdtime;
		data.firstimage = json.firstimage;
		data.firstimage2 = json.firstimage2;
		data.mapx = json.mapx;
		data.mapy = json.mapy;
		data.modifiedtime = json.modifiedtime;
		data.readcount = json.readcount;
		data.tel = json.tel;
		data.title = json.title;
		data.sigungucode = json.sigungucode;
		data.isNew = json.isNew;
		data.date = json.date;
		
		selectedList.push(data);
	}
	printList();
	
	// 초기 데이터 설정 (for 수정용)
	var jsona = JSON.parse('${listO}');
	for(var i=0; i<jsona.length; i++){
		var data = new Object();
		var json = jsona[i];
		
		data.addr1 = json.gotoAddr1;
		data.addr2 = json.gotoAddr2;
		data.areacode = json.gotoAreaCode;
		data.contentid = json.gotoContentID;
		data.contenttypeid = json.gotoContentTypeID;
		data.createdtime = json.gotoCreatedTime;
		data.firstimage = json.gotoImageReal;
		data.firstimage2 = json.gotoImageThum;
		data.mapx = json.gotoLocationX;
		data.mapy = json.gotoLocationY;
		data.modifiedtime = json.gotoModifiedTime;
		data.readcount = json.gotoReadCount;
		data.tel = json.gotoTel;
		data.title = json.gotoTitle;
		data.sigungucode = json.gotoSigunguCode;
		data.isNew = json.isNew;
		
		var date = new Date(json.gotoDate);
		var parsedDate = date.getMonth()+1 + "/" + date.getDate() + "/" + date.getFullYear();
		data.date = parsedDate;
		
		selectedList.push(data);
	}
	
	var jsonu = JSON.parse('${listU}');
	for(var i=0; i<jsonu.length; i++){
		var json = jsonu[i];
		
		data.addr1 = json.gotoAddr1;
		data.addr2 = json.gotoAddr2;
		data.areacode = json.gotoAreaCode;
		data.contentid = json.gotoContentID;
		data.contenttypeid = json.gotoContentTypeID;
		data.createdtime = json.gotoCreatedTime;
		data.firstimage = json.gotoImageReal;
		data.firstimage2 = json.gotoImageThum;
		data.mapx = json.gotoLocationX;
		data.mapy = json.gotoLocationY;
		data.modifiedtime = json.gotoModifiedTime;
		data.readcount = json.gotoReadCount;
		data.tel = json.gotoTel;
		data.title = json.gotoTitle;
		data.sigungucode = json.gotoSigunguCode;
		data.isNew = json.isNew;
		
		var date = new Date(json.gotoDate);
		var parsedDate = date.getMonth()+1 + "/" + date.getDate() + "/" + date.getFullYear();
		data.date = parsedDate;
		
		selectedListUser.push(json);
	}
	printList();
});

// 정렬 옵션 선택 처리 부분
$(document).on("change","input:radio",function(){
	
	var str = this.value;
	
	if(str=="A" || str=="B" || str=="C" ||str=="D"){
		orderOptions = str;
	}
	else{
		var check = document.getElementsByClassName("selectedBox");
		if(check.length==1){
			check[0].classList.add("box");
			check[0].classList.remove("selectedBox");
		}
		this.parentElement.classList.remove("box");
		this.parentElement.classList.add("selectedBox");
		
		contentType = str;
	}
	
	if(nowTab!=null){
		callAPI(nowTab);
	}
});


// API 호출 부분
function callAPI(id){
	var codes = id.split("-");
	
	// ajax를 사용한 공공 API 호출 및 저장
	var url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?serviceKey="+'${serviceKey}'+"&MobileOS=ETC&MobileApp=Tour&areaCode=" + codes[0];
	url += "&arrange="+orderOptions;
	if(contentType!="0")
		url += "&contentTypeId="+contentType;
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
}

//체크-버튼 이벤트 처리 부분
$(document).on("click",".nav-link",function(){
	nowTab = this.href.split("#")[1];	
	callAPI(nowTab);
});

// API 호출 후 화면 생성 부분
function saveAprint(data,id) {
    jsonItems = data.response.body.items.item;
    total = data.response.body.totalCount;
    totalPage = parseInt((total/10)+1);
    presentPage = data.response.body.pageNo;
    
    var str ="";
    if(Array.isArray(jsonItems)){
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
    		str += "</p>"+"<button type='button' class='btn' style='background-color:#3f2018;' id='"+json.contentid+"'> <font color='#ffffff'>선택</font> </button>"+"</div></div>";
    	}
    }

    else {
    	var json = jsonItems;
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
		str += "</p>"+"<button type='button' class='btn' style='background-color:#3f2018;' id='"+json.contentid+"'> <font color='#ffffff'>선택</font> </button>"+"</div></div>";
    }
    
	
	
	// 페이징
	str += "<ul class='pagination'>";

	// 이전
	if(presentPage>5){
		var s = id+"_"+(presentPage-5);
		str += "<li><a href='#' id='"+s+"'onclick='callpage(this)');'>이전</a></li>";
	}
	
	// 5개
	var index = (presentPage-1)%5; // 0~4
	var max = 0;
	for(var i=0; i<5; i++){
		if(index==i){
			var s = id+"_"+presentPage;
			str += "<li class='active'><a href='#' id='"+s+"'onclick='callpage(this)'>"+presentPage+"</a></li>";
			max = presentPage;
			//console.log(s);
		}
		else{
			var num = presentPage-(index-i);
			if(num<=totalPage){
				var s = id+"_"+num;
				str += "<li><a href='#' id='"+s+"'onclick='callpage(this)'>"+num+"</a></li>";
				max = presentPage-(index-i);
				//console.log(s);
			}		
		}
	}
	
	// 다음
	if(max<totalPage){
		var s = id+"_"+(max+1);
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
	var url = "http://api.visitkorea.or.kr/openapi/service/rest/KorService/areaBasedList?serviceKey="+'${serviceKey}'+"&MobileOS=ETC&MobileApp=Tour&&areaCode=" + codes[0];
	if(codes[1]!="0")
		url += "&sigunguCode="+codes[1];
	if(contentType!="0")
		url += "&contentTypeId="+contentType;
	url += "&arrange="+orderOptions;
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
		if(selected.isNew==null || (selected.isNew!=null && selected.isNew==false)){
			str += "<button type='button' class='close pull-right' aria-label='Close' id='X-"+selected.contentid+"'><span aria-hidden='true'>&times;</span></button>";
			str += "<font size='1em'>" + selected.title + "</font>";
			str += "<hr style='margin:1px; border-top: 1px solid #F5F5F5;'>";
		}
	}
	
	// 수정 : 추가한 여행지 처리 부분
	if(selectedListUser.length!=0){
		str += "<hr style='margin:1px; border-top: 1px solid #F5F5F5;'>";
		str += "<h5>내가 추가한 여행지</h5> <hr style='margin:1px;border-top: 1px solid #F5F5F5;'>"
		for(var i=0; i<selectedListUser.length; i++){
			var selected = selectedListUser[i];
			str += "<font size='1em'>" + selected.title + "</font>";
			str += "<hr style='margin:1px; border-top: 1px solid #F5F5F5;'>";
		}
	}
	
	document.getElementById("selected").innerHTML = str;
}

// 이전 버튼 처리 이벤트
$("#prev").click(function(){  
	location.href="/course/make/add1";
});

// 다음 버튼 처리 이벤트
$("#next").click(function(){  
	if(selectedList.length==0){
		alert("여행지를 선택해주세요.");
	}	
	else {
		for(var i=0; i<selectedListUser.length; i++){
			selectedList.push(selectedListUser[i]);
		}
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