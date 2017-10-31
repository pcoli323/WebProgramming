<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<style type="text/css">
	html, body{
	min-height:100%;
	}
	.content{
	position:relative;
	width:65%;
	min-height:600px;
	margin:auto;
	margin-top:30px;
	}
	.searchView{
	width:100%;
	height:150px;
	border:1px solid #3F2018;
    padding:20px;
	background-color:white;
    }
    .chooseSearchType{
    height:20%;
    padding-left:15px;
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
    background-color:#3F2018 !important;
    border-top-left-radius:0px !important;
    border-bottom-left-radius:0px !important;
    color:white !important;
    outline:0 !important;
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

<head>
	<meta charset="UTF-8">
	<title>search</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>

<%@include file="../include/navbar.jsp" %>
<body id="home">
<div class="content">
	<div class="searchView">
		<!-- 검색 종류 선택 -->
		<div class="chooseSearchType">
			<button class="btn btn-warning" id="all" style="outline:0;background-color:#3F2018;border-color:#371C15;">모든코스보기</button>
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
	<div class='text-center'>
		<ul id="pagination" class="pagination pagination-sm no-margin "></ul>
	</div>
</div><!-- /content -->

<script>
	var loginCheck;
	var loginUserNumber;
	var searchResult = [];
	var dataNumPerPage = 10;
	var pageNum = 5;
	
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
		    if (event.keyCode == 13) {
		        $(".searchButton").click();
		    }
		});
		
		// 어디에서 들어왔는지에 따른 메인 뷰 처리
		var where = ${where};
		if(where == 'home'){
			$('#all').click();
		}
		else if (where == 'follow'){
			$('#user').click();
			document.getElementById('keywordInput').value= ${keyword};
			search("user", ${keyword});
		}
	});
</script>

<script>
	// search
	function search(searchType, keyword){
		$.ajax({
			type:'get',
			url:'/search/keyword?searchType='+searchType+"&keyword="+keyword,
			success:function(result){
				searchResult = result;
				if(result.length != 0){
					searchResult = result;
					printResult(1);
					$('.pagination').show();
				}
				else{
					var str = "<div style='padding:20px;font-size:150%;'>검색 결과가 없습니다.</div>";
					$('.searchResult').html(str);
					$('.pagination').hide();
				}
			}
		});
	}
	
	// click 처리
	$('#all').on("click", function(){
		var searchType = "all";
		var keyword = "";
		search(searchType, keyword);
	});
	$('.searchButton').on("click", function(){
		var searchType = $("input[name=searchType]:checked").val(); 
		var keyword = $("#keywordInput").val();
		search(searchType, keyword);
		
	});
	
	// 결과 paging하여 보여주기
	function printResult(page){
		var endIndex = page * dataNumPerPage - 1;
		var startIndex = endIndex - dataNumPerPage + 1;
		
		if(endIndex >= searchResult.length){
			endIndex = searchResult.length - 1;
		}
		
		// 결과 코스
		var result = searchResult.slice(startIndex, endIndex + 1);
		var mypage = false;
		var position = ".searchResult";
		simpleView(result, mypage, position);
		
		// paging
		var pageMaker = makePageMaker(page);
		printPaging(page, pageMaker);
	}
	// paging을 위한 pageMaker
	function makePageMaker(page){
		var pageMaker = new Map();
		var realEndPage = Math.ceil(searchResult.length/dataNumPerPage);
		
		var endPage = Math.ceil(page/pageNum) * pageNum;
		var startPage = endPage - pageNum + 1;
		
		if(endPage > realEndPage){
			endPage = realEndPage;
		}
		var prev = startPage == 1 ? false : true;
		var next = endPage == realEndPage ? false : true;
		
		pageMaker.set("startPage", startPage);
		pageMaker.set("endPage", endPage);
		pageMaker.set("prev", prev);
		pageMaker.set("next", next);
		
		return pageMaker;
	}
	// paging 출력
	function printPaging(page, pageMaker){
		var str = "";
		
		if(pageMaker.get("prev")){
			str += "<li><a href='"+(pageMaker.get("startPage")-1)+"'> << </a></li>";
		}
		
		for(var i=pageMaker.get("startPage"); i<=pageMaker.get("endPage"); i++){
			var strClass = page == i?'class=active':'';
			str += "<li "+strClass+"><a href='"+i+"'>"+i+"</a></li>";
		}
		
		if(pageMaker.get("next")){
			str += "<li><a href='"+(pageMaker.get("endPage")+1)+"'> >> </a></li>";
		}
		$('.pagination').html(str);
	}
	// paging 클릭
	$(".pagination").on("click", "li a", function(event){
		
		event.preventDefault();
		page = $(this).attr("href");
		printResult(page);
	});
</script>
<%@include file="../course/view/simple.jsp" %>
<%@include file="../include/footer.jsp" %>
</body>
</html>