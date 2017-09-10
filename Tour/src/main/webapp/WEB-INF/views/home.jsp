<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
  <title>WebSiteName</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  <link rel="stylesheet" href="resources/css/homeCSS.css">
  
  <style>
  .modal-header, h4, .close {
      background-color: #91BED4;
      color:white !important;
      text-align: center;
      font-size: 30px;
  }
  .modal-footer {
      background-color: #f9f9f9;
  }
  </style>
  
</head>
<body>
<div id="fullDIV">
	<%@include file="include/nav1.jsp"%>
	<div id="myCarousel" class="carousel slide" data-ride="carousel" style="height:80%;">
    	<!-- Indicators -->
   		<ol class="carousel-indicators" >
      		<li data-target="#myCarousel" data-slide-to="0" class="active"></li>
      		<li data-target="#myCarousel" data-slide-to="1"></li>
      		<li data-target="#myCarousel" data-slide-to="2"></li>
      		<li data-target="#myCarousel" data-slide-to="3"></li>
    	</ol>
    	<!-- Wrapper for slides -->
    	<div class="carousel-inner"  style="height:100%;margin-left:auto;margin-right:auto;">
      		<div class="item active"  style="height:100%;margin-left:auto;margin-right:auto;">
        		<div class="carousel-caption" style="color:#91BED4;">
          			<h1>WebSiteName</h1>
          			<p>여행 코스 제작 & 공유</p>
          			<img src="resources/img/1.JPG" width="80%" height="80%">
        		</div>
      		</div>
      		<div class="item"  style="height:100%;margin-left:auto;margin-right:auto;">
        		<div class="carousel-caption" style="color:#91BED4;">
          			<h3>여행 코스 제작</h3>
        		</div>
      		</div>   
      		<div class="item"  style="height:100%;margin-left:auto;margin-right:auto;">
        		<div class="carousel-caption" style="color:#91BED4;">
         			<h3>여행 코스 공유</h3>
        		</div>
      		</div>
	  		<div class="item"  style="height:100%;margin-left:auto;margin-right:auto;">
        		<div class="carousel-caption" style="color:#91BED4;">     
    			<form action="/register" method="post">
    				<div>
     					<h2>회원 가입</h2>
    				</div>
    				<div class="form-group">
      					<label for="email" style="color:#91BED4;">이메일</label>
      					<input type="email" class="form-control" id="email" placeholder="이메일을 입력해주세요" name="email">
    				</div>
    				<div class="form-group">
      					<label for="pwd" style="color:#91BED4;">비밀번호</label>
      					<input type="password" class="form-control" id="pwd" placeholder="비밀번호를 입력해주세요" name="pwd">
    				</div>
    				<div class="form-group">
  						<label for="usr" style="color:#91BED4;">이름</label>
  						<input type="text" class="form-control" id="usr" placeholder="이름을 입력해주세요" name="userName">
					</div>
					<input type="submit" class="btn btn-primary btn-lg" value="회원가입">
    			</form>
     			</div>
     	 </div>
    </div>
    <!-- Left and right controls -->
    <a class="left carousel-control" href="#myCarousel" data-slide="prev" style="background-image: none; color:#91BED4">
      <span class="glyphicon glyphicon-chevron-left"></span>
      <span class="sr-only">Previous</span>
    </a>
    <a class="right carousel-control" href="#myCarousel" data-slide="next" style="background-image: none; color:#91BED4">
      <span class="glyphicon glyphicon-chevron-right"></span>
      <span class="sr-only">Next</span>
    </a>
  </div>	
</div>

<!-- Modal -->
  <div class="modal fade" id="myModal" role="dialog">
    <div class="modal-dialog">
    
      <!-- Modal content-->
      <div class="modal-content">
        <div class="modal-header" style="padding:35px 50px;">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4><span class="glyphicon glyphicon-lock"></span> 로그인 </h4>
        </div>
        
        <div class="modal-body" style="padding:40px 50px;">
          <form role="form" action="/login" method="post">
            <div class="form-group">
              <label for="usrname"><span class="glyphicon glyphicon-user"></span> 이메일 </label>
              <input type="text" class="form-control" id="usrname" placeholder="이메일을 입력해주세요." name="email">
            </div>
            <div class="form-group">
              <label for="psw"><span class="glyphicon glyphicon-eye-open"></span> 비밀번호 </label>
              <input type="password" class="form-control" id="psw" placeholder="비밀번호를 입력해주세요" name="pwd">
            </div>
            
              <button type="submit" class="btn btn-primary btn-block"><span class="glyphicon glyphicon-off"></span> 로그인 </button>
          </form>
        </div>
        
        <div class="modal-footer">
          <button type="submit" class="btn btn-danger btn-default pull-left" data-dismiss="modal"><span class="glyphicon glyphicon-remove"></span> 취소 </button>
        </div>
      </div>
      
    </div>
  </div> 
  
<script>
$(document).ready(function(){
    $("#reg").click(function(){
        $("#myCarousel").carousel(3);
    });
    $("#login").click(function(){
    	$("#myModal").modal();
    });
});
</script>

</body>
</html>