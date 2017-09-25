<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<html>
<style>
	.glyphicon{
	font-size:20px;
	}
	.convert {
	-webkit-transform: scaleY(-1);
	}
	.fileDrop{
	width: 100%;
	height: 200px;
	border: 1px dotted blue;
	}
	small{
	margin-left: 3px;
	font-weight: bold;
	color: gray;
	}
</style>
<head>
<meta charset="UTF-8">
	<title>사진 올리기</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
</head>
<body>

<div class="contents" style="padding:15px;">
	
	<div class="imageHeader">
		<div style="display:inline-block;font-size:20px;padding:6px">나만의 사진을 저</div>
		<div style="display:inline-block;padding-top:15px;padding-right:3px;">
			<span class="glyphicon glyphicon-hand-right"></span>
		</div>
		<div style="display:inline-block;">
			<span class="glyphicon glyphicon-hand-left convert"></span>
		</div>
		<div style="display:inline-block;font-size:20px;padding:6px">장</div>
		<div style="display:inline-block;padding-bottom:15px;padding-right:3px;">
			<span class="glyphicon glyphicon-hand-right convert"></span>
		</div>
		<div style="display:inline-block;padding-top:15px;">
			<span class="glyphicon glyphicon-hand-left"></span>
		</div>
	</div><!-- /imageHeader -->
	
	<div class="imageBody" style="border:1px solid #d98cd9;float:none;padding:10px;">
		<div class="fileDrop">
		</div>
	</div><!-- /imageBody -->
	
</div><!-- /contents -->

<script>
	$(".fileDrop").on("dragenter dragover", function(event){
		event.preventDefault();
	});
	$(".fileDrop").on("drop", function(event){
		event.preventDefault();
	})
</script>
</body>
</html>