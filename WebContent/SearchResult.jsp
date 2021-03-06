<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*,xuandong.*,javax.servlet.*,KaiChieh.*,bian.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap.min.css" integrity="sha384-1q8mTJOASx8j1Au+a5WDVnPi2lkFfwwEAa8hDDdjZlpLegxhjVME1fgjWPGmkzs7" crossorigin="anonymous">
<!-- Optional theme -->
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/css/bootstrap-theme.min.css" integrity="sha384-fLW2N01lMqjakBkx3l/M9EahuwpSfeNvV63J5ezn3uZzapT0u7EYsXMjQV+0En5r" crossorigin="anonymous">
<!-- Latest compiled and minified JavaScript -->
<script src="//code.jquery.com/jquery-1.11.0.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.6/js/bootstrap.min.js" integrity="sha384-0mSbJDEHialfmuBBQP6A4Qrprq5OVfW37PRR3j5ELqxss1yVqOtnepnHVP9aJ7xS" crossorigin="anonymous"></script>

<link rel="stylesheet" type="text/css" href="http://fonts.googleapis.com/css?family=Ek+Mukta">

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

.table th {
   text-align: center;   
}

h5 {
	color:#ff9999;
}

h6 {
	font-size:16px;
}

.button-container form,
.button-container form div {
    display: inline;
}

.button-container button {
    display: inline;
    vertical-align: middle;
}

.linkButton { 
     background: none;
     border: none;
     color: #0066CC;
     text-decoration: underline;
     cursor: pointer; 
}

.grayscale {
	-webkit-filter: grayscale(100%);
	filter: grayscale(100%);
}

.tooltip-inner  {
	white-space:pre-wrap;
	max-width:200px;
	word-wrap:break-word;
	background-color:#181818 ;
}


.carousel-control.left, .carousel-control.right {
	background-image: none
}

