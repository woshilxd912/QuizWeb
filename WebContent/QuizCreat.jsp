<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ page import="xuandong.*" %>
    <%@ page import="bian.*" %>
    <%@ page import="java.util.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
<!-- Latest compiled and minified JavaScript -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>
<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Ek+Mukta">
<script> 
$(function () {
	  $('[data-toggle="popover"]').popover()
	})
</script>

<script type='text/javascript'>
	function pageScrollUp(position) {
		var yPos = window.pageYOffset;
		yPos -= 95;
		if (yPos < position) {
			yPos = position;
		}
		window.scroll(0, yPos); // horizontal and vertical scroll increments
		scrolldelay = setTimeout('pageScrollUp(\'' + position + '\')', 45); // scrolls every 100 milliseconds
		if (yPos == position) {
			clearTimeout(scrolldelay);
		}
	}
	$(document).ready(function(){
	    $('[data-toggle="tooltip"]').tooltip({
	        placement : 'top'
	    });
	});
	$(function() {
		$('[data-tooltip="true"]').tooltip();
		});
	function myFunction() {
	    document.getElementById("receiver").defaultValue = "Goofy";
	}
	
</script>

<style>
/*----- Menu Outline -----*/
.menu-wrap {
	width: 100%;
	box-shadow: 0px 1px 3px rgba(0, 0, 0, 0.2);
	background: black;
}

.menu {
	width: 300px;
	margin: 0px auto;
}

.menu li {
	margin: 0px;
	list-style: none;
	font-family: 'Ek Mukta';
}

.menu a {
	transition: all linear 0.15s;
	color: #919191;
}

.menu li:hover>a, .menu .current-item>a {
	text-decoration: none;
	color: #be5b70;
}

.menu .arrow {
	font-size: 11px;
	line-height: 0%;
}

/*----- Top Level -----*/
.menu>ul>li {
	float: left;
	display: inline-block;
	position: relative;
	font-size: 19px;
}

.menu>ul>li>a {
	padding: 10px 30px;
	display: inline-block;
	text-shadow: 0px 1px 0px rgba(0, 0, 0, 0.4);
}

.menu>ul>li:hover>a, .menu>ul>.current-item>a {
	background: #2e2728;
}

/*----- Bottom Level -----*/
.menu li:hover .sub-menu {
	z-index: 1;
	opacity: 1;
}

.sub-menu {
	width: 140%;
	padding: 5px 0px;
	position: absolute;
	top: 100%;
	left: 0px;
	z-index: -1;
	opacity: 0;
	transition: opacity linear 0.15s;
	box-shadow: 0px 2px 3px rgba(0, 0, 0, 0.2);
	background: #2e2728;
}

.sub-menu li {
	display: block;
	font-size: 16px;
}

.sub-menu li a {
	padding: 10px 30px;
	display: block;
}

.sub-menu li a:hover, .sub-menu .current-item a {
	background: #3e3436;
}

tr {
width: 100%;
display: inline-table;
table-layout: fixed;
}

table{
 height: 480px;             
 display: -moz-groupbox;    
}

tbody{
  overflow-y: scroll;      
  height: 480px; 
  width: 97%;          
  position: absolute;
}

</style>

<title>User History</title>
</head>
<!-- background-image: linear-gradient(rgba(255,255,255,0.4),rgba(255,255,255,0.4)),url('http://stylearena.net/wp-content/uploads/2015/03/cute-hd-wallpapers9.jpg') -->
<body style="height:770px;background-size:100%;background-color:#fffff6;">
<div
		style="position: fixed; width: 100%; height: 50px; top: 0px; left: 0; z-index: 2; text-align: center; background-color: black; color: #FAF0E6; opacity: 0.8;">

		<div
			style="position: absolute; left: 0px; width: 300px; height: 100%; background-color:black;">
			<div
				style="position: absolute; left: 0px; top: 5px; width: 250px; height: 45; background-color: black;">
				<a href="HomePage.jsp"><h4 style="color: #ffb3b3;">QuizzGo</h4></a>
			</div>
		</div>

		<div class="col-lg-6"
			style="position: absolute; top: 8px; left: 30%; width: 40%;">
			<form action="SearchServlet" method="post" id="search">
				<div class="input-group">
					<input type="text" name="targetToSearch" class="form-control" placeholder="Search for...">
					<span class="input-group-btn" style="width:65px"> 
					<select class="selectpicker form-control" id="sel1" name="searchOption">
							<option value="quiz">Quiz</option>
							<option value="user">User</option>
					</select>
					</span> <span class="input-group-btn">
						<button type="submit" form="search" class="btn btn-default" type="button">
							<span class="glyphicon glyphicon-search" style="font-size: 20px;"></span>
						</button>
					</span>
				</div>
			</form>
			<!-- /input-group -->
		</div>
		<div
			style="position: absolute; right: 5px; width: 300px; height: 100%; background-color: black;">

			<div class="menu-wrap">
				<nav class="menu">
					<ul class="clearfix">
						<li style="left:-10px;width:110px;overflow:hidden;white-space:nowrap;text-overflow:ellipsis;"><a href="javascript:pageScrollUp(0)" style="top:30px;padding:10px 1px;color:yellow;">
							<%
								String userID = (String) session.getAttribute("userID");
								String welcome = "Hi "+userID+"!";
								out.println(welcome);
							%>
							</a>
						</li>
						<li><a href="#">Menu<span class="arrow">&#9660;</span></a>
							<ul class="sub-menu">
								<% String userIDUrl = "QuizCreat.jsp?userID="+userID; 
								   out.print("<li><a href=\""+ userIDUrl+"\">Create Quiz</a></li>");
								%>
								<% String quizRecordUrl = "UserViewHistory.jsp"; 
								   out.print("<li><a href=\""+ quizRecordUrl+"\">Quiz Record</a></li>");
								%>
								<% String announceUrl = "UserViewAnnoun.jsp"; 
								   out.print("<li><a href=\""+ announceUrl +"\">Announcements</a></li>");
								%>
								<li><a href="UserLogin.jsp">Logout</a></li>
							</ul>
						</li>
					</ul>
				</nav>
			</div>
		</div>
		<!-- /.col-lg-6 -->
	</div>



