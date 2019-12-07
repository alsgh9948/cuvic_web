<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:useBean id="post_list" scope="request" class="java.util.ArrayList" />

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/main.css?version=1">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">

<style>
.mySlides {
	display: nonez
}

.w3-left, .w3-right, .w3-badge {
	cursor: pointer
}

.w3-badge {
	height: 13px;
	width: 13px;
	padding: 0
}
  #contents1{
  	margin:10px auto;
  	width: 70%;
  	border: solid 2px #e5e5e5;
  	min-height: 880px;
  	padding:5px 10px 5px 10px;
  	float:right;
  	}
  	.a li{
	display:block;
	float:left;
	padding: 10px 20px;
	text-decoration: none;
}
 #contents1 table
 {
 border-bottom:solid #e5e5e5 4px;
 table-layout: fixed;
 text-align:center;
 }
.a li:hover>a{
	color:pink;
	text-decoration: none;
}
#post th{
	border-bottom:solid #e5e5e5 2px;
	text-align:center;
}
#post th, td{
	border-bottom:solid #e5e5e5 2px;
	padding-top:7px;padding-bottom:7px;
}

#post a
{
	color: black;}
}
#post a:link 
{
	color: black;}
}
#post  a:visited
{
	color: black;}
}
#post a:active
{
	color: black;}
}
#post a:hover
{
	color: black;}
}
</style>

<script>
	$(function() {
		$(document).ready(function() {
			var nick_name = "<%= (String)session.getAttribute("nick_name") %>"
			if(nick_name != "null")
			{
	            document.getElementById("login_before").style.display="none";
	            document.getElementById("login_before").style.visibility="hidden";
	
	            document.getElementById("login_after").style.display="inline-block";
	            document.getElementById("login_after").style.visibility="visible";
			}
		});
		$(".zeta-menu li").hover(function() {
			$('ul:first', this).show();
		}, function() {
			$('ul:first', this).hide();
		});
		$(".zeta-menu>li:has(ul)>a").each(function() {
			$(this).html($(this).html() + ' &or;');
		});
		$(".zeta-menu ul li:has(ul)").find("a:first").append(
				"<p style='float:right;margin:-3px'>&#9656;</p>");
	});
    $(document).ready(function(){
      $('.slider').bxSlider();
    });
    
    function upload()
	{
		document.getElementById("user_id").value = nick_name;
		document.getElementById("img").submit;
	}
    var now_page = "1";

    function load_post()
	{
		<%
		int n = 1,cnt=1, pcnt = 0;
		String type = (String)request.getParameter("type");
		%>
		var type;
		if("<%=type%>" == "free")
		{
			type = "자유게시판";	
		}
		else if("<%=type%>" == "graduate")
		{
			type = "졸업생게시판";	
		}
		else if("<%=type%>" == "qa")
		{
			type = "Q&A";	
		}
		else if("<%=type%>" == "uggestions")
		{
			type = "건의사항";	
		}
		$('#post').append("<table id='group_<%=n%>' style='margin:auto;'>"
				+"<colgroup><col style='width:60px;'><col style='width:380px;'><col style='width:90px;'><col style='width:110px;'><col style='width:50px;'></colgroup>"
				+"<caption><p style='font-size:30px; font-weight:bold; text-align:center; margin:auto; padding-bottom:20px;'>"
				+type+"</p></caption>"
				+"<tr><th style='border-top:solid #e5e5e5 4px;'></th><th style='border-right:solid #e5e5e5 2px;  border-top:solid #e5e5e5 4px;'>글제목</th>"
				+"<th style='border-right:solid #e5e5e5 2px; border-top:solid #e5e5e5 4px;'>작성자</th><th style='border-right:solid #e5e5e5 2px; border-top:solid #e5e5e5 4px;'>작성일</th>"
				+"<th style='border-top:solid #e5e5e5 4px;'>조회</th></tr></table>");<%
		for(String[] list : (ArrayList<String[]>)post_list)
		{
			if(cnt%14 == 0)
			{
				n++;
					%>		$('#post').append("<table id='group_<%=n%>' style='margin:auto;display:none;visibility:hidden'>"
							+"<colgroup><col style='width:90px;'><col style='width:403px;'><col style='width:119px;'><col style='width:119px;'></colgroup>"
							+"<caption><p style='font-size:30px; font-weight:bold; text-align:center; margin:auto; padding-bottom:20px;'>"
							+type+"</p></caption>"
							+"<tr><th style='border-top:solid #e5e5e5 4px;'></th><th style='border-right:solid #e5e5e5 2px;  border-top:solid #e5e5e5 4px;'>글제목</th>"
							+"<th style='border-right:solid #e5e5e5 2px; border-top:solid #e5e5e5 4px;'>작성자</th><th style='border-right:solid #e5e5e5 2px; border-top:solid #e5e5e5 4px;'>작성일</th>"
							+"<th style='border-top:solid #e5e5e5 4px;'>조회</th></tr></table>");<%
			}
			%>
			$('#group_<%=n%>').append("<tr><td><%=list[0]%></td><td style='border-right:solid #e5e5e5 2px;'><a href=controller.jsp?action=load_post_detail&cnt=<%=list[0]%>&type=<%=type%>><div style='max-width:403px;text-overflow:ellipsis; overflow:hidden; white-space:nowrap;'><%=list[3]%></div></a></td>"
									 +"<td style='border-right:solid #e5e5e5 2px;'><%=list[2]%></td><td  style='border-right:solid #e5e5e5 2px;'><%=list[1].split(" ")[0]%></td><td><%=list[7]%></td></tr>");
		<%
			cnt++;
		}
		%>$('#group_<%=n%>').append("<tr><td height='27px'></td><td></td><td></td><td></td><td></td></tr>");
		$('#contents1').append("<div style='text-align: center;'><ul class ='a' id='page_button' style='margin: 0;padding: 0; display:inline-block;' ></ul></div>");
		<%
		for(int i = 1 ; i <= n ; i++)
		{
			%>
				$('#page_button').append("<li style='float: left; list-style:none'><a  href='javascript:void(0);' onclick='move_page(\"<%=i%>\")'> <%=i%></a></li>");
			<%
		}
		%>
	}
	function move_page(num)
	{
	    document.getElementById("group_"+now_page).style.display="none";
	    document.getElementById("group_"+now_page).style.visibility="hidden";
	    
	    document.getElementById("group_"+num).style.display="block";
	    document.getElementById("group_"+num).style.visibility="visible";
	    now_page=num;
	}
