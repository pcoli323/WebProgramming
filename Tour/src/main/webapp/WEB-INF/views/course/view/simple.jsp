<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<style>
	@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);
	@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);
	
	.content{
	position:relative;
	width:65%;
	margin:auto;
	}
	
	.courseView{
	padding:50px;
	padding-bottom:0px;
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
    .representativeImageTable {
    padding:5px 5px 10px 10px;
    font-family:'Nanum Pen Script';
    font-size:150%;
    width:15%;
    word-break: break-all;
    text-align:center;
    }
    .mouseOverImageView{
    height:300px;
    display:none;
    text-align:center;
    background-color:black;
    margin:auto;
    }
    .mouseOverImageContent{
    height:100%;
    width:50%;
    background-color:black;
    display:inline-block;
    }
    .mouseOverImage{
    max-width:100%;
    height:auto;
    max-height:100%;
    position: relative;
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
			<h2 class="courseName" style="text-align:center;font-family:'Jeju Gothic';">
				${courseVO.courseName}
			</h2>
		</div><!-- /courseView-header -->
        
        <div class="courseView-body">
        	<div class="courseMaker" style="text-align:left;font-family:'Jeju Gothic';">
        		<h5>
        			<button type="button" class="symbolButton" id="follow"></button>
					${userVO.userName}
        		</h5>
        	</div>
        	<div class="representatives" style="text-align:center">
        		<!-- <div id="showImage" style="position:absolute; left:10px"></div> -->
        		<table style="display:inline-block;">
        			<tr>
        				<c:forEach items="${representatives}" var="representative" varStatus="status">
        					<c:if test="${status.index % 2 == 0}">
        						<td class="representativeImageTable">
        							<c:choose>
        								<c:when test="${representative.gotoImageThum ne null}">
        									<img src="${representative.gotoImageThum}" class="representativeImage thumImage" id="${representative.gotoNumber}"><br>
        								</c:when>
        								<c:otherwise>
        									<c:choose>
        										<c:when test="${representative.gotoImageReal ne null}">
        											<img src="${representative.gotoImageReal}" class="representativeImage realImage" id="${representative.gotoNumber}"><br>
        										</c:when>
        										<c:otherwise>
        											<div class="representativeImage noImage" style="background-color:lightGray;text-align:center;margin:auto;">
        												<div style="position:relative;font-size:80%;top:26%;">사진이<br>없습니다</div>
        											</div>
        										</c:otherwise>
        									</c:choose>
        								</c:otherwise>
        							</c:choose>
        							${representative.gotoTitle}
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
        							<c:choose>
        								<c:when test="${representative.gotoImageThum ne null}">
        									<img src="${representative.gotoImageThum}" class="representativeImage thumImage" id="${representative.gotoNumber}"><br>
        								</c:when>
        								<c:otherwise>
        									<c:choose>
        										<c:when test="${representative.gotoImageReal ne null}">
        											<img src="${representative.gotoImageReal}" class="representativeImage realImage" id="${representative.gotoNumber}"><br>
        										</c:when>
        										<c:otherwise>
        											<div class="representativeImage noImage" style="background-color:lightGray;text-align:center;margin:auto;">
        												<div style="position:relative;font-size:80%;top:26%;">사진이<br>없습니다</div>
        											</div>
        										</c:otherwise>
        									</c:choose>
        								</c:otherwise>
        							</c:choose>
        							${representative.gotoTitle}
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
			<button type="button" class="symbolButton" id="reply" style="cursor:default">
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
	<!-- mouseOver시 보여지는 big 이미지-->
	<div class="mouseOverImageView">
		<div class="mouseOverImageContent">
		</div><!-- /mouseOverImageContent -->
	</div><!-- /mouseOverImageView -->
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
		// 마우스 올렸을 때 이미지 띄우기
		$(".representativeImage").mouseover(function(event){
			var imgSrc = "";
			var imgHtml;
			
			if($(this).hasClass("noImage") == false){
				if ($(this).hasClass("realImage") == true){
					imgSrc = $(this).attr("src");
					imgHtml = "<img src=" + imgSrc + " class='mouseOverImage'>";
					$(".mouseOverImageContent").html(imgHtml);
					$(".mouseOverImageView").show();
				}
				else{
					var gotoNumber = $(this).attr("id");
					
					$.ajax({
						type:'get',
						url:'/getGotoRealImage?gotoNumber=' + gotoNumber,
						success:function(realImage){
							imgSrc = realImage;
							imgHtml = "<img src=" + imgSrc + " class='mouseOverImage'>";
							$(".mouseOverImageContent").html(imgHtml);
							$(".mouseOverImageView").show();
						}
					});
				}
			}
		});
		$(".representativeImage").mouseout(function(){
			if($(this).hasClass("noImage") == false){
				$(".mouseOverImageView").hide();
			}
		});
	});
	
	// courseView를 보는 사용자가 팔로우를 한 사용자인가?
	function followCheck(){
		var userNumber = ${courseVO.userNumber};
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
	
	$('#change').on("click", function(evt){
		var url = "/course/view/detail?courseNumber=" + ${courseVO.courseNumber};
		window.open(url, "startpop", "width=1030, height=800");
	});
	
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
						alert("mypage에서 확인하실 수 있습니다.");
					}
				}
			});
		}
	});
</script>

</body>
</html>