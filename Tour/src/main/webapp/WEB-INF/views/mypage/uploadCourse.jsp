<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<title>마이페이지</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<html>
<head>
<style>
	@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);
	@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);
	
	.content{
	position:relative;
	width:65%;
	margin-left:320px;
	}
	.courseView{
	padding:50px;
	padding-bottom:0px;
	margin-top: 15px;
	background-color: #FFFFFF;
	}
	.symbolButton{
  	font-size: 14px;
  	text-align: center;
  	vertical-align: middle;
  	border: 1px solid transparent;
  	background-color: rgba(0,0,0,0);
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
    #mouseOverImageView{
    height:300px;
    text-align:center;
    background-color:black;
    margin:auto;
    display:none;
    }
    .mouseOverImageContent{
    height:100%;
    width:50%;
    background-color:black;
    display:inline-block;
    vertical-align:middle;
    }
    .mouseOverImage{
    max-width:100%;
    height:auto;
    max-height:100%;
    position: relative;
    }
	.bg-grey {
		background-color: #f6f6f6;
	}
	#lastImageView {
		height:120px;
		text-align:center;
		color:gray;
	}
	.btn {
		height:35px;
		margin-top:-50px;
	}
</style>
</head>
<body class="bg-grey">
<script>
var courseNameArr= ${courseName };
var courseNumByName = ${courseNumber };
</script>
<!-- header -->
<%@include file="../include/navbar.jsp" %>

<!-- sidenav -->
<%@include file="../include/sidenav.jsp" %>

<div class="content">

	<c:set var="courseNumberCount" value="0"></c:set>
	<c:forEach items="${representatives}" var="Allrepresentative">
        
	<div class="courseView">
		<div class="courseView-header" style="text-align:right;">
			<button type=button class="btn btn-default modify">게시 수정</button>
			<button type=button class="btn btn-default delete">게시 취소</button>
			<h2 class="courseName" style="text-align:center;font-family:'Jeju Gothic';">
				${courseVO[courseNumberCount].courseName}
			</h2>
		</div><!-- /courseView-header -->
    
	<div class="courseView-body">
		<div class="representatives" style="text-align:center">
			<!-- <div id="showImage" style="position:absolute; left:10px"></div> -->
				<table style="display:inline-block;">
					<tr>
						<c:forEach items="${Allrepresentative.value}" var="representative" varStatus="status">
							<c:if test="${status.index % 2 == 0}">
								<td class="representativeImageTable">
									<c:choose>
										<c:when test="${representative.gotoImageThum ne null}">
											<img src="${representative.gotoImageThum}" class="representativeImage thumImage" id="${representative.gotoNumber}+${courseNumberCount}"><br>
										</c:when>
									<c:otherwise>
										<c:choose>
			    							<c:when test="${representative.gotoImageReal ne null}">
			    								<img src="${representative.gotoImageReal}" class="representativeImage realImage" id="${representative.gotoNumber}+${courseNumberCount}"><br>
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
	   				<c:forEach items="${Allrepresentative.value}" var="representative" varStatus="status">
	  					<c:if test="${status.index % 2 == 0}">
	   						<td class="representativeImageTable"></td>
	  					</c:if>
	   					<c:if test="${status.index % 2 != 0}">
	   						<td class="representativeImageTable">
	   							<c:choose>
	   								<c:when test="${representative.gotoImageThum ne null}">
	   									<img src="${representative.gotoImageThum}" class="representativeImage thumImage" id="${representative.gotoNumber}+${courseNumberCount}"><br>
	   								</c:when>
	   								<c:otherwise>
	   									<c:choose>
	   										<c:when test="${representative.gotoImageReal ne null}">
	   											<img src="${representative.gotoImageReal}" class="representativeImage realImage" id="${representative.gotoNumber}+${courseNumberCount}"><br>
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
		<button type="button" class="symbolButton like" id="${courseNumberCount }">
			<span class="glyphicon symbol like_symbol" id="like_symbol" style="color:#ff0000"></span>
			<small class="likeNum"></small>
		</button>
		<button type="button" class="symbolButton reply" id="${courseNumberCount }" style="cursor:default">
			<span class="glyphicon glyphicon-comment symbol"></span>
			<small class="replyNum"></small>
		</button>
		<button type="button" class="symbolButton change" id="${courseNumberCount }">
			<span class="glyphicon glyphicon-search symbol"></span>
		</button>
		<button type="button" class="symbolButton getCourse" id="${courseNumberCount }">
			<span class="glyphicon glyphicon-share-alt symbol"></span>
		</button>
	</div><!-- /courseView-footer -->
	       	
</div><!-- /courseView -->

<!-- mouseOver시 보여지는 big 이미지-->
<div id="mouseOverImageView" class="${courseNumberCount}">
	<div class="${courseNumberCount}">
	</div><!-- /mouseOverImageContent -->
</div><!-- /mouseOverImageView -->
				
<c:set var="courseNumberCount" value="${courseNumberCount + 1}"></c:set>
</c:forEach>

<div id="lastImageView">
<br><br><br><br><p>End</p>
</div>

</div>
<!-- footer -->
<%@include file="../include/footer.jsp" %>