.clearfix:after {
	display: block;
	clear: both;
}

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
</style>
<title>Search Result</title>
</head>
<body style="background-color:#fffff6;">
		<div
		style="position: fixed; width: 100%; height: 50px; top: 0px; left: 0; z-index: 2; text-align: center; background-color: black; color: #FAF0E6; opacity: 0.8;">

		<div
			style="position: absolute; left: 0px; width: 300px; height: 100%; background-color:black;">
			<div
				style="position: absolute; left: 0px; top: 5px; width: 250px; height: 45; background-color: black;">
				<% 
					String userID = (String) session.getAttribute("userID");
					if(userID.equals("Guest")) {
						out.print("<a href=\"GuestHomePage.jsp\"><h4 style=\"color: #ffb3b3;\">QuizzGo</h4></a>");
					}else{
						out.print("<a href=\"HomePage.jsp\"><h4 style=\"color: #ffb3b3;\">QuizzGo</h4></a>");
					}
				%>
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
								userID = (String) session.getAttribute("userID");
								String welcome = "Hi "+userID+"!";
								out.println(welcome);
							%>
							</a>
						</li>
						<li><a href="#">Menu<span class="arrow">&#9660;</span></a>
							<ul class="sub-menu">
								<% 
								   if(userID.equals("Guest")) {
									   out.print("<li><a href=\"CreateAccount.jsp\">Create Account</a></li>");
								   }else{
									   String userIDUrl = "QuizCreat.jsp?userID="+userID; 
									   String quizRecordUrl = "UserViewHistory.jsp"; 
									   out.print("<li><a href=\""+ userIDUrl+"\">Create Quiz</a></li>");
									   out.print("<li><a href=\""+ quizRecordUrl+"\">Quiz Record</a></li>");
								   }
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
		String searchOption = (String) session.getAttribute("searchOption");
		int height = 0;
		if (searchOption.equals("user")) {
			ArrayList<User> userSearchResult = (ArrayList<User>) session.getAttribute("searchResult");
			height = 150 + userSearchResult.size() * 40;
			out.print("<div style=\"text-align:center;background-color:white;position:absolute;top:100px;height:"
					+ height
					+ "px;width:700px;left:50%;margin-left:-350px;border-radius: 20px;border: 2px solid #73AD21;padding: 15px; \">");
			out.print("<div class=\"row\">");
			out.print("<div class=\"col-xs-6 col-md-4 text-left\" style=\"left: 0px;top:30px;\">");
			out.print("<a href=\"HomePage.jsp\">Back to HomePage</a>");
			out.print("</div>");
			out.print("<div class=\"col-xs-6 col-md-4 text-center\">");
			out.print("<h3> Search Result </h3>");
			out.print("</div>");
			out.print("<div class=\"col-xs-6 col-md-4 text-left\">");
			out.print("</div>");
			out.print("</div>");
			// Make a table 
			if (userSearchResult.size() > 0) {
				int numUsers = 0;
				out.print("<br>");
				out.print("<table class=\"table table-striped\">");
				out.print("<tr>");
				out.print("<th>#</th>");
				out.print("<th>User ID</th>");
				out.print("<th>User Name</th>");
				out.print("<th>User Gender</th>");
				out.print("</tr>");
				for (User user : userSearchResult) {
					out.print("<tr  class=\"success\">");
					out.print("<td>" + String.valueOf(numUsers + 1) + "</td>");
					out.print("<td>" + "<a href=\"UserProfile.jsp?usertoview="+user.getID()+"\">" + user.getID() + "</a>" + "</td>");
					out.print("<td>" + user.getName() + "</td>");
					out.print("<td>" + user.getGender() + "</td>");
					/* String quizUrl = "QuizSummary.jsp?quizID="+user.getAge()+"&userID="+userID;
					String quizString = "<a href=\""+quizUrl+"\">" + Quiz.getName(performance.getQuizID()) +"</a>";
					String activity = "Took quiz: "+quizString+" and received "+performance.getScore()+"!"; */
					//out.print("<td>"+activity+"</td>");
					out.print("</tr>");
					numUsers++;
				}
				out.print("</table>");
			} else {
				out.print("<hr style=\"border:none;border-top:1px #CCCCCC solid;height: 1px;\"></hr>");
				out.print("<h4>Can't find match result!</h4>");
			}
			out.print("</div>");
		} else if (searchOption.equals("quiz")) {
			ArrayList<Quiz> quizSearchResult = (ArrayList<Quiz>) session.getAttribute("searchResult");
			height = 150 + quizSearchResult.size() * 40;
			out.print("<div style=\"text-align:center;background-color:white;position:absolute;top:100px;height:"
					+ height
					+ "px;width:700px;left:50%;margin-left:-350px;border-radius: 20px;border: 2px solid #73AD21;padding: 15px; \">");
			out.print("<div class=\"row\">");
			out.print("<div class=\"col-xs-6 col-md-4 text-left\" style=\"left: 0px;top:30px;\">");
			out.print("<a href=\"HomePage.jsp\">Back to HomePage</a>");
			out.print("</div>");
			out.print("<div class=\"col-xs-6 col-md-4 text-center\">");
			out.print("<h3> Search Result </h3>");
			out.print("</div>");
			out.print("<div class=\"col-xs-6 col-md-4 text-left\">");
			out.print("</div>");
			out.print("</div>");
			if (quizSearchResult.size() > 0) {
				// Make a table 
				int numQuiz = 0;
				out.print("<br>");
				out.print("<table class=\"table table-striped\">");
				out.print("<tr>");
				out.print("<th>#</th>");
				out.print("<th>Quiz Name</th>");
				out.print("<th>Category</th>");
				out.print("<th>Author</th>");
				out.print("<th>Popularity</th>");
				//out.print("");
				out.print("</tr>");
				for (Quiz quiz : quizSearchResult) {
					out.print("<tr  class=\"success\">");
					out.print("<td>" + String.valueOf(numQuiz + 1) + "</td>");
					String quizUrl = "QuizSummary.jsp?quizID="+quiz.getQuizID()+"&userID="+userID;
					String quizString = "<a href=\""+quizUrl+"\">" + quiz.getName() +"</a>";
					out.print("<td>" + quizString + "</td>");
					out.print("<td>" + quiz.getCategory()+ "</td>");
					out.print("<td><a href=\"UserProfile.jsp?usertoview="+quiz.getAuthor()+"\">" + quiz.getAuthor()+ "</a></td>");
					out.print("<td>" + quiz.getPopularity() + "</td>");
					/* String quizUrl = "QuizSummary.jsp?quizID="+user.getAge()+"&userID="+userID;
					String quizString = "<a href=\""+quizUrl+"\">" + Quiz.getName(performance.getQuizID()) +"</a>";
					String activity = "Took quiz: "+quizString+" and received "+performance.getScore()+"!"; */
					//out.print("<td>"+activity+"</td>");
					out.print("</tr>");
					numQuiz++;
				}
				out.print("</table>");
			} else {
				out.print("<hr style=\"border:none;border-top:1px #CCCCCC solid;height: 1px;\"></hr>");
				out.print("<h4>Can't find match result!</h4>");
			}
			out.print("</div>");
		}
	%>

</body>
</html>