<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
  <title>Bootstrap Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
  
  <script type="text/javascript">                      
      //세션스토로지에 저장
      function setSessionStorage(){
        var textBox = document.querySelector('#textBox3');
        window.sessionStorage['key1'] = textBox.value;
      }      
      //세션스토로지 조회
      function getSessionStorage(){
        var textBox = document.querySelector('#textBox4');
        textBox.value = window.sessionStorage['key1'];
      }    
    </script>
    
</head>
<body>
<div class="container">
<div>
  <form action="/course/make/add2" method="get">
  	<button type="submit" class="btn btn-primary btn-block"> Next </button>
  </form>
</div>
</div>
<input type="text" id="textBox3"> 
    <button onclick="setSessionStorage()">세션스토로지 저장</button>
    <br>    
    <input type="text" id="textBox4"> 
    <button onclick="getSessionStorage()">세션스토로지 조회</button>  
</body>
</html>