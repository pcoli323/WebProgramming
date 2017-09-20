<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<style type="text/css">
	html, body{overflow-x:hidden;}
	
	table{
	width:170px;
	height:250px;
	}
	table th{
	padding:10px;
	}
	table td{
	padding:20px;
	}
	
	.courseView{
	width:1010px;
	resize:none;
	padding:50px;
	}
	.planTables{
	background-color:#F2F2F2;
	padding:20px;
	}
	.planTable{
	background-color:#F2F2F2;
	width:20%;
	display:inline-block;
	margin:20px;
	}
	.story{
	border:1px solid gold;
	padding:20px;
	line-height:200%;
	}
	.symbol{
	font-size:30px;
	color:#000000;
	}
	.media{
	border-top:1px solid #FFCCCC;
	padding:20px;
	padding-bottom:0px;
	}
</style>

<head>
	<meta charset="UTF-8">
	<title>courseView Detail</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link href="https://fonts.googleapis.com/icon?family=Material+Icons" rel="stylesheet">
</head>
<body>

<div class="content">
	<div class="courseView">
	
		<div class="courseView-header">
			<h2 class="courseName" style="text-align:center">
				${courseVO.courseName}
			</h2>
		</div><!-- /courseView-header -->
        
        <div class="courseView-body">
        	<div class="courseMaker" style="text-align:left">
        		<h5>
        			<button type="button" class="symbolButton" id="follow"></button>
        			${userVO.userName}
        		</h5>
        	</div><!-- /courseMaker -->
        	
       		<div class="planTables">
        		<c:forEach var="date" items="${plan.keySet()}">
        			<div class="planTable">
        				<table style="background-color:#ffff99">
        					<tr class="dtaeField" >
        						<th style="text-align:center;height:30px;background-color:#ffff80">${date}</th>
        					</tr>
        					<tr class="gotoField">
        						<td style="text-align:center">
        							<c:set var="gotoNameList" value="${plan.get(date)}"></c:set>
        							<c:forEach var="gotoName" items="${gotoNameList}">
        								<i>${gotoName}</i><br><br>
        							</c:forEach>
        						</td>
        					</tr>
        				</table>
        			</div>
        		</c:forEach>
        	</div><!-- /planTable -->
        	
        	<div class="map">
        		지도를 입력해주세요
        	</div>
        	
        	<div class="story">
        		${courseVO.story}
        	</div>
        			
        </div><!-- /courseView-body -->
        		
        <div class="courseView-footer" style="text-align:right; clear:left">
        	
		</div><!-- /courseView-footer -->
		
        
	</div><!-- /courseView -->
</div><!-- /content -->

<script>
	$(document).ready(function(){
		
	});
	
	var courseNumber = ${courseVO.courseNumber};
	var loginUserNumber = ${login.userNumber};
	var following = ${userVO.userNumber};
	
	
</script>

</body>
</html>