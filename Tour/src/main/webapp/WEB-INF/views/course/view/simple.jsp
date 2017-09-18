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
        	<div class="courseMaker" style="text-align:right">
        		<h5>${userVO.userName}
        		<button type="button" class="btn" id="follow" style="background-color:#ffffff;outline:0">
					<span class="glyphicon glyphicon-star symbol" style="color:#ffff00"></span>
				</button>
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
					<button type="button" class="btn" id="like" style="background-color:#ffffff;outline:0">
						<span class="glyphicon glyphicon-heart symbol" style="color:#ff0000"></span>
						<small class="likeNum"></small>
					</button>
					<button type="button" class="btn" id="reply" style="background-color:#ffffff;outline:0">
						<span class="glyphicon glyphicon-comment symbol"></span>
						<small class="replyNum"></small>
					</button>
					<button type="button" class="btn" id="change" style="background-color:#ffffff;outline:0">
						<span class="glyphicon glyphicon-search symbol"></span>
					</button>
					<button type="button" class="btn" id="getCourse" style="background-color:#ffffff;outline:0">
						<span class="glyphicon glyphicon-share-alt symbol"></span>
					</button>
        		</div><!-- /courseView-footer -->
        		
        	</div><!-- /courseView -->
</div><!-- /content -->


<script>
	$(document).ready(function(){
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
	var loginUserNumber = ${login.userNumber};
	$('#follow').on("click", function(){
		var following = ${userVO.userNumber};
		var followed = loginUserNumber;
		
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
				followed:followed
			}),
			success:function(result){
				console.log("result:" + result);
				if(result == 'SUCCESS'){
					alert("follow!!");
				}
			}
		});
	});
	
	$('#like').on("click", function(){
		// courseNumber는 위에
		var userNumber = loginUserNumber;
		
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
				userNumber:userNumber
			}),
			success:function(result){
				console.log("result:" + result);
				if(result == 'SUCCESS'){
					alert("like!!");
					likeNumber();
				}
			}
		});
	});
	
	$('#change').on("click", function(evt){
		window.open("/course/view/detail?courseNumber=1", "startpop", "width=1030, height=700");
	});
</script>

</body>
</html>