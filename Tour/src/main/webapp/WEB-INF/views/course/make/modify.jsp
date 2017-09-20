<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>Bootstrap Example</title>
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <style>
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {height: 450px}
    
    /* Remove the navbar's default margin-bottom and rounded borders */ 
    .navbar {
      margin-bottom: 0;
      border-radius: 0;
      background-color: #91BED4;
      border-color: #91BED4;
      padding-left: 15em;
      padding-right: 15em;
    }
    
    /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
    .row.content {
    	padding-top: 30px;
    	height: 450px;
    }
    
    /* Set gray background color and 100% height */
    .sidenav {
      padding-top: 20px;
      background-color: #f1f1f1;
      height: 375px;
      width: 27%;
      float: right;
      overflow:auto;
    }
    
    .sidenav2 {
      padding-top: 50px;
      margin-top: 20px;
      background-color: #f1f1f1;
      height: 375px;
      width: 27%;
      float: right;
      overflow:auto;
    }

    .text-center {
        padding-right:15%;
        padding-left:15%;
    }
    
    /* On small screens, set height to 'auto' for sidenav and grid */
   /* @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height:auto;} 
    }*/
    #map {
      height: 770px;
      width: 70%;
      float: left;
    }
    
    .menuList {
    	padding-top: 30px;
    }
    input {
    	border: none;
    	padding-left: 2px;
    }
    button {
    	height: 1.7em;
    	border: none;
    }
    #modDiv {
    	width:300px;
    	height:100px;
    	background-color:lightgray;
    	position: absolute;
    	top: 50%;
    	left: 50%;
    	margin-top: -50px;
    	margin-left: -150px;
    	padding: 10px;
    	z-index: 1000;
    }
    table td {
    	padding-left: 20px;
    }
    
  </style>
</head>
<body>

<nav class="navbar navbar-inverse">
	<div class="container-fluid">
		<div class="navbar-header">
			<a class="navbar-brand" href="#" style="color:white">WebSiteName</a>
		</div>
		<div class="collapse navbar-collapse" id="myNavbar">
			<ul class="nav navbar-nav navbar-right">
				<li><a href="#" style="color:white"><span class="glyphicon glyphicon-log-in"></span> Login</a></li>
			</ul>
		</div>
	</div>
</nav>

<script>
var jsonArr = JSON.parse('${list}');
var date = [];
var inputCount = 0;
</script>

<div class="container-fluid text-center">
	<div class="row content">
		<div id="map">
			<script>
			function initMap() {
				var mapcenter = {lat: 37.5693679015, lng: 126.9838371210};
				var map = new google.maps.Map(document.getElementById('map'), {
					zoom: 11,
					center: mapcenter
				});
	
				for(var i=0; i<jsonArr.length; i++){
					var mapPositions = new google.maps.LatLng(Number(jsonArr[i].mapy), Number(jsonArr[i].mapx));
					var marker = new google.maps.Marker({
						position: mapPositions,
						map: map,
						title: jsonArr[i].title,
					});
					//contentString[i] = document.getElementById("title[" + i + "]").value;
					if(jsonArr[i].img != null){
						var contentString = "<div style='float:left;'><img style='width:150px; height:100px;' src=" + jsonArr[i].img + "></div><div style='float:right; padding: 10px;'>" + jsonArr[i].title +"</div>";
					} else
						var contentString = "<div style='float:left;'><img style='width:150px; height:100px;'></div><div style='float:right; padding: 10px;'>" + jsonArr[i].title +"</div>";
					var infowindow = new google.maps.InfoWindow({
						content: contentString,
						size: new google.maps.Size(200,100)
					}); 
					markerListener(marker, infowindow);
					inputCount++;
				}
			}
			function markerListener(localmarker, infowindow){    
		       	google.maps.event.addListener(localmarker, 'click', function() {
					infowindow.open(map, localmarker);
					localmarker.setAnimation(google.maps.Animation.BOUNCE);
				});
		       	
		       	google.maps.event.addListener(infowindow, 'closeclick', function(){
					localmarker.setAnimation(null);
		       	});
			}
			</script>
		</div>
		<script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdkQ3O7ZOpSt2RjwxkSVzgF1NGSHyqkuM&callback=initMap"
    async defer></script>
		
		<form name="inputForm">
			<div class="sidenav">
				<h3>가고 싶은 곳</h3>
				<table>
	 				<tr>
	 					<td style="height:20em;"></td>
						<td>
							<table class="menuList">
								<c:forEach var="list" items="${list }" varStatus="status">
									<tr>
										<td><input id="title[${status.index }]" value="" style="height:23px; width:175px" border=none readonly ></td>
										<td><button id="deleteBtn" onClick="deleteLine(${status.index})"><span class="glyphicon glyphicon-remove" color="white"></span></button></td>
										<td style="height:50px"></td>
									</tr>
								</c:forEach>
							</table>
						</td>
					</tr>
				</table>
			</div>
		</form>
		<script>
		for(var i=0; i<jsonArr.length; i++){
			document.getElementById("title[" + i + "]").value = jsonArr[i].title;
			var date
		}
		</script>
		<script>
		function deleteLine(index) {
			var tr = $(this).parent().parent();
			var Status = index;
	        $.ajax({
	        	type:'post',
	            url: '/course/make/modify/remove/' + Status,
	            headers: {
					"Content-Type": "application/json",
					"X-HTTP-Method-Override": "POST"
				},
				success: function(result){
			        tr.remove();
				}
	        });
	    }
		</script>
		<!-- 
		<form name="dateForm">
			<div class="sidenav2">
				<select name="selectDate" onchange="dateGo(this.form)">
					<option value="0">날짜를 선택하세요</option>
					<option value="1">2017-09-20</option>
					<option value="2">2017-09-21</option>
					<option value="3">2017-09-22</option>
				</select>
			</div>
		</form>
		<script>
		function dateGo(frm){
			var date = frm.selectDate.selectedIndex;
			
			switch(date){
			case 0:
				
			}
		}
		</script>
		 -->
	</div>
</div>
</body>
</html>