<%
	String authorID = (String) request.getParameter("userID"); 

	Quiz quiz = new Quiz();
	quiz.setAuthor(authorID);
	
	session.setAttribute("newQuiz", quiz); 
	
%>

<form action="QuizCreatServlet" method="post">
<div class="container" style = "position: relative; width:70%; top: 50px;">
  <h2 style="text-align:center;">Create a Quiz</h2> 
  		<div style="border-radius: 20px;
    				border: 2px solid #73AD21;
    				padding: 15px; 
				    height: 660px;
     				text-align:left;
     				left:50%;width:900px;
     				margin-left:-450px;
     				top:70px;
     				position:absolute;
     				opacity: 0.9;
     				background-color:white;
     				">

<!-- Quiz Properties -->
<!-- name description image -->
<div class = "container" style = "position: relative;">

<div  class="container"><a href="LoadXML.jsp"> Want to Load an XML file? </a></div>
	<p><h5>*Name: </h5> </p>
	<input style = "width:72%" type="text" class="form-control form-control-inline" name = "name" placeholder="Quiz Name">
	<p><h5>*Quiz Description: </h5> </p>
  	<textarea style = "width:72%" class="form-control" rows="3" name = "description" placeholder="Quiz Description"></textarea>
  	<p><h5>Category: </h5> </p>
	<input style = "width:72%" type="text" class="form-control form-control-inline" name = "cate" placeholder="Quiz Category">
  	<p><h5>Quiz Picture: </h5> </p>
	<input style = "width:72%" type="text" class="form-control" name = "picture" placeholder="URL">


<!-- Random -->
	<p><h5>Random: Will the problems in quiz display in randomly ordered? </h5> </p>
	<div class="radio">
		  <label><input type="radio" name="Random" value="Yes">Yes</label>
	</div>
		<div class="radio">
		  <label><input type="radio" name="Random" value="No">No</label>
	</div>


<!-- OnePage -->

	<p><h5>Page: Will the problems in quiz display in one page or multiple pages? </h5> </p>
	<div class="radio">
		  <label><input type="radio" name="OnePage" value="Yes">One Page</label>
	</div>
		<div class="radio">
		  <label><input type="radio" name="OnePage" value="No">Multiple Pages</label>
	</div>


<!-- PracticeMode -->

<!-- 	<p><h5>Practice Mode: Will this quiz have practice mode? </h5> </p>
	<div class="radio">
		  <label><input type="radio" name="Practice" value="Yes">Yes</label>
	</div>
		<div class="radio">
		  <label><input type="radio" name="Practice" value="No">No</label>
	</div> -->

		  
<!-- ImmediateCorrection -->

	<p><h5>Immediate Correction: Will problems in this quiz be immediately corrected when being taken? </h5> </p>
	<div class="radio">
		  <label><input type="radio" name="ImmCorr" value="Yes">Yes</label>
	</div>
		<div class="radio">
		  <label><input type="radio" name="ImmCorr" value="No">No</label>
	</div>
	
<button type="submit"  class="btn btn-success" type="button" style = "position: relative; left: 35%; width: 120px; margin-left:-60px">Add Questions</button>


  <div  style = "position: relative; width:80%; top: 25px;"><a href="HomePage.jsp"> Back to Home Page </a></div>
</div>

</div>
</form>
</body>
</html>

