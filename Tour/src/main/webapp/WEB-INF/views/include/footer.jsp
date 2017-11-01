<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport">
  
  <style>
  .container-fluid {
      padding: 60px 50px;
      position: relative;
  }
  .bg-brown {
      background-color: #3f2018;
  }
  footer .glyphicon {
      font-size: 20px;
      margin-bottom: 20px;
      color: #ffffff;
  }
  </style>
</head>

<footer class="container-fluid text-center bg-brown" style="margin-top:50px;">
	<a href="#home" title="To Top">
   	 	<span class="glyphicon glyphicon-chevron-up"></span>
 	</a>
  <p style="color:#ffffff;">이 사이트는 한국관광공사의 Tour API를 활용하여 제작되었습니다. <br> <a href="http://api.visitkorea.or.kr/main.do" title="Visit TourAPI" style="color:#ffffff;">http://api.visitkorea.or.kr/main.do</a></p>
</footer>

<script>
$(document).ready(function(){
	  // Add smooth scrolling to all links in navbar + footer link
	  $(".navbar a, footer a[href='#home']").on('click', function(event) {
	    // Make sure this.hash has a value before overriding default behavior
	    if (this.hash !== "") {
	      // Prevent default anchor click behavior
	      event.preventDefault();

	      // Store hash
	      var hash = this.hash;

	      // Using jQuery's animate() method to add smooth page scroll
	      // The optional number (900) specifies the number of milliseconds it takes to scroll to the specified area
	      $('html, body').animate({
	        scrollTop: $(hash).offset().top
	      }, 900, function(){
	   
	        // Add hash (#) to URL when done scrolling (default click behavior)
	        window.location.hash = hash;
	      });
	    } // End if
	  });
	  
	  $(window).scroll(function() {
	    $(".slideanim").each(function(){
	      var pos = $(this).offset().top;

	      var winTop = $(window).scrollTop();
	        if (pos < winTop + 600) {
	          $(this).addClass("slide");
	        }
	    });
	  });
	})
</script>
</html>
