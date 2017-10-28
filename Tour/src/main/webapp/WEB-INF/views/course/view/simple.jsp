<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<style>
	@import url(http://fonts.googleapis.com/earlyaccess/jejugothic.css);
	@import url(http://fonts.googleapis.com/earlyaccess/nanumpenscript.css);
	
	.viewContent{
	position:relative;
	width:100%;
	margin-top:20px;
	border: 1px solid #ff9900;
	background-color: peachpuff;
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
  	background-color:rgba(0,0,0,0);
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
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
	<script src="https://cdnjs.cloudflare.com/ajax/libs/handlebars.js/3.0.1/handlebars.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>
<!-- simpleView를 부르는 함수 -->
<script>
	function simpleView(courseList, mypage, position){
		$.ajax({
			type:'post',
			url:'/course/view/simple_2',
			headers:{
				"Content-Type": "application/json",
				"X-HTTP-Method-Override": "POST"
			},
			dataType:'text',
			data: JSON.stringify({
				list:courseList
			}),
			success:function(data){
				var list = JSON.parse(data);
				var templateData = {list:list, mypage:mypage};
				
				var source = $("#template").html();
				var template = Handlebars.compile(source);
				$(position).html(template(templateData));
				console.log(templateData);
				console.log(list.length);
				console.log(list);
				for(var i=0; i<list.length; i++){
					var courseNumber = list[i].courseNumber;
					var following = list[i].userNumber;
					// view 초기화
					followCheck(courseNumber, following);
					likeCheck(courseNumber);
					likeCount(courseNumber);
					replyCount(courseNumber);
				}
			}
		});
	}
</script>

<script id="template" type="tex/x-handlerbars-template">
{{#each list}}
<div class="viewContent">
	<div class="courseView" style="margin-bottom:10px;">
		{{#if ../mypage}}
			<div class="uploadButton" style="text-align:right; margin-top:-30px;">
				<button type=button class="btn btn-default modify" id="modify-{{courseNumber}}">게시 수정</button>
				<button type=button class="btn btn-default deletePost" id="deletePost-{{courseNumber}}">게시 취소</button>
			</div><!-- /uploadButton -->
		{{/if}}
		<div class="courseView-header">
			<h2 class="courseName" id="name-{{courseNumber}}" style="text-align:center;font-family:'Jeju Gothic';">{{courseName}}</h2>
		</div><!-- /courseView-header -->
        
        <div class="courseView-body">
        	<div class="courseMaker" style="text-align:left;font-family:'Jeju Gothic';">
        		<h5>
					{{#followButton userNumber courseNumber}}
        			{{/followButton}}
        			{{userName}}
        		</h5>
        	</div>
        	<div class="representatives" style="text-align:center">
				{{representativeList representatives courseNumber}}
        	</div><!-- /representatives -->
       	</div><!-- /courseView-body -->
       	
        <div class="courseView-footer" style="text-align:right">
			<button type="button" class="symbolButton like" id="like-{{courseNumber}}">
				<span class="glyphicon symbol" id="like_symbol-{{courseNumber}}" style="color:#ff0000"></span>
				<small id="likeNum-{{courseNumber}}"></small>
			</button>
			<button type="button" class="symbolButton reply" id="reply-{{courseNumber}}" style="cursor:default">
				<span class="glyphicon glyphicon-comment symbol"></span>
				<small id="replyNum-{{courseNumber}}"></small>
			</button>
			<button type="button" class="symbolButton change" id="change-{{courseNumber}}">
				<span class="glyphicon glyphicon-search symbol"></span>
			</button>
			<button type="button" class="symbolButton getCourse" id="getCourse-{{courseNumber}}">
				<span class="glyphicon glyphicon-share-alt symbol"></span>
			</button>
        </div><!-- /courseView-footer -->
       	
	</div><!-- /courseView -->
	<!-- mouseOver시 보여지는 big 이미지-->
	<div class="mouseOverImageView" id="mouseOverImageView-{{courseNumber}}">
		<button type="button" class="btn btn-default btn-xs pull-right removeImageBtn" id="removeImageBtn-{{courseNumber}}" style="outline:0">
			<i class="fa fa-fw fa-remove"></i></button>
		<div class="mouseOverImageContent" id="mouseOverImageContent-{{courseNumber}}">
		</div><!-- /mouseOverImageContent -->
	</div><!-- /mouseOverImageView -->
</div><!-- /content -->
{{/each}}
</script>
<!-- Handlebars Helper -->
<script>
	Handlebars.registerHelper("representativeList", function(representatives, courseNumber){
		var str = '';
		str += "<table style='display:inline-block;'><tr>";
		for(var i=0; i<representatives.length; i++){
			var representative = representatives[i];
			str += "<td class='representativeImageTable'>";
			if(i%2 == 0){
				if(representative.gotoImageThum != null){
					str += "<img src='"+representative.gotoImageThum+"' class='representativeImage thumImage' id='img-"+representative.gotoNumber+"-"+courseNumber+"'><br>";
				}
				else if(representative.gotoImageReal != null){
					str += "<img src='"+representative.gotoImageReal+"' class='representativeImage realImage' id='img-"+representative.gotoNumber+"-"+courseNumber+"'><br>";
				}
				else{
					str += "<div class='representativeImage noImage' style='background-color:lightGray;text-align:center;margin:auto;'>"
							+ "<div style='position:relative;font-size:80%;top:26%;'>사진이<br>없습니다</div></div>";
				}
				str += representative.gotoTitle;
			}
			str += "</td>";
		}
		str += "</tr><tr>";
		for(var i=0; i<representatives.length; i++){
			var representative = representatives[i];
			str += "<td class='representativeImageTable'>";
			if(i%2 != 0){
				if(representative.gotoImageThum != null){
					str += "<img src='"+representative.gotoImageThum+"' class='representativeImage thumImage' id='img-"+representative.gotoNumber+"-"+courseNumber+"'><br>";
				}
				else if(representative.gotoImageReal != null){
					str += "<img src='"+representative.gotoImageReal+"' class='representativeImage realImage' id='img-"+representative.gotoNumber+"-"+courseNumber+"'><br>";
				}
				else{
					str += "<div class='representativeImage noImage' style='background-color:lightGray;text-align:center;margin:auto;'>"
							+ "<div style='position:relative;font-size:80%;top:26%;'>사진이<br>없습니다</div></div>";
				}
				str += representative.gotoTitle;
			}
			str += "</td>";
		}
		str += "</tr></table>";
		
		return new Handlebars.SafeString(str);
	});
	Handlebars.registerHelper("followButton", function(courseMaker, courseNumber){
		var str = '';
		if(courseMaker != loginUserNumber){
			str += "<button type='button' class='symbolButton follow' id='follow-"+courseMaker+"-"+courseNumber+"'></button>";
		}
		return new Handlebars.SafeString(str);
	});
</script>
<script>
	// 대표이미지 크게 보기
	$(document).on("mouseover", '.representativeImage', function(){
		if($(this).hasClass("noImage") == false){
			var str = $(this).attr("style");
			
			str = str + ";cursor:pointer;";
			$(this).attr("style", str);
		}
	});
	$(document).on("mouseout", '.representativeImage', function(){
		if($(this).hasClass("noImage") == false){
			var str = $(this).attr("style").split(';');
			
			$(this).attr("style", str[0]);
		}
	});
	$(document).on("click", '.representativeImage', function(){
		var imgSrc = "";
		var imgHtml;
		
		if($(this).hasClass("noImage") == false){
			var idStr = $(this).attr('id').split('-');
			var courseNumber = idStr[2];
			
			if ($(this).hasClass("realImage") == true){
				imgSrc = $(this).attr("src");
				imgHtml = "<img src=" + imgSrc + " class='mouseOverImage'>";
				$("#mouseOverImageContent-"+courseNumber).html(imgHtml);
				$("#mouseOverImageView-"+courseNumber).show();
			}
			else{
				var gotoNumber = idStr[1];
				
				$.ajax({
					type:'get',
					url:'/getGotoRealImage?gotoNumber=' + gotoNumber,
					success:function(realImage){
						imgSrc = realImage;
						imgHtml = "<img src=" + imgSrc + " class='mouseOverImage'>";
						$("#mouseOverImageContent-"+courseNumber).html(imgHtml);
						$("#mouseOverImageView-"+courseNumber).show();
					}
				});
			}
		}
	});
	$(document).on("click", '.removeImageBtn', function(){
		var idStr = $(this).attr('id').split('-');
		var courseNumber = idStr[1];
		$("#mouseOverImageView-"+courseNumber).hide();
	});
	
	// courseView를 보는 사용자가 팔로우를 한 사용자인가?
	function followCheck(courseNumber, following){
		if(loginCheck == true){
			if(loginUserNumber != following){
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
							followToggle("non-follow", following, courseNumber);
						}
						else{
							followToggle("follow", following, courseNumber);
						}
					}
				});
			}
		}
		else{
			followToggle("non-follow", following, courseNumber);
		}
	}
	
	// like 수
	function likeCount(courseNumber){
		$.ajax({
			type:'get',
			url:'/like/count/'+courseNumber,
			headers: { "Content-Type": "application/json" },
			success:function(result){
				$('#likeNum-'+courseNumber).html(result);
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
	function replyCount(courseNumber){
		$.ajax({
			type:'get',
			url:'/replise/count/'+courseNumber,
			headers: { "Content-Type": "application/json" },
			success:function(result){
				$('#replyNum-'+courseNumber).html(result);
			}
		});
	}
</script>
<!-- symbol인 버튼 눌렀을 때 -->
<script>
	$(document).on("click", '.follow', function(){
		if(loginCheck == false){
			alert("로그인 후 사용하실 수 있습니다.");
		}
		else{
			var idStr = $(this).attr('id').split('-');
			var following = idStr[1];
			var courseNumber = idStr[2];
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
							followToggle("follow", following, courseNumber);
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
							followToggle("non-follow", following, courseNumber);
						}
					}
				});
			}
		}
	});
	function followToggle(status, following, courseNumber){
		// status는 원하는 상태
		var str = "";
		if(status == "non-follow"){
			str = "<i class='material-icons' style='color:#d21a0b'>person_add</i>";
			$('#follow-'+following+'-'+courseNumber).removeClass("active");
			$('#follow-'+following+'-'+courseNumber).html(str);
		}
		else{
			str = "<i class='material-icons' style='color:#d21a0b'>people</i>";
			$('#follow-'+following+'-'+courseNumber).addClass("active");
			$('#follow-'+following+'-'+courseNumber).html(str);
		}
	}
	
	$(document).on("click", '.like', function(){
		console.log(loginUserNumber);
		console.log(loginCheck);
		if(loginCheck == false){
			alert("로그인 후 사용하실 수 있습니다.");
		}
		else{
			var idStr = $(this).attr('id').split('-');
			var courseNumber = idStr[1];
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
							likeCount(courseNumber);
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
							likeCount(courseNumber);
						}
					}
				});
			}
		}
	});
	
	function likeToggle(status, courseNumber){
		// status는 원하는 상태
		if(status == "non-active"){
			$('#like-'+courseNumber).removeClass("active");
			$('#like_symbol-'+courseNumber).removeClass("glyphicon-heart").addClass("glyphicon-heart-empty");
		}
		else{
			$('#like-'+courseNumber).addClass("active");
			$('#like_symbol-'+courseNumber).removeClass("glyphicon-heart-empty").addClass("glyphicon-heart");
		}
	}
	
	$(document).on("click", '.change', function(){
		var idStr = $(this).attr('id').split('-');
		var courseNumber = idStr[1];
		
		var url = "/course/view/detail?courseNumber=" + courseNumber;
		window.open(url, "startpop", "width=1030, height=800");
	});
	
	$(document).on("click", '.getCourse', function(){
		var idStr = $(this).attr('id').split('-');
		var courseNumber = idStr[1];
		
		if(loginCheck == false){
			alert("로그인 후 사용하실 수 있습니다.");
		}
		else{
			var courseName = $('#name-'+courseNumber).text();
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
	
	// mypage에서 사용하는 게시를 위한 버튼
	$(document).on("click", '.modify', function(){
		var idStr = $(this).attr('id').split('-');
		var courseNumber = idStr[1];
		
		location.href = "/mypage/upload?courseNumber="+courseNumber;
	});
	$(document).on("click", '.deletePost', function(){
		var idStr = $(this).attr('id').split('-');
		var courseNumber = idStr[1];
		
		$.ajax({
			type:'post',
			url:'/uploadMypage/delete/' + courseNumber,
			headers: {
				"Content-Type": "application/json",
				"X-HTTP-Method-Override": "post"
			},
			success:function(result){
				location.href = "/uploadMypage";
			}
		});
	});
</script>

</body>
</html>