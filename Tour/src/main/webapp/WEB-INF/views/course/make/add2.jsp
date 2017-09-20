<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 
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
		<!-- 여행지 선택 부분 -->
		<div>
			<!-- 지역 선택 단계를 소개해주는 부분 -->
			<div>
				<h1>두 번째 단계 : 여행지 선택 단계입니다.</h1>
				<p>여행지를 선택해 추가해주세요.</p>
			</div>
			<!-- 여행지를 보여주는 부분 -->
			<div style="padding:10px; border:2px solid #F5F5F5;">
				<!-- 지역 선택 부분 (탭) -->
				<ul class="nav nav-tabs" id="myTab" role="tablist" style="padding:10px;">
					<li class="nav-item">
    					<a class="nav-link active" data-toggle="tab" href="#${selectedAreaList[0].areacode}" role="tab">${selectedAreaList[0].areaname}</a>
    				</li>
					<c:forEach var="list" items="${selectedAreaList}" begin="1">
						<li class="nav-item">
    						<a class="nav-link" data-toggle="tab" href="#${list.areacode}" role="tab">${list.areaname}</a>
  						</li>
					</c:forEach>
				</ul>
				<!-- 관광타입 선택 부분 (탭) -->
				<div class="tab-content" id="checkboxes" style="padding:10px">
					<div class="tab-pane active" id="${selectedAreaList[0].areaCode}" role="tabpanel">
					
					
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary" id="B${areacodeList[0].areaCode}-0">
  								<input type="checkbox" autocomplete="off" id="${areacodeList[0].areaCode}-0" name="${areacodeList[0].areaName}"> 전체
  							</label>
  							<c:if test="${areacodeList[0].sAreaNum > 1}">
								<c:forEach var="slist" items="${areacodeList[0].sAreaList}">
  									<label class="btn btn-primary" id="B${areacodeList[0].areaCode}-${slist.sAreaCode}">
  										<input type="checkbox" autocomplete="off" id="${areacodeList[0].areaCode}-${slist.sAreaCode}" name="${slist.sAreaName}"> ${slist.sAreaName}
  									</label>
  								</c:forEach>
  							</c:if>
						</div>
						
						
					</div>
					
					<c:forEach var="list" items="${selectedAreaList}" begin="1">
						<div class="tab-pane" id="${selectedAreaList.areaCode}" role="tabpanel">
						
						
							<div class="btn-group" data-toggle="buttons">
								<label class="btn btn-primary" id="B${list.areaCode}-0">
  									<input type="checkbox" autocomplete="off" id="${list.areaCode}-0"  name="${list.areaName}"> 전체
  								</label>
  								<c:if test="${list.sAreaNum > 1}">
								<c:forEach var="slist" items="${list.sAreaList}">
  									<label class="btn btn-primary" id="B${list.areaCode}-${slist.sAreaCode}">
  										<input type="checkbox" autocomplete="off" id="${list.areaCode}-${slist.sAreaCode}"  name="${slist.sAreaName}"> ${slist.sAreaName}
  									</label>
  								</c:forEach>
  								</c:if>
							</div>
							
							
						</div>
					</c:forEach>
				</div>
				<!-- 여행지 선택 부분 -->
			</div>
		</div>
		<!-- 다음 단계 이동 부분 -->
		<div>
			<ul class="pager">
  				<li><a href="/course/make/modify" id="next">다음</a></li>
			</ul>
		</div>
	</div>
	<!-- footer 추가 부분 -->
</body>
</html>