<script>
	var loginCheck;
	var loginUserNumber;
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
		
		for(var i=0; i<courseNumByName.length; i++){
			var courseNumber = courseNumByName[i];
			following = ${userVO.userNumber};
			// view 초기화
			likeCheck(courseNumber);
			likeNumber(courseNumber);
			replyNumber(courseNumber);
		}
		// 마우스 올렸을 때 이미지 띄우기
		$(".representativeImage").mouseover(function(event){
			var imgSrc = "";
			var imgHtml;
			var thisID = $(this).attr("id");
			var split = thisID.split("+");
			var viewNumber = split[1];
			
			if($(this).hasClass("noImage") == false){
				if ($(this).hasClass("realImage") == true){
					imgSrc = $(this).attr("src");
					imgHtml = "<img src=" + imgSrc + " class='mouseOverImage'>";
					var className = "." + viewNumber;
					$(className).html(imgHtml);
					$(className).show();
				}
				else{
//					var gotoNumber = $(this).attr("id");
					var gotoNumber = split[0];
					$.ajax({
						type:'get',
						url:'/getGotoRealImage?gotoNumber=' + gotoNumber,
						success:function(realImage){
							imgSrc = realImage;
							imgHtml = "<img src=" + imgSrc + " class='mouseOverImage'>";
							var className = "." + viewNumber;
							$(className).html(imgHtml);
							$(className).show();
						}
					});
				}
			}
		});
		$(".representativeImage").mouseout(function(){
			var thisID = $(this).attr("id");
			var split = thisID.split("+");
			var viewNumber = split[1];
			if($(this).hasClass("noImage") == false){
				var className = "." + viewNumber;
				$(className).hide();
			}
		});
	});
	
	// 코스 인덱스 찾기
	function courseCount(courseNumber) {
		var count = 0;
		for(var i=0; i<courseNumByName.length; i++) {
			if(courseNumber == courseNumByName[i]) {
				count = i;
				break;
			}
		}
		return count;
	}

	// like 수
	function likeNumber(courseNumber){
		$.ajax({
			type:'get',
			url:'/like/count/'+courseNumber,
			headers: { "Content-Type": "application/json" },
			success:function(result){
				var count = courseCount(courseNumber);
				document.getElementsByClassName('likeNum')[count].innerHTML = result;
//				$('.likeNum').html(result);
			}
		});
	}
	// courseView를 보는 사용자가 종아요를 누른 사용자인가?
	function likeCheck(courseNumber){
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
						likeToggle("non-active", courseNumber);
					}
					else if(result == 1){
						// 사용자가 좋아요를 누른 상태
						likeToggle("ative", courseNumber);
					}
					else{
						console.log("check user number in like");
					}
				}
			});
		}
		else{
			likeToggle("non-active", courseNumber);
		}
	}
	
	// reply 수
	function replyNumber(courseNumber){
		$.ajax({
			type:'get',
			url:'/replise/count/'+courseNumber,
			headers: { "Content-Type": "application/json" },
			success:function(result){
				var count = courseCount(courseNumber);
				document.getElementsByClassName('replyNum')[count].innerHTML = result;
//				$('.replyNum').html(result);
			}
		});
	}
</script>
<!-- symbol인 버튼 눌렀을 때 -->
<script>
	$(document).on("click",'.like',function(){
		var courseNumber = courseNumByName[this.id];
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
							likeToggle("active", courseNumber);
							likeNumber(courseNumber);
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
							likeToggle("non-active", courseNumber);
							likeNumber(courseNumber);
						}
					}
				});
			}
		}
	});
	function likeToggle(status, courseNumber){
		
		var count = courseCount(courseNumber);
		/*
		<button type="button" class="symbolButton like" id="${courseNumberCount }">
			<span class="glyphicon symbol like_symbol" id="like_symbol" style="color:#ff0000"></span>
			<small class="likeNum"></small>
		</button>
		*/
		// status는 원하는 상태
		if(status == "non-active"){
			document.getElementsByClassName('like')[count].className = 'symbolButton like';
			document.getElementsByClassName('like_symbol')[count].className = 'glyphicon symbol like_symbol glyphicon-heart-empty';
//			$('.like').removeClass("active");
//			$('.like_symbol').removeClass("glyphicon-heart").addClass("glyphicon-heart-empty");
		}
		else{
			document.getElementsByClassName('like')[count].className = 'symbolButton like active';
			document.getElementsByClassName('like_symbol')[count].className = 'glyphicon symbol like_symbol glyphicon-heart';
//			$('.like').addClass("active");
//			$('.like_symbol').removeClass("glyphicon-heart-empty").addClass("glyphicon-heart");
		}
	}
	
	$('.change').on("click", function(evt){
		var changeCourseNumber = this.id;
		var url = "/course/view/detail?courseNumber=" + courseNumByName[changeCourseNumber];
		window.open(url, "startpop", "width=1030, height=800");
	});
	
	$('.getCourse').on("click", function(){
		if(loginCheck == false){
			alert("로그인 후 사용하실 수 있습니다.");
		}
		else{
			var courseName = courseNameArr[this.id];
			var courseNumber = courseNumByName[this.id];
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

	// 게시 수정 버튼 누를 시
	$('.modify').on("click", function(){
	});
	
	// 게시 삭제 버튼 누를 시
	$('.delete').on("click", fuction(){
		$.ajax({
			type:'post',
			url:'/uploadMypage/delete/'+courseNumber,
			headers: { "Content-Type": "application/json" },
			success:function(result){
				location.reload();
			}
		});
	});
</script>
</body>
</html>