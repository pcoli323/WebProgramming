<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
 
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body> 
	<!-- header 1,2 추가 부분 -->
	<!-- /course/make/add2 부분  -->
	<div class="container" style="padding:10px; border:2px solid #F5F5F5;">
		<!-- 여행 코스 선택 부분 -->
			<!-- 지역 선택 부분 -->
			<!-- 카테고리 선택 부분 -->
			<!-- 여행 코스 선택 부분 -->
		<!-- 다음 단계 이동 부분 -->
		<div>
			<ul class="pager">
  				<li><a href="/course/make/modify" id="next">다음</a></li>
			</ul>
		</div>
	</div>
	<!-- footer 추가 부분 -->




<c:forEach var="list" items="${lists}">
	${list.title}
	<img src="${list.firstimage}">
</c:forEach>


<div class="container">
<div>
  <form action="/course/make/modify" method="get">
  	<button type="submit" class="btn btn-primary btn-block"> Next </button>
  </form>
</div>
</div>

</body>
</html>
