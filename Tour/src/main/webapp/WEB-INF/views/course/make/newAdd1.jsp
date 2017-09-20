<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">
<title>코스 생성중 - 1단계</title>
</head>
<style>
</style>
<body>
	<!-- header 1,2 -->
	<div></div>
	<!-- /course/make/add1 -->
	<div class="container" style="padding:10px; border:2px solid #F5F5F5;">
		<!-- 지역 선택 -->
		<div>
			<!-- 소개 -->
			<div>
				<h1>첫 번째 단계 : 지역 선택 단계입니다.</h1>
				<p>여행하고 싶은 지역을 선택해주세요.</p>
			</div>			
			<!-- 선택 -->
			<div style="padding:10px; border:2px solid #F5F5F5;">
				<!-- 지역 선택 (탭) -->
				<ul class="nav nav-tabs" id="myTab" style="padding:10px;"></ul>
				<!-- 시군구 선택 (체크-버튼) -->
				<div class="tab-content" id="checkboxes" style="padding:10px"></div>
			</div>		
		</div>	
		<!-- 날짜 선택 -->
		<div style="padding:10px;">
			<!-- 소개 -->
			<div id="dsIntro"></div>
			<!-- 선택 -->
			<div id="dsList" style="margin-top: 10px;"></div>		
		</div>	
		<!-- 다음 단계 이동 -->
		<div style="padding:10px;">
			<button type="button" class="btn btn-default pull-right" id="nextB">다음</button>
		</div>
	</div>		
	<!-- footer -->
	<div></div>
<script>
</script>
</body>
</html>