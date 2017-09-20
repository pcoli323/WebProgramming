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
	<!-- header 1,2 �߰� �κ� -->
	<!-- /course/make/add2 �κ�  -->
	<div class="container" style="padding:10px; border:2px solid #F5F5F5;">
		<!-- ������ ���� �κ� -->
		<div>
			<!-- ���� ���� �ܰ踦 �Ұ����ִ� �κ� -->
			<div>
				<h1>�� ��° �ܰ� : ������ ���� �ܰ��Դϴ�.</h1>
				<p>�������� ������ �߰����ּ���.</p>
			</div>
			<!-- �������� �����ִ� �κ� -->
			<div style="padding:10px; border:2px solid #F5F5F5;">
				<!-- ���� ���� �κ� (��) -->
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
				<!-- ����Ÿ�� ���� �κ� (��) -->
				<div class="tab-content" id="checkboxes" style="padding:10px">
					<div class="tab-pane active" id="${selectedAreaList[0].areaCode}" role="tabpanel">
					
					
						<div class="btn-group" data-toggle="buttons">
							<label class="btn btn-primary" id="B${areacodeList[0].areaCode}-0">
  								<input type="checkbox" autocomplete="off" id="${areacodeList[0].areaCode}-0" name="${areacodeList[0].areaName}"> ��ü
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
  									<input type="checkbox" autocomplete="off" id="${list.areaCode}-0"  name="${list.areaName}"> ��ü
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
				<!-- ������ ���� �κ� -->
			</div>
		</div>
		<!-- ���� �ܰ� �̵� �κ� -->
		<div>
			<ul class="pager">
  				<li><a href="/course/make/modify" id="next">����</a></li>
			</ul>
		</div>
	</div>
	<!-- footer �߰� �κ� -->
</body>
</html>
