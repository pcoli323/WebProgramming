<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html>
<head>
	<title>코스 생성중 - 2단계</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<style>
</style>
<body>
	<!-- header 1,2 -->
	<div></div>
	<!-- /course/make/add2 -->
	<div class="container" style="padding:10px; border:2px solid #F5F5F5;">
		<!-- 소개 -->
		<div>
			<h1>두 번째 단계 : 여행지 선택 단계입니다.</h1>
			<p>여행지를 선택해주세요.</p>
		</div>	
		<!-- 선택 -->
		<div style="padding:10px; border:2px solid #F5F5F5;">
			<!-- 지역 선택 (탭) -->
			<ul class="nav nav-tabs" id="myTab" role="tablist" style="padding:10px;"></ul>
			<!-- 여행지 선택 (체크박스) -->
			<div class="tab-content" id="checkboxes" style="padding:10px"></div>
		</div>
		<!-- 선택 출력 -->
		<div style="padding:10px;">		
			<!-- 소개 -->
			<div id="sIntro"></div>
			<!-- 출력 -->
			<div id="sList" style="margin-top: 10px;"></div>		
		</div>
		<!-- 다음 단계 이동 -->
		<div style="padding:10px;">
			<button type="button" class="btn btn-default pull-right" id="next">다음</button>
		</div>
	</div>
	<!-- footer -->
	<div></div>
</body>
<script>
</script>
</html>