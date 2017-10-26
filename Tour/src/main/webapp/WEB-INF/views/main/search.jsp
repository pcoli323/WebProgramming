<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<style type="text/css">
	body{
	height:100%;
	background-color:lavenderblush !important;
	}
	.content{
	position:relative;
	width:65%;
	height:100%;
	margin:auto;
	margin-top:30px;
	}
	.searchView{
	width:100%;
	height:150px;
	border:1px solid #ff9900;
    padding:20px;
	background-color:white;
    }
    .chooseSearchType{
    height:20%;
    }
    .searchKeyword{
    height:80%;
    padding:20px 15px 20px 15px;
    display:flex;
    }
    .inputKeyword{
    width:90%;
    display:inline-block;
    }
    .input{
    width:100%;
    height:100%;
    font-size:150%;
    outline:0;
    padding:10px;
    }
    .searchButtonField{
    width:10%;
    display:inline-block;
    }
    .searchButton{
    width:100%;
    height:100%;
    background-color:#ff9900 !important;
    border-top-left-radius:0px !important;
    border-bottom-left-radius:0px !important;
    color:white !important;
    outline:0 !important;
    }
</style>

<head>
	<meta charset="UTF-8">
	<title>search</title>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>

<%@include file="../include/navbar.jsp" %>

<body>
<div class="content">
	<div class="searchView">
		<!-- 검색 종류 선택 -->
		<div class="chooseSearchType">
			<span style="margin:20px;">
				<input type="radio" name="searchType" id="region" value="region" checked="checked">
				<label for="region">지역</label>
			</span>
			<span>
				<input type="radio" name="searchType" id="user" value="user">
				<label for="user">사용자</label>
			</span>
		</div><!-- /chooseSearchType -->
		
		<!-- 검색하기 -->
		<div class="searchKeyword">
			<div class="inputKeyword">
				<input type="text" name="keyword" id="keywordInput" class="input" autofocus="autofocus">
			</div>
			<div class="searchButtonField">
				<button class="btn searchButton">
					<span class="glyphicon glyphicon-search" style="font-size:30px;"></span>
				</button>
			</div>
		</div><!-- /searchKeyword -->
	</div><!-- /searchView -->
	<div class="searchResult">
	</div>
</div><!-- /content -->

<script>
	var loginCheck;
	var loginUserNumber;
	$(document).ready(function(){
		// 변수 초기화
		loginCheck = ${loginCheck};
		if(loginCheck == false){
			loginUserNumber = null;
		}
		else{
			loginUserNumber = ${loginUser.userNumber};
		}
		$("#keywordInput").keyup(function(event) {
		    if (event.keyCode === 13) {
		        $(".searchButton").click();
		    }
		});
	});
</script>

<script>
	$('.searchButton').on("click", function(){
		var searchType = $("input[name=searchType]:checked").val(); 
		console.log(searchType);
		var keyword = $("#keywordInput").val();
		console.log(keyword);
		$.ajax({
			type:'get',
			url:'/search/keyword?searchType='+searchType+"&keyword="+keyword,
			success:function(result){
				console.log(result);
				if(result.length != 0){
					var mypage = false;
					var position = ".searchResult";
					simpleView(result, mypage, position);
				}
				else{
					var str = "<div style='padding:20px;font-size:150%;'>검색 결과가 없습니다.</div>";
					$('.searchResult').html(str);
				}
			}
		});
	});
</script>
<%@include file="../course/view/simple.jsp" %>
</body>
</html>