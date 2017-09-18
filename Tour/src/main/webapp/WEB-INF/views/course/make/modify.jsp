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
      background-color: #f1f1f1;
      height: 55em;
      width: 27%;
      float: right;
    }

    .text-center {
        padding-right:15%;
        padding-left:15%;
    }
    
    /* On small screens, set height to 'auto' for sidenav and grid */
    @media screen and (max-width: 767px) {
      .sidenav {
        height: auto;
        padding: 15px;
      }
      .row.content {height:auto;} 
    }
    #map {
      height: 55em;
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
 
<div class="container-fluid text-center">
	<%
	int count = 0;
	%>
	<c:forEach var="list" items="${lists }" varStatus="status">
		<input type="hidden" id="mapx[${status.index }]" value="${list.mapx }">
		<input type="hidden" id="mapy[${status.index }]" value="${list.mapy }">
		<input type="hidden" id="title[${status.index }]" value="${list.title }">
		<input type="hidden" id="img[${status.index }]" value="${list.firstimage2 }">
    	
		<%
		count++;
		%>
	</c:forEach>
	<script>
	var mapx = new Array();
	var mapy = new Array();
	var mapTitle = new Array();
	var count = <%=count%>;

	for(var i=0; i<count; i++){
		mapx[i] =  document.getElementById("mapx[" + i + "]").value;
		mapy[i] =  document.getElementById("mapy[" + i + "]").value;
		mapTitle[i] = document.getElementById("title[" + i + "]").value;
	}
	</script>
	<div class="row content">
		<div id="map"></div>
		<script>
		function initMap() {
			var mapcenter = {lat: 37.5693679015, lng: 126.9838371210};
			var map = new google.maps.Map(document.getElementById('map'), {
				zoom: 11,
				center: mapcenter
			});

			var contentString = [];
			var marker = [];
			var infowindow = [];
			var img = [];
			var mapPositions = [];
			
			for(var i=0; i<count; i++){
				mapPositions[i] = new google.maps.LatLng(mapy[i], mapx[i]);
				marker[i] = new google.maps.Marker({
					position: mapPositions[i],
					map: map,
					title: mapTitle[i],
				});
				//contentString[i] = document.getElementById("title[" + i + "]").value;
				img[i] = document.getElementById("img[" + i + "]").value;
				contentString[i] = "<div style='float:left;'><img style='width:150px; height:100px;' src=" + img[i] + "></div><div style='float:right; padding: 10px;'>" + mapTitle[i] +"</div>"
				infowindow[i] = new google.maps.InfoWindow({
					content: contentString[i],
					size: new google.maps.Size(200,100)
				}); 
				markerListener(marker[i], infowindow[i]);
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
		<script async defer
			src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdkQ3O7ZOpSt2RjwxkSVzgF1NGSHyqkuM&callback=initMap">
		</script>
		
		<form>
		<div class="col-sm-2 sidenav">
			<br><br><h3>가고 싶은 곳</h3>
			<table>
 				<tr>
 					<td style="height:40em;"></td>
					<td>
						<table class="menuList">
							<c:forEach var="list" items="${lists }" varStatus="status">
								<tr>
									<td><input id="title[${status.index }]" value="${list.title }" style="height:23px; width:170px" border=none readonly></td>
									<td><button id="button[${status.index }]" onClick="deleteLine(this, ${status.index});"><span class="glyphicon glyphicon-remove" color="white"></span></button></td>
									<td style="height:50px"></td>
								</tr>
							</c:forEach>
						</table>
					</td>
				</tr>
			</table>
			<br><br><br>
			"F5를 누르면 초기화됩니다."
			</div>
		</form>
		<script type="text/javascript">
		function deleteLine(obj, index) {
			var tr = $(obj).parent().parent();
			
			for(var i=0; i<count;i++){
				if( i == index){
					mapx[i] = null;
					mapy[i] = null;
					mapTitle[i] = null;
					break;
				}
			}
			//라인 삭제
			tr.remove();
			initMap();
		}
		</script>
	</div>
</div>
</body>
</html>