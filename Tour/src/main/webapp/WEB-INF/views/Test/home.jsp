<!DOCTYPE html>
<html lang="ko">
<head>
  <title>WebSiteName</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<style>
* {
	margin:0;
	padding:0;
	weight:100%;
}
html,#fullD {
	height:100%;
	background-color:white;
}
body {
	height:100%;
	background-color:white;

}
#topD {
	height:25px;
	background-color:#000000;
}
#smallD {
	height:70%;
}
#secondD {
	height:300px;
	background-color:#2c3e50;
}
#thirdD {
	height:300px;
	background-color:#e74c3c;
}
#fourthD {
	height:300px;
	background-color:#3498db;
}
#fifthD {
	height:300px;
	background-color:#ecf0f1;
}
</style>
<body>
<div id="fullD">
	<!-- Topbar -->
	<div id="topD"></div>
	
	<!-- 1 : Navbar -->
	<%@include file="include/nav1.jsp"%>
	
	<!-- 2 : Carousel -->
	<div id="smallD">
		<div id="myCarousel" class="carousel slide" data-ride="carousel">
    		<!-- Indicators -->
    		<ol class="carousel-indicators">
      			<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      			<li data-target="#myCarousel" data-slide-to="1"></li>
      			<li data-target="#myCarousel" data-slide-to="2"></li>
   	 		</ol>
    		<!-- Wrapper for slides -->
    		<div class="carousel-inner">
      			<div class="item active">
        			<img src="/resources/Test/img/R1.jpg" alt="Los Angeles" style="width:100%;">
        			<div class="carousel-caption">
          				<h3>Los Angeles</h3>
          				<p>LA is always so much fun!</p>
        			</div>
      			</div>
      			<div class="item">
        			<img src="/resources/Test/img/R2.jpg" alt="Chicago" style="width:100%;">
        			<div class="carousel-caption">
          				<h3>Chicago</h3>
          				<p>Thank you, Chicago!</p>
        			</div>
      			</div>
      			<div class="item">
        			<img src="/resources/Test/img/R3.jpg" alt="New York" style="width:100%;">
        			<div class="carousel-caption">
          				<h3>New York</h3>
          				<p>We love the Big Apple!</p>
        			</div>
      			</div>
  			</div>
			<!-- Left and right controls -->
    		<a class="left carousel-control" href="#myCarousel" data-slide="prev">
      			<span class="glyphicon glyphicon-chevron-left"></span>
      			<span class="sr-only">Previous</span>
    		</a>
    		<a class="right carousel-control" href="#myCarousel" data-slide="next">
      			<span class="glyphicon glyphicon-chevron-right"></span>
      			<span class="sr-only">Next</span>
    		</a>
  		</div> <!-- Carousel -->
	</div> <!-- SmallD -->
	<div id="secondD"></div>
	<div id="thirdD"></div>
	<div id="fourthD"></div>
	<div id="fifthD"></div>
</div> <!-- fullD -->
</body>
</html>