<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<style type="text/css">
	html, body{overflow-x:hidden;}
	
	table{
	width:170px;
	height:250px;
	}
	table th{
	padding:10px;
	}
	table td{
	padding:20px;
	}
	
	.courseView{
	width:1010px;
	resize:none;
	padding:50px;
	}
	.planTables{
	background-color:#F2F2F2;
	padding:20px;
	}
	.planTable{
	background-color:#F2F2F2;
	width:20%;
	display:inline-block;
	margin:20px;
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
</head>
<body onload="parent.resizeTo(1030,700)" onUnload="reloadSimple()">

<div class="content">
	<div class="courseView">
	
		<div class="courseView-header">
			<h2 class="courseName" style="text-align:center">
				${courseVO.courseName}
			</h2>
		</div><!-- /courseView-header -->
        
        <div class="courseView-body">
        	<div class="courseMaker" style="text-align:left">
        		<h5>
        			<button type="button" class="symbolButton" id="follow"></button>
        			${userVO.userName}
        		</h5>
        	</div><!-- /courseMaker -->
        	
       		<div class="planTables">
        		<c:forEach var="date" items="${plan.keySet()}">
        			<div class="planTable">
        				<table style="background-color:#ffff99">
        					<tr class="dtaeField" >
        						<th style="text-align:center;height:30px;background-color:#ffff80">${date}</th>
        					</tr>
        					<tr class="gotoField">
        						<td style="text-align:center">
        							<c:set var="gotoNameList" value="${plan.get(date)}"></c:set>
        							<c:forEach var="gotoName" items="${gotoNameList}">
        								<i>${gotoName}</i><br><br>
        							</c:forEach>
        						</td>
        					</tr>
        				</table>
        			</div>
        		</c:forEach>
        	</div><!-- /planTable -->
        	
        	<div class="map">
        		지도를 입력해주세요
        	</div>
        	
        	<div class="story">
        		${courseVO.story}
        	</div>
        			
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
				<input class="inputForm" type="text" placeholder="USER ID" id="newReplyer">
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
						<input class="inputForm" type="text" id="modifyrReply">
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
	$(document).ready(function(){
		followCheck();
		likeCheck();
		likeNumber();
		replyNumber();
	});
	
	var courseNumber = ${courseVO.courseNumber};
	var loginUserNumber = ${login.userNumber};
	var following = ${userVO.userNumber};
	
	// courseView를 보는 사용자가 팔로우를 한 사용자인가?
	function followCheck(){
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
</script>
<!-- symbol인 버튼 눌렀을 때 -->
<script>
	$('#follow').on("click", function(){
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
			<a class="btn btn-success btn-sm" data-toggle="modal" data-target="#replyModifyModal">수정</a>
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
	
	$("#addReplyBtn").on("click", function(){
		var replyerObj = $("#newReplyer");
		var replyObj = $("#newReply");
		var replyer = replyerObj.val();
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
				replyer:replyer
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
	});
	
	// 댓글별 수정버튼 처리
	$(".replise").on("click", ".media", function(event){
		
		var replyObj = $(this);
		
		$("#modifyrReply").val(replyObj.find('.media-body-reply').text());
		$(".modal-title").html(replyObj.attr("data-replyNumber"));
	})
	
	$("#modifyReplyBtn").on("click", function(){
		
		var replyNumber = $(".modal-title").html();
		var reply = $("#modifyrReply").val();
		
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