</script>
<title>CUVIC</title>
</head>

<body onload="load_post()">
	<div class="wrapper">
		<div id=user_info align="right">
			<table>
				<tr>
					<td style="padding-right: 20px;"><p>서민호</p></td>
					<td><button onclick="logout()"">로그아웃</button></td>
				</tr>
			</table>
			<a href="main.jsp"><img src="img/logo.png"style="display: block; margin: auto; padding-bottom: 20px; width:300px !important;"></a>
		</div>
						<div style="position: relative; z-index: 2">
				<div class='zeta-menu-bar'>
					<ul class="zeta-menu">
						<li><a href="main.jsp">공지사항</a></li>
						<li><a href="introduce.jsp">동아리 소개</a>
							<ul>
								<li><a href="introduce.jsp">동아리 소개</a></li>
								<li><a href="controller.jsp?&action=load_active_record">주요활동ㆍ실적</a></li>
								<li><a href="controller.jsp?action=load_info&group=1">동아리 회원</a>
									<ul>
										<li><a href="controller.jsp?action=load_info&group=1">1~5기</a></li>
										<li><a href="controller.jsp?action=load_info&group=2">6~10기</a></li>
										<li><a href="controller.jsp?action=load_info&group=3">11~15기</a></li>
										<li><a href="controller.jsp?action=load_info&group=4">16~20기</a></li>
										<li><a href="controller.jsp?action=load_info&group=5">21기~</a></li>
									</ul></li>
							</ul></li>
						<li><a href="controller.jsp?&action=load_picture_board">사진첩</a></li>
						<li><a href="controller.jsp?&action=load_board&type=free">게시판</a>
							<ul>
								<li><a href="controller.jsp?&action=load_board&type=free">자유게시판</a></li>
								<li><a href="controller.jsp?&action=load_board&type=graduate">졸업생게시판</a></li>
								<li><a href="controller.jsp?&action=load_board&type=qa">Q&A</a></li>
								<li><a href="controller.jsp?&action=load_board&type=uggestions">건의사항</a></li>
							</ul></li>
						<li><a href="controller.jsp?&action=load_seminar_board&year=2019">세미나</a>
							<ul>
								<li><a href="controller.jsp?&action=load_seminar_board&year=2019">2019년</a></li>
							</ul></li>
						<li><a href="controller.jsp?&action=load_data_board">자료실</a>
							<ul>
								<li><a href="controller.jsp?&action=load_data_board&type=job">취업자료</a></li>
								<li><a href="controller.jsp?&action=load_data_board&type=exam">시험자료</a></li>
								<li><a href="controller.jsp?&action=load_data_board&type=homework">과제공유</a></li>
								<li><a href="controller.jsp?&action=load_data_board&type=etc">기타</a></li>
							</ul></li>
					</ul>
				</div>
			</div>

			<div id="contents1" style="height: 880px;">
				<input type="button" style="float:right;" value="게시글작성" onClick="location.href='post_upload.jsp?type=<%=type%>'">
				<div id="post" style="clear:both; margin-top:50px;">
				</div>
	  		</div>
			<div id="login_before" style="padding: 5px;">
				<h1>Login</h1>
				<form method="post" action="controller.jsp">
					<input type="hidden" name="action" value="login">
					<div style="float: left;">
						<input type="text" name="id" placeholder="아이디" style="margin-bottom: 17px;" size="15"><br>
						<input type="password" name="password" placeholder="비밀번호" size="15">
					</div>
					<button name="login" style="float: right; width:100px; height:69px;">Login</button>
					<input type="button" style="float: left; width:45%; margin-top:5px;" onclick="location.href='sign_up.jsp'" value="회원가입">
					<button style="width:45%; float:right; margin-top:5px;" onclick="window.open('main.jsp','아이디/비번찾기','width=430,height=500,location=no,status=no,scrollbars=yes');">회원정보 찾기</button>
				</form>
	  		</div>
	  		<div id="login_after" style="padding: 5px; visibility:hidden; display:none;">
				<form method="post" action="controller.jsp">
					<h1 style="display:inline-block; margin-top:30%;"><%=session.getAttribute("nick_name") %></h1>
					<input type="hidden" name="action" value="logout">
					<input type="submit" style="margin-left:10px; width:90px; height:69px;" value="Logout">
				</form>
	  		</div>
	  		<div id="event_list">
	  			<h1>이달의 행사</h1>
	  		</div>
	  		<div id="new_post">
	  			<h1>최신글</h1>
	  		</div>	  		
	<div id="footer">
		<h1>뭐넣지</h1>
	</div>
</body>
</html>

