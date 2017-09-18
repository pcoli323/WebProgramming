<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<style>
	html, body{overflow:hidden;}
	
	.courseView{
	padding:50px;
	}
	.symbolButton{
  	font-size: 14px;
  	text-align: center;
  	vertical-align: middle;
  	border: 1px solid transparent;
  	background-color:#ffffff;
  	outline:0
	}
	.symbol{
	font-size:30px;
	color:#000000;
	}
	.representativeImage {
    width: 100px; height: 100px;
    object-fit: cover;
    border-radius: 50%;
    }
    .representativeImageBig {
    width: 320px; height: 200px;
    }
    .representativeImageTable {
    padding-top:10px;
    padding-bottom:10px;
    padding-right:40px;
    padding-left:40px;
    }
</style>
<head>
	<meta charset="UTF-8">
	<title>courseView Simple</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body>

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
        	</div>
        	<div class="representatives" style="text-align:center">
        		<!-- <div id="showImage" style="position:absolute; left:10px"></div> -->
        		<img src="" class="representativeImageBig" style="position:absolute; display:none">
        		<table style="display:inline-block">
        			<tr>
        				<c:forEach items="${representatives}" var="representative" varStatus="status">
        					<c:if test="${status.index % 2 == 0}">
        						<td class="representativeImageTable">
        							<img src="${representative.gotoImage}" class="representativeImage"><br>${representativeNames[status.index]}
        						</td>
        					</c:if>
        					<c:if test="${status.index % 2 != 0}">
        						<td class="representativeImageTable"></td>
        					</c:if>
        				</c:forEach>
        			</tr>
        			<tr>
        				<c:forEach items="${representatives}" var="representative" varStatus="status">
        					<c:if test="${status.index % 2 == 0}">
        						<td class="representativeImageTable"></td>
        					</c:if>
        					<c:if test="${status.index % 2 != 0}">
        						<td class="representativeImageTable">
        							<img src="${representative.gotoImage}" class="representativeImage"><br>${representativeNames[status.index]}
        						</td>
        					</c:if>
        				</c:forEach>
        			</tr>
        		</table>
        	</div><!-- /representatives -->
       	</div><!-- /courseView-body -->
       	
        <div class="courseView-footer" style="text-align:right">
			<button type="button" class="symbolButton" id="like">
				<span class="glyphicon symbol" id="like_symbol" style="color:#ff0000"></span>
				<small class="likeNum"></small>
			</button>
			<button type="button" class="symbolButton" id="reply">
				<span class="glyphicon glyphicon-comment symbol"></span>
				<small class="replyNum"></small>
			</button>
			<button type="button" class="symbolButton" id="change">
				<span class="glyphicon glyphicon-search symbol"></span>
			</button>
			<button type="button" class="symbolButton" id="getCourse">
				<span class="glyphicon glyphicon-share-alt symbol"></span>
			</button>
        </div><!-- /courseView-footer -->
       	
	</div><!-- /courseView -->
</div><!-- /content -->


<script>
	$(document).ready(function(){
		followCheck();
		likeCheck();
		likeNumber();
		replyNumber();
		// 마우스 올렸을 때 이미지 띄우기
		$(".representativeImage").mouseover(function(){
			$(".representativeImageBig").show();
			var imgSrc = "";
			imgSrc = $(this).attr("src");
			//imgSrc = imgSrc
			$(".representativeImageBig").attr("src", imgSrc);
		});
		$(".representativeImage").mouseout(function(){
			$(".representativeImageBig").hide();
		});
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
	
	$('#change').on("click", function(evt){
		window.open("/course/view/detail?courseNumber=1", "startpop", "width=1030, height=700");
	});
</script>

</body>
</html>