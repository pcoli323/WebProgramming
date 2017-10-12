<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<style type="text/css">
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
	.courseView{
	width:100%;
	resize:none;
	padding:50px;
	margin:auto;
	}
	.planTables{
	background-color:#F2F2F2;
	padding:20px;
	display:inline-block;
	width:50%;
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
	font-family:'Nanum Pen Script', serif;
	font-size:250%;
	}
	.mapViewContent{
	padding:30px;
	display:inline-block;
	width:50%;
	}
	.mapView{
	height:300px;
	width:100%;
	}
	.symbolButton{
  	font-size: 14px;
  	text-align: center;
  	vertical-align: middle;
  	border: 1px solid transparent;
  	background-color:#ffffff;
  	outline:0
	}
	.story{
	border:1px solid gold;
	padding:20px;
	line-height:200%;
	}
	.symbol{
	font-size:30px;
	color:#000000;
	}
	.media{
	border-top:1px solid #FFCCCC;
	padding:20px;
	padding-bottom:0px;
	}
	.replyInputForm{
	margin-top:20px;
	border-top:1px solid #FFCCCC;
	padding:15px;
	padding-bottom:0px;
	display:none;
	}
	.inputForm{
	margin:10px;
	width:97%;
	padding:10px;
	}
	.replyInputFormButton{
	text-align:right;
	padding-bottom:15px;
	padding-right:20px;
	display:none;
	}
</style>

<head>
	<meta charset="UTF-8">
	<title>courseView Detail</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
<!-- map처리 -->
<script>
	var map;
	function initMap() {
		var mapcenter = {lat: 37.3422186, lng: 127.92016209999997};
		map = new google.maps.Map(document.getElementById('map'), {
			zoom: 5,
			center: mapcenter
		});
	}
	var markers = [];
	var infowindows = [];
	function makeMarker(locationX, locationY, image, title, tel, address){
		if(locationX != ""){
			var mapPositions = new google.maps.LatLng(locationY, locationX);
			var marker = new google.maps.Marker({
				position: mapPositions,
				map: map,
				title:title,
			});
			markers.push(marker);
			if(image != ""){
				var contentString = "<div style='float:left;'><img style='width:150px; height:100px;' src=" + image 
										+ "></div><div style='float:right; padding: 10px;'>" + title + "<br>" + address + "<br>" + tel +"</div>";
			
			} else
				var contentString = "<div style='float:left;'></div><div style='float:right; padding: 10px;'>" + title + "<br>" + address + "<br>" + tel + "</div>";
			var infowindow = new google.maps.InfoWindow({
									content: contentString,
									size: new google.maps.Size(200,100)});
			infowindows.push(infowindow);
			markerListener(marker, infowindow);
		}
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
<script>
	//planTable의 글자크기 자동조절
	function fitFontSize(id, length){
		var size;
		if(length>15){
			size = length - 15;
		}
		fontSize = 250 - size*5;
		$('#'+id).attr("style", "font-size:"+fontSize+"%;");
	}
</script>

</head>
<body onUnload="reloadSimple()">

<div class="content">
	<div class="courseView">
	
		<div class="courseView-header">
			<h2 class="courseName" style="text-align:center">
				${courseVO.courseName}
			</h2>
		</div><!-- /courseView-header -->
        
        <div class="courseView-body">
        	<div class="courseMaker" style="text-align:left">
        		<h4>
        			<c:if test="${loginUser.userNumber ne userVO.userNumber}">
        				<button type="button" class="symbolButton" id="follow"></button>
        			</c:if>
        			${userVO.userName}
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
        						<td style="text-align:center">
        							<c:set var="gotoList" value="${plan.get(date)}"></c:set>
        							<c:forEach var="gotoOne" items="${gotoList}">
        								<div><span class="goto" id="${gotoID}">${gotoOne.gotoName}</span></div>
        								<script>
        									var length = ${gotoOne.gotoName.length()};
        									var id = ${gotoID};
        									if(length>15){
        										fitFontSize(id, length);
        									}
        								</script>
        								<c:set var="gotoID" value="${gotoID + 1}"></c:set>
        							</c:forEach>
        						</td>
        					</tr>
        				</table>
        			</div>
        		</c:forEach>
        	</div><!-- /planTable -->
        	
        	<!-- 지도 -->
        	<div class="mapViewContent">
        	<div class="mapView" id="map">
        		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdkQ3O7ZOpSt2RjwxkSVzgF1NGSHyqkuM&callback=initMap"></script>
        		<c:forEach var="date" items="${plan.keySet()}">
        			<c:set var="gotoList" value="${plan.get(date)}"></c:set>
        			<c:forEach var="gotoOne" items="${gotoList}">
        				<script>
        					makeMarker("${gotoOne.locationX}", "${gotoOne.locationY}", "${gotoOne.gotoImage}", "${gotoOne.gotoName}", "${gotoOne.tel}", "${gotoOne.address}");
        				</script>
        			</c:forEach>
        		</c:forEach>
        	</div><!-- /mapViewContent -->
        	</div><!-- /mapView -->
        	</div><!-- /main -->
        	
        	
        	<c:if test="${courseVO.story ne null}">
        		<div class="story" style="margin-bottom:10px;">
        			${courseVO.story}
        		</div>
        	</c:if>
        			
        </div><!-- /courseView-body -->
        		
        <div class="courseView-footer" style="text-align:right; clear:left">
        	<button type="button" class="symbolButton" id="like">
				<span class="glyphicon symbol" id="like_symbol" style="color:#ff0000"></span>
				<small class="likeNum"></small>
			</button>
			<button type="button" class="symbolButton" id="reply">
				<span class="glyphicon glyphicon-comment symbol"></span>
				<small class="replyNum"></small>
			</button>
			<button type="button" class="symbolButton" id="getCourse">
				<span class="glyphicon glyphicon-share-alt symbol"></span>
			</button>
		</div><!-- /courseView-footer -->
		
		<!-- reply button click으로 추가되는 부분 -->
		<div class="replySection">
			<div class="replyInputForm">
				<input class="inputForm" type="text" placeholder="댓글을 입력하세요" id="newReply">
			</div>
			<div class="replyInputFormButton text-right">
				<button type="submit" class="btn btn-sm" id="addReplyBtn" style="outline:0">등록</button>
			</div>
			<div class="replise">
			</div>
			<div class='text-center'>
				<ul id="pagination" class="pagination pagination-sm no-margin "></ul>
			</div>
		</div><!-- /replySection -->
		
		<!-- 댓글 수정을 위한 Modal -->
		<div class="modal fade" id="replyModifyModal" role="dialog">
			<div class="modal-dialog">
				<!-- Modal content -->
				<div class="modal-content">
					
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">&times;</button>
						<div class="modal-title" style="display:none"></div>
					</div><!-- modal-header -->
					
					<div class="modal-body">
						<input class="inputForm" type="text" id="modifyReply">
					</div><!-- modal-body -->
						
					<div class="modal-footer text-right">
						<button type="button" class="btn btn-success" id="modifyReplyBtn">수정</button>
						<button type="button" class="btn btn-danger" id="deleteReplyBtn">삭제</button>
					</div><!-- /modal-footer -->
					
				</div><!-- modal-content -->
			</div><!-- /modal-dialog -->
		</div><!-- replyModifyModal -->
        
	</div><!-- /courseView -->
</div><!-- /content -->

<script>
	var loginCheck;
	var loginUserNumber;
	var courseNumber;
	var following;
	$(document).ready(function(){
		// 변수 초기화
		loginCheck = ${loginCheck};
		if(loginCheck == false){
			loginUserNumber = null;
		}
		else{
			loginUserNumber = ${loginUser.userNumber};
		}
		courseNumber = ${courseVO.courseNumber};
		following = ${userVO.userNumber};
		// view 초기화
		followCheck();
		likeCheck();
		likeNumber();
		replyNumber();
	});
	
	// map이 scroll 따라 다니도록
	$(window).scroll(function(){
		var position = $(window).scrollTop();
		var maxPosition = $(".mapViewContent").height() - $(".mapView").height() - $(".courseView-header").height() - $(".courseMaker").height();
		if(position < maxPosition){
			$(".mapView").stop().animate({"top":position+"px"},1000);
		}
	});
	
	// courseView를 보는 사용자가 팔로우를 한 사용자인가?
	function followCheck(){
		var userNumber = ${courseVO.userNumber}
		if(loginCheck == true){
			if(loginUserNumber != userNumber){
				$.ajax({
					type:'post',
					url:'/follow/check',
					headers:{
						"Content-Type": "application/json",
						"X-HTTP-Method-Override": "POST"
					},
					dataType:'text',
					data: JSON.stringify({
						following:following,
						followed:loginUserNumber
					}),
					success:function(result){
						console.log("result:" + result);
						if(result == 0){
							// 사용자가 팔로우를 하지 않은 상태
							followToggle("non-follow");
						}
						else{
							followToggle("follow");
						}
					}
				});
			}
		}
		else{
			followToggle("non-follow");
		}
	}
	
	// like 수
	function likeNumber(){
		$.ajax({
			type:'get',
			url:'/like/count/'+courseNumber,
			headers: { "Content-Type": "application/json" },
			success:function(result){
				$('.likeNum').html(result);
			}
		});
	}
	// courseView를 보는 사용자가 종아요를 누른 사용자인가?
	function likeCheck(){
		if(loginCheck == true){
			$.ajax({
				type:'post',
				url:'/like/check',
				headers:{
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "POST"
				},
				dataType:'text',
				data: JSON.stringify({
					courseNumber:courseNumber,
					userNumber:loginUserNumber
				}),
				success:function(result){
					console.log("result:" + result);
					if(result == 0){
						// 사용자가 좋아요를 누르지 않은 상태
						likeToggle("non-active");
					}
					else if(result == 1){
						// 사용자가 좋아요를 누른 상태
						likeToggle("ative");
					}
					else{
						console.log("check user number in like");
					}
				}
			});
		}
		else{
			likeToggle("non-active");
		}
	}
	
	// reply 수
	function replyNumber(){
		$.ajax({
			type:'get',
			url:'/replise/count/'+courseNumber,
			headers: { "Content-Type": "application/json" },
			success:function(result){
				$('.replyNum').html(result);
			}
		});
	}
	
	// goto 마우스로 over되면 색 변하도록
	$('.goto').mouseover(function(){
		var index = $(this).attr("id");
		var str = $(this).attr("style");
		
		if(index < markers.length){
			str = str + ";background-color:#d9ff66;cursor:pointer;";
			$(this).attr("style", str);
		}
		else{
			str = str + ";cursor:not-allowed;"
			$(this).attr("style", str);
		}
	});
	$('.goto').mouseout(function(){
		var index = $(this).attr("id");
		var str = $(this).attr("style").split(';');
		
		if(index < markers.length){
			$(this).attr("style", str[0]);
		}
	});
	
	// goto 누르면 지도에 해당하는 marker에 대해 작동하도록
	// markers[]
	$('.goto').on("click", function(){
		var index = $(this).attr("id");
		
		if(index < markers.length){
			infowindows[index].open(map, markers[index]);
			markers[index].setAnimation(google.maps.Animation.BOUNCE);
		}
	});
</script>

<!-- symbol인 버튼 눌렀을 때 -->
<script>
	$('#follow').on("click", function(){
		if(loginCheck == false){
			alert("로그인 후 사용하실 수 있습니다.");
		}
		else{
			var checkFollow = $(this).hasClass("active");
			if(checkFollow == 0){
				$.ajax({
					type:'post',
					url:'/follow/add',
					headers: {
						"Content-Type": "application/json",
						"X-HTTP-Method-Override": "POST"
					},
					dataType:'text',
					data: JSON.stringify({
						following:following,
						followed:loginUserNumber
					}),
					success:function(result){
						console.log("result:" + result);
						if(result == 'SUCCESS'){
							alert("follow!!");
							followToggle("follow");
						}
					}
				});
			}
			else{
				$.ajax({
					type:'delete',
					url:'/follow/delete',
					headers: {
						"Content-Type": "application/json",
						"X-HTTP-Method-Override": "DELETE"
					},
					dataType:'text',
					data: JSON.stringify({
						following:following,
						followed:loginUserNumber
					}),
					success:function(result){
						console.log("result:" + result);
						if(result == 'SUCCESS'){
							alert("no follow!!");
							followToggle("non-follow");
						}
					}
				});
			}
		}
	});
	function followToggle(status){
		// status는 원하는 상태
		var str = "";
		if(status == "non-follow"){
			str = "<i class='material-icons' style='color:#d21a0b'>person_add</i>";
			$('#follow').removeClass("active");
			$('#follow').html(str);
		}
		else{
			str = "<i class='material-icons' style='color:#d21a0b'>people</i>";
			$('#follow').addClass("active");
			$('#follow').html(str);
		}
	}
	
	$('#like').on("click", function(){
		if(loginCheck == false){
			alert("로그인 후 사용하실 수 있습니다.");
		}
		else{
			var checkLike = $(this).hasClass("active");
			if(checkLike == 0){
				$.ajax({
					type:'post',
					url:'/like/add',
					headers: {
						"Content-Type": "application/json",
						"X-HTTP-Method-Override": "POST"
					},
					dataType:'text',
					data: JSON.stringify({
						courseNumber:courseNumber,
						userNumber:loginUserNumber
					}),
					success:function(result){
						console.log("result:" + result);
						if(result == 'SUCCESS'){
							alert("like!!");
							likeToggle("active");
							likeNumber();
						}
					}
				});
			}
			else{
				$.ajax({
					type:'delete',
					url:'/like/delete',
					headers: {
						"Content-Type": "application/json",
						"X-HTTP-Method-Override": "DELETE"
					},
					dataType:'text',
					data: JSON.stringify({
						courseNumber:courseNumber,
						userNumber:loginUserNumber
					}),
					success:function(result){
						console.log("result:" + result);
						if(result == 'SUCCESS'){
							alert("no like!!");
							likeToggle("non-active");
							likeNumber();
						}
					}
				});
			}
		}
	});
	function likeToggle(status){
		// status는 원하는 상태
		if(status == "non-active"){
			$('#like').removeClass("active");
			$('#like_symbol').removeClass("glyphicon-heart").addClass("glyphicon-heart-empty");
		}
		else{
			$('#like').addClass("active");
			$('#like_symbol').removeClass("glyphicon-heart-empty").addClass("glyphicon-heart");
		}
	}
	
	$('#getCourse').on("click", function(){
		if(loginCheck == false){
			alert("로그인 후 사용하실 수 있습니다.");
		}
		else{
			var courseName = "${courseVO.courseName}";
			var isGotten = true;
			
			$.ajax({
				type:'post',
				url:'/get/course',
				headers: {
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "post"
				},
				dataType:'text',
				data: JSON.stringify({
					courseNumber:courseNumber,
					courseName:courseName,
					userNumber:loginUserNumber,
					isGotten:isGotten
				}),
				success:function(result){
					console.log("result:" + result);
					if(result == 'SUCCESS'){
						alert("get course!!");
					}
				}
			});
		}
	});
</script>
<!-- 댓글 처리 -->
<script id="template" type="tex/x-handlerbars-template">
	{{#each.}}
	<div class="media" data-replyNumber={{replyNumber}}>
		<div class="media-body">
			<h4 class="media-heading">
				{{replyerName}}&nbsp;&nbsp;&nbsp;<small><i>{{prettifyDate regDate}}</i></small>
			</h4>
			<p class="media-body-reply">{{reply}}</p>
		</div>
		<div class="media-modify" style="text-align:right">
			{{#eqReplyer replyer}}
			<a class="btn btn-success btn-sm" data-toggle="modal" data-target="#replyModifyModal">수정</a>
			{{/eqReplyer}}
		</div>
	</div>
	{{/each}}
</script>
<script>
	// courseNumber는 위에
	var replyPage = 1;
	$('#reply').on("click", function(evt){
		$(".replyInputForm").show();
		$(".replyInputFormButton").show();
		replyPage = 1;
		getList(replyPage);
	});
	
	function getList(page){
		
		$.getJSON("/replise/list/"+courseNumber+"/"+page, function(data){
			console.log(data.list.length);
			
			var source = $("#template").html();
			var template = Handlebars.compile(source);
			
			$("#replyModifyModal").modal('hide');
			$(".replise").html(template(data.list));
			
			printPaging(data.pageMaker);
		});
	}
	function printPaging(pageMaker){
		
		var str = "";
		
		if(pageMaker.prev){
			str += "<li><a href='"+(pageMaker.startPage-1)+"'> << </a></li>";
		}
		
		for(var i=pageMaker.startPage, len = pageMaker.endPage; i <= len; i++){
			var strClass = pageMaker.cri.page == i?'class=active':'';
			str += "<li "+strClass+"><a href='"+i+"'>"+i+"</a></li>";
		}
		
		if(pageMaker.next){
			str += "<li><a href='"+(pageMaker.endPage + 1)+"'> >> </a></li>";
		}
		$('.pagination').html(str);
	}
	$(".pagination").on("click", "li a", function(event){
		
		event.preventDefault();
		
		replyPage = $(this).attr("href");
		
		getList(replyPage);
	})
	// 댓글의 등록 날짜 모양 만들기
	Handlebars.registerHelper("prettifyDate", function(timeValue){
		var dateObj = new Date(timeValue);
		var timeOffset = dateObj.getTimezoneOffset();
		var localDate = new Date(dateObj.getTime() - timeOffset * 60 * 1000);
		
		return localDate.toISOString().replace("T", " ").slice(0, 19);
	});
	// 자신이 등록한 댓글만 수정이 가능하도록
	Handlebars.registerHelper("eqReplyer", function(replyer, block){
		var accum = '';
		if(replyer == loginUserNumber){
			accum += block.fn(); // fn은 block의 값을 그대로 string으로 출력해주는 것, block은 handlebar가 사용된 부분을 들고옴
		}
		return accum;
	});
	
	$("#addReplyBtn").on("click", function(){
		if(loginCheck == false){
			alert("로그인 후 사용하실 수 있습니다.");
		}
		else{
			var replyObj = $("#newReply");
			var reply = replyObj.val();
			
			$.ajax({
				type:'post',
				url:'/replise/add',
				headers: {
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "POST" },
				dataType:'text',
				data: JSON.stringify({
					courseNumber:courseNumber,
					reply:reply,
					replyer:loginUserNumber
				}),
				success:function(result){
					console.log("result: " + result);
					if(result == 'SUCCESS'){
						alert("등록 되었습니다.");
						replyPage = 1;
						getList(replyPage);
						replyerObj.val("");
						replyObj.val("");
					}
				}
			});
		}
	});
	// 댓글별 수정버튼 처리
	$(".replise").on("click", ".media", function(event){
		
		var replyObj = $(this);
		
		$("#modifyReply").val(replyObj.find('.media-body-reply').text());
		$(".modal-title").html(replyObj.attr("data-replyNumber"));
	})
	
	$("#modifyReplyBtn").on("click", function(){
		
		var replyNumber = $(".modal-title").html();
		var reply = $("#modifyReply").val();
		
		$.ajax({
			type:'put',
			url:'/replise/modify/'+replyNumber,
			headers: {
				"Content-Type": "application/json",
				"X-HTTP-Method-Override": "PUT"
			},
			data:JSON.stringify({reply:reply}),
			dataType:'text',
			success:function(result){
				console.log("result: " + result);
				if(result == 'SUCCESS'){
					alert("수정 되었습니다.");
					getList(replyPage);
				}
			}
		});
	});
	
	$("#deleteReplyBtn").on("click", function(){
		
		var replyNumber = $(".modal-title").html();
		
		$.ajax({
			type:'delete',
			url:'/replise/delete/'+replyNumber,
			headers: {
				"Content-Type": "application/json",
				"X-HTTP-Method-Override": "DELETE"
			},
			dataType:'text',
			success:function(result){
				console.log("result: " + result);
				if(result == 'SUCCESS'){
					alert("삭제 되었습니다.");
					getList(replyPage);
				}
			}
		});
	});
</script>
<!-- 종료시 -->
<script>
	function reloadSimple(){
		opener.location.reload();
	}
</script>
</body>
</html>