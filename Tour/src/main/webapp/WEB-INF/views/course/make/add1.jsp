<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
  <title>Course Making...</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>  
<style>
</style>
</head>
<body>
	<!-- 지역 검색 창 -->
	<div class="container">
		<h1>첫번째 단계 : 지역 선택 단계입니다.</h1>
  		<p>여행하기 원하는 지역을 검색하여 추가해주세요.</p>
  		<br>
    	<div class="input-group">
      		<input type="text" id="searchRegion" class="form-control" placeholder="Search" name="search">
      		<div class="input-group-btn">
        		<button id="searchButton" class="btn btn-default"><i class="glyphicon glyphicon-search"></i></button>
      		</div>
    	</div>
    	<hr>
    	<p> 추가된 지역 : </p>
      	<div id="regions">
			<!-- <p id="regions"></p>-->
      	</div>
      	<hr>
	</div>
	<!-- 다음 단계 이동 버튼 -->
	<div class="container">
		<div style="padding:10px;">
  			<form action="/course/make/add2" method="get">
  				<button type="submit" class="btn btn-primary pull-right"> 완료 </button>
  			</form>
  		</div>
	</div>
<script>
$("#searchButton").click(function(){
	var keyword = document.getElementById("searchRegion").value;
	var url="http://api.visitkorea.or.kr/openapi/service/rest/KorService/searchKeyword?serviceKey=DHcqBxhjFPm%2FJrVtRuH0NExGuA9SrbZWeSAm6Dklg0o69DTFZh1rfrb3OFWZ7qt%2F9k4dxzTbPMax5VQvU0Tocw%3D%3D&MobileOS=ETC&MobileApp=Tour&keyword="+keyword+"&_type=json";  
    $.ajax({
        url:url,
        dataType: "json",
        success:function(returnedData){
        	var str = keyword + ":" + returnedData.response.body.items.item[0].areacode;
        	//console.log(returnedData);
        	//var tag = <p> </p> $("region").append(tag);
        	var pp = document.createElement("p");
    		var node = document.createTextNode(str);
    		pp.id = 'region'+'1';
    		pp.appendChild(node);
    		var element = document.getElementById("regions");
    		element.appendChild(pp);
    		
        	//document.getElementById("regions").innerHTML = keyword + ":" + returnedData.response.body.items.item[0].areacode;
    		//alert('${lists[0].title}');
        }
    });  
      
});
</script>
</body>
</html>