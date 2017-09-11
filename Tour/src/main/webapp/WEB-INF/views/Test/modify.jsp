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
    	height: 1.6em;
    	border: none;
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
  <div class="row content">
    <div id="map"></div>
      <script>
      function initMap() {
        var uluru = {lat: ${lists[0].mapy}, lng: ${lists[0].mapx}};
        var uluru2 = {lat: ${lists[1].mapy}, lng: ${lists[1].mapx}};
        console.log("uluru");
        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 7,
          center: uluru2
        });

        var contentString = '<div style="width:100px;height:50px;">${lists[0].title}</div>';
        var contentString2 = '<div style="width:100px;height:50px;">${lists[1].title}</div>';

        var infowindow = new google.maps.InfoWindow({
	content: contentString,
	size: new google.maps.Size(200,100)
        });

        var infowindow2 = new google.maps.InfoWindow({
	content: contentString2,
	size: new google.maps.Size(200,100)
        });

        function pinSymbol(color) {
	return {
	    path: 'M 0,0 C -2,-20 -10,-22 -10,-30 A 10,10 0 1,1 10,-30 C 10,-22 2,-20 0,0 z M -2,-30 a 2,2 0 1,1 4,0 2,2 0 1,1 -4,0',
	    fillColor: color,
 	    fillOpacity: 1,
	    strokeColor: '#000',
	    strokeWeight: 1,
	    scale: 1,
	};
        }

        var marker = new google.maps.Marker({
          position: uluru,
          map: map,
          title: 'test',
          icon: pinSymbol("yellow"),
        });

        var marker2 = new google.maps.Marker({
          position: uluru2,
          map: map,
          title: 'test2',
          icon: pinSymbol("pink"),
        });

        google.maps.event.addListener(marker, 'click', function() {
	infowindow2.close();
	infowindow.open(map, marker);

 	if (marker.getAnimation() != null) {
	   marker.setAnimation(null);
	} else {
	   marker.setAnimation(google.maps.Animation.BOUNCE);
	}
        });
	
        google.maps.event.addListener(marker2, 'click', function() {
	infowindow.close();

	infowindow2.open(map, marker2);

 	if (marker2.getAnimation() != null) {
	   marker2.setAnimation(null);
	} else {
	   marker2.setAnimation(google.maps.Animation.BOUNCE);
	}
        });
      }
      </script>
      <script async defer
      src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCdkQ3O7ZOpSt2RjwxkSVzgF1NGSHyqkuM&callback=initMap">
      </script>
      <div class="col-sm-2 sidenav">
      	<div id="menuTitle">
  			<h3>가고 싶은 곳</h3>
      	</div>
      	<div class="menuList">
  			<form>
  				<c:forEach var="list" items="${lists }" varStatus="status">
  					<input id="${status.count }" value="${list.title }" border=none readonly><button><span class="glyphicon glyphicon-remove" color="white"></span></button><br><br><br>
  				</c:forEach>
  			</form>
  		</div>
      </div>
    </div>
  </div>

  </body>
  </html>
