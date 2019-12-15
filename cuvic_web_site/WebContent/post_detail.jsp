<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*, java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<jsp:useBean id="post_list" scope="request" class="java.util.ArrayList" />
<jsp:useBean id="db" class="cuvic_web_site.db_control" />

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/main.css?version=2">
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
#contents1 td{
	border: solid 1px black;
	}
#contents1 th{
	width:50px;
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
.a li:hover>a{
	color:pink;
	text-decoration: none;
}
#contents1 img
{
	max-width:650px;
}
</style>
	<%
String nick_name = (String)session.getAttribute("nick_name");
%>
<script>
	$(function() {
		$(document).ready(function() {
			<%
			 ArrayList<String[]> lately_list = db.lately_post();
			 for(String[] post : lately_list)
			     	{
			 			String board = post[1].split("_")[0];
			 			if(board.equals("picture"))
			 			{
			 				%>
			 	    		$('#new_post').append("<a href=controller.jsp?action=load_picture_detail&cnt=<%=post[0]%>><%=post[2]%></a><br>");
			 	    		<%	
			 			}
			 			else
			 			{
			 				%>
			 	    		$('#new_post').append("<a href=controller.jsp?action=load_post_detail&cnt=<%=post[0]%>&type=<%=board%>><%=post[2]%></a><br>");
			 	    		<%
			 			}
			 			
			     	}
			%>
			var nick_name = "<%= (String)session.getAttribute("nick_name") %>"
			if(nick_name != "null")
			{
	            document.getElementById("login_before").style.display="none";
	            document.getElementById("login_before").style.visibility="hidden";
	
	            document.getElementById("login_after").style.display="inline-block";
	            document.getElementById("login_after").style.visibility="visible";
	            
	            document.getElementById("user_info").style.display="inline-block";
	            document.getElementById("user_info").style.visibility="visible";
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

    function load_picture()
	{
    	<%
		ArrayList<String[]> postlist = (ArrayList<String[]>)post_list;
		String type = request.getParameter("type");
		String path = "C:/Users/seo/Desktop/cuvic_web/cuvic_web_site/WebContent/post/"+type+"/"+ postlist.get(0)[5];
		File folder = new File(path);
		File[] file_list;
		String addtag="";
		if(folder.exists())
       	{        
       	file_list = folder.listFiles();
		for (int i = 0; i < file_list.length; i++)
		{
			if(file_list[i].isDirectory()) continue;
			addtag+="<a href=attachment_download.jsp?folder_name="+type+"/"+postlist.get(0)[5]+"&file_name="+file_list[i].getName()+">"+file_list[i].getName()+"</a><br>"; 
		}	
		}
		int n = 0,cnt=0, pcnt = 0;
		for(String[] list : postlist)
		{
			%>
			$('#contents1').append('<p>제목 : <%=list[3]%></p><hr><p> 작성자 : <%=list[2]%> 작성일 : <%=list[1].split(" ")[0]%> 조회수 : <%=list[7]%></p><hr>');
			$('#contents1').append("첨부파일<br><%=addtag%><hr>");
			$('#contents1').append('<%=list[4].replaceAll("(\r\n|\r|\n|\n\r)", "")%>'.replace(/\r/g, ''));
			<%
		}
		%>
		if(<%=postlist.get(0)[2].equals(nick_name)%>)
		{
            document.getElementById("modify").style.display="inline-block";
            document.getElementById("modify").style.visibility="visible";
            
            document.getElementById("delete").style.display="inline-block";
            document.getElementById("delete").style.visibility="visible";
		}	
	}
</script>
<title>CUVIC</title>
</head>

<body onload="load_picture()">
	<div class="wrapper">
		<div align="right">
			<table id="user_info" style="visibility:hidden; display:none;">
				<tr>
					<td style="padding-right: 20px;"><p><%=nick_name %></p></td>
					<td><button onclick="location.href='controller.jsp?action=logout'">로그아웃</button></td>
				</tr>
			</table>
			<a href="main.jsp"><img src="img/logo.png" width="300px;" style="display: block; margin: auto; padding-bottom: 20px;"></a>
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
						<li><a href="controller.jsp?&action=load_board&type=seminar&year=2019_1학년">세미나</a>
							<ul>
								<li><a href="controller.jsp?&action=load_board&type=seminar&year=2019_1학년">2019년</a>
								<ul>
									<li><a href="controller.jsp?&action=load_board&type=seminar&year=2019_1학년">1학년</a></li>
									<li><a href="controller.jsp?&action=load_board&type=seminar&year=2019_2학년">2학년</a></li>
								</ul></li>
							</ul></li>
						<li><a href="controller.jsp?&action=load_board&type=job">자료실</a>
							<ul>
								<li><a href="controller.jsp?&action=load_board&type=job">취업자료</a></li>
								<li><a href="controller.jsp?&action=load_board&type=exam">시험자료</a></li>
								<li><a href="controller.jsp?&action=load_board&type=assignment">과제공유</a></li>
								<li><a href="controller.jsp?&action=load_board&type=etc">기타</a></li>
							</ul></li>
					</ul>
				</div>
			</div>

			<div id="contents1">
				<input type="button" style="float:right;" value="게시글작성" onClick="location.href='post_upload.jsp?type=<%=(String)request.getParameter("type")%>'">
				<input type="button" style="float:right; display:none;visibility:hidden;" value="게시글수정" id="modify" onClick="location.href='post_upload.jsp?type=<%=type%>&cnt=<%=postlist.get(0)[0]%>'">				
				<input type="button" style="float:right; display:none;visibility:hidden;" value="게시글삭제" id="delete" onClick="location.href='controller.jsp?action=post_delete&type=<%=type%>&cnt=<%=postlist.get(0)[0]%>'">		
				<br>
				<br>
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
			<div id="birth">
	  			<p>이달의 생일</p>
	  		</div>
	  	    <div id="new_post" style="height:400px;">
	  			<p>최신글</p>
	  		</div>		
	<div id="footer">
		<h1>뭐넣지</h1>
	</div>
	</div>
</body>
</html>


