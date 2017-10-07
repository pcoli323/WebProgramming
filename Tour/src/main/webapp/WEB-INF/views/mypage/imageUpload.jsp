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
	height: auto;
	min-height: 200px;
	border: 1px dotted blue;
	}
</style>
<head>
<meta charset="UTF-8">
	<title>사진 올리기</title>
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

<div class="contents" style="padding:15px;">
	
	<div class="imageHeader" style="margin-bottom:10px;">
		<div style="font-size:20px;display:inline-block;height:100%;vertical-align:middle;">
			<div style="padding:10px 0px 10px 0px;">나만의 사진을 저</div>
		</div>
		<div style="display:inline-block;height:100%;vertical-align:middle;">
			<br>
			<span class="glyphicon glyphicon-hand-right"></span>
		</div>
		<div style="display:inline-block;height:100%;vertical-align:middle;">
			<span class="glyphicon glyphicon-hand-left convert"></span>
			<br>
		</div>
		<div style="font-size:20px;display:inline-block;height:100%;vertical-align:middle;">
			<div style="padding:10px 0px 10px 0px;">장</div>
		</div>
		<div style="display:inline-block;height:100%;vertical-align:middle;">
			<span class="glyphicon glyphicon-hand-right convert"></span>
			<br>
		</div>
		<div style="display:inline-block;height:100%;vertical-align:middle;">
			<br>
			<span class="glyphicon glyphicon-hand-left"></span>
		</div>
		<div style="display:block;text-align:right;color:DarkGray;font-size:10px;">
			최대 파일 크기 : 10MB, 가능한 파일 유형 : jpg/jpeg, png, gif
		</div>
	</div><!-- /imageHeader -->
	
	<div class="imageBody" style="border:1px solid #d98cd9;padding:10px;">
		<div class="fileDrop">
			<div class="imagePreview" style="max-width:330px;">
				<button type="button" class="btn btn-default btn-xs pull-right" id="removeImageBtn" style="outline:0">
					<i class="fa fa-fw fa-remove"></i></button>
				<img class="preview" src="" style="max-width:300px;height:auto;padding:5px;">
			</div>
		</div><!-- /fileDrop -->
	</div><!-- /imageBody -->
	
	<div class="imageFooter" style="padding:10px;text-align:right;">
		<button type="button" class="btn btn-success btn-sm" id="checkImageBtn" style="outline:0">확인</button>
	</div><!-- /imageFooter -->
	
</div><!-- /contents -->

<script>
	var prevFile;
	var isPreviewImage;
	var gotoNumber;
	var gotoName;
	var isModify;
	
	$(document).ready(function(){
		prevFile = null;
		isPreviewImage = false;
		gotoNumber = opener.gotoNumber;
		gotoName = opener.gotoName;
		isModify = opener.isModify;
		
		$('.imagePreview').hide();
		
		if(isModify == true){
			prevFile = opener.addImageList.get(gotoNumber);
			$('.preview').attr("src",  URL.createObjectURL(prevFile));
			$('.imagePreview').show();
			isPreviewImage = true;
		}
		
	});
	
</script>
<script>
	$(".fileDrop").on("dragenter dragover", function(event){
		event.preventDefault();
	});
	var file = null;
	$(".fileDrop").on("drop", function(event){
		event.preventDefault();
		
		var imageFileType = ["jpg", "jpeg", "png", "gif"];
		var files = event.originalEvent.dataTransfer.files;
		file = files[0];
		console.log(file);
		console.log(file.size);
		var fileType = file.type.split('/');
		
		var fileTest = false;
		if(fileType[0] == "image"){
			for(var i=0; i<imageFileType.length; i++){
				if(fileType[1].toLowerCase() == imageFileType[i]){
					fileTest = true;
				}
			}
		}
		
		if(fileTest == false){
			alert("JPG/JPEG, PNG, GIF 형식만 가능합니다.");
		}
		else if(file.size > 10485760){
			alert("최대파일크기 : 10MB");
		}
		else{
			$('.preview').attr("src", URL.createObjectURL(file));
			$('.imagePreview').show();
			isPreviewImage = true;
		}
		
	});
	
	$('#removeImageBtn').on("click", function(){
		console.log("removeImageBtn 누름");
		$('.preview').attr("src", '');
		$('.imagePreview').hide();
		file = null;
		isPreviewImage = false;
	});
	
	$('#checkImageBtn').on("click", function(){
		if(isModify == false){
			if(file != null){
				registerImage();
			}
		}
		else{
			if(file == null){
				if(isPreviewImage == false){
					removeImage();
				}
			}
			else{
				removeImage();
				registerImage();
			}
		}
		setTimeout(closeImageUpload, 1000);
	});
	
	function registerImage(){
		opener.addImageList.set(gotoNumber, file);
		var id = "picture-" + gotoNumber + "-" + gotoName;
		var element = opener.document.getElementById(id);
		element.classList.add("active");
		element.style.color = "#6495ED";
		if(opener.gotoNumberMapMarker.has(gotoNumber) == true){
			var str = "<div style='float:left;'><img style='width:150px; height:100px;' src=" + URL.createObjectURL(file) 
						+ "></div><div style='float:right; padding: 10px;'>" + gotoName +"</div>";
			var infowindowsIndex = opener.gotoNumberMapMarker.get(gotoNumber);
			opener.infowindows[infowindowsIndex].setContent(str);
		}
		console.log(opener.addImageList);
	}
	
	function removeImage(){
		opener.addImageList.delete(gotoNumber);
		var id = "picture-" + gotoNumber + "-" + gotoName;
		var element = opener.document.getElementById(id);
		element.classList.remove("active");
		element.style.color = "LightGray";
		if(opener.gotoNumberMapMarker.has(gotoNumber) == true){
			var str = "<div style='float:left;'></div><div style='float:right; padding: 10px;'>" + gotoName + "</div>";
			var infowindowsIndex = opener.gotoNumberMapMarker.get(gotoNumber);
			opener.infowindows[infowindowsIndex].setContent(str);
		}
		console.log(opener.addImageList);
		/*
		$.ajax({
			type: 'DELETE',
			url: '/imageDelete/'+gotoNumber,
			headers: {
				"Content-Type": "application/json",
				"X-HTTP-Method-Override": "DELETE"
			},
			data:JSON.stringify({deleteImage:prevFile}),
			dataType:'text',
			success: function(){
				var id = "picture-" + gotoID + "-" + gotoNumber;
				var element = opener.document.getElementById(id);
				element.classList.remove("active");
				element.style.color = "LightGray";
				var str = "<div style='float:left;'></div>";
				opener.infowindows[gotoID].setContent(str);
			}
		});
		*/
	}
	
	function closeImageUpload(){
		self.close();
	}
</script>
</body>
</html>