<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="active_record_list" scope="request" class="java.util.ArrayList" />
<jsp:useBean id="db" class="cuvic_web_site.db_control" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<link rel="stylesheet" href="https://code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>

<link rel="stylesheet" type="text/css" href="css/main.css?version=2">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.css">


<style>
.mySlides {
	display: none
}

.w3-left, .w3-right, .w3-badge {
	cursor: pointer
}

.w3-badge {
	height: 13px;
	width: 13px;
	padding: 0
}

.detail .detail_text {
  visibility: hidden;
  width: 120px;
  background-color: #555;
  color: #fff;
  text-align: center;
  border-radius: 6px;
  padding: 5px 0;
  position: absolute;
  z-index: 1;
  bottom: 125%;
  left: 50%;
  margin-left: -60px;
  opacity: 0;
  transition: opacity 0.3s;
}

.detail .detail_text::after {
  content: "";
  position: absolute;
  top: 100%;
  left: 50%;
  margin-left: -5px;
  border-width: 5px;
  border-style: solid;
  border-color: #555 transparent transparent transparent;
}

.detail:hover .detail_text {
  visibility: visible;
  opacity: 1;
}
</style>

<script>
<%
String nick_name = (String)session.getAttribute("nick_name");
%>
var nick_name = "<%=nick_name %>"
function load_list(){
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
    	int count = 0;
		for(String[] list : (ArrayList<String[]>)active_record_list)
		{
	%>
	if(nick_name != "WebMaster")
	 {
		$('#active').append("<div class='detail' id='select_<%=count%>' style='margin-right:5px;'>&nbsp"
				+"<%=list[1]%>&nbsp <span id='title'><%=list[0]%></span>"
				+"<span class='datail_text' ><%=list[3]%></sapn>"
				+"&nbsp;<input type='checkbox' style='display:none;' name='select_element' value='<%=count%>'></div>");
	 }
	else
		{
		$('#active').append("<div class='detail' id='select_<%=count%>' style='margin-right:5px;'>&nbsp"
				+"<%=list[1]%>&nbsp <span id='title'><%=list[0]%></span>"
				+"<span class='datail_text' ><%=list[3]%></sapn>"
				+"&nbsp;<input type='checkbox' name='select_element' value='<%=count%>'></div>");
		}
	<%count++;%>
	<%
		}
	%>
}
function load_css(){
	var style = document.createElement('style');
	style.innerHTML = ".detail .detail_text {"
			  				+"visibility: hidden;"
			  				+"width: 120px;"
			  				+"background-color: #555;"
		  					+"color: #fff;"
		  					+"text-align: center;"
		  					+"border-radius: 6px;"
		  					+"padding: 5px 0;"
		  					+"position: absolute;"
		  					+"z-index: 1;"
		  					+"bottom: 125%;"
		  					+"left: 50%;"
		  					+"margin-left: -60px;"
		  					+"opacity: 0;"
		  					+"transition: opacity 0.3s;}"
		  				+".detail .detail_text::after {"
		  					+"content: '';"
		  					+"position: absolute;"
		  					+"top: 100%;"
		  					+"left: 50%;"
		  					+"margin-left: -5px;"
		  					+"border-width: 5px;"
		  					+"border-style: solid;"
		  					+"border-color: #555 transparent transparent transparent;}"
		  				+".detail:hover .detail_text {"
		  				  	+"visibility: visible;"
		  				  	+"opacity: 1;}"
	document.body.appendChild(style);
}

	$(document).ready(function() {
		
		if(nick_name != "null")
		{
	        document.getElementById("login_before").style.display="none";
	        document.getElementById("login_before").style.visibility="hidden";
	
	        document.getElementById("login_after").style.display="inline-block";
	        document.getElementById("login_after").style.visibility="visible";
	        
            document.getElementById("user_info").style.display="inline-block";
            document.getElementById("user_info").style.visibility="visible";
		}
		if(nick_name == "WebMaster")
			{
	        document.getElementById("_hidden").style.display="inline-block";
	        document.getElementById("_hidden").style.visibility="visible";
			}
	});
	$(function() {
		$.datepicker.setDefaults({
		    dateFormat: 'yy-mm-dd' //Input Display Format 변경
		});

		$("#upload_date").datepicker();
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

	function add(){
		var count = $("input[name=select_element]").length-1;
		var title = document.getElementById("upload_title").value;
		var member = document.getElementById("upload_member").value;
		var date = document.getElementById("upload_date").value;
		var detail = document.getElementById("upload_detail").value;

		document.getElementsByName("title")[0].value = title
		document.getElementsByName("member")[0].value = member;
		document.getElementsByName("date")[0].value = date;
		document.getElementsByName("detail")[0].value = detail;
		
		$('#active').append("<div class='detail' id='select_"+(++count)+"' style='margin-right:5px;'>&nbsp"
							+date+"&nbsp<span id='title'>"+title+"</span><span class='datail_text'></sapn> <input type='checkbox' name='select_element' value='"+count+"'></div>");	
		document.getElementById("upload_title").value = "";
		document.getElementById("upload_member").value = "";
		document.getElementById("upload_date").value = "";
		document.getElementById("upload_detail").value = "";
		document.getElementById("form1").submit();
	}
    function modify_data(){
    	var select_element = document.getElementsByName("select_element");
		var list = "";
		var loof_size = $("input[name=select_element]").length;
    	for(var i = 0 ; i < loof_size; i++){
    		if(select_element[i].checked == true)
    		{
    			list += "'"+$("#select_"+i+"> #title").html()+"',";
    		}
    	}
    	location.href="controller.jsp?action=delete_active_record&list="+list;
    }
</script>
<title>CUVIC</title>
</head>

<body onload="load_list()">
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
	  		<iframe name="if" id="if" style="width: 0px;height: 0px;border: 0px;"></iframe>
	  		<form action="controller.jsp" method="post" id="form1" target="if">
	  			<input type="hidden" name="action" value="insert_active_record">
	  			<input type="hidden" name="title" value="">
	  			<input type="hidden" name="member" value="">
	  			<input type="hidden" name="date" value="">
	  			<input type="hidden" name="detail" value="">
	  		</form>
	  		<div id="contents" style="height: 880px;" onload="load_css()">
				<div id="active" style="margin-top: 30px; clear:both;">
					<p style="font-weight: bold; font-size:20px; display: inline;">주요활동</p>
				</div>
			<div id="_hidden" style="display:none; visibility:hidden;">
				<input type="text" id="upload_date" name="upload_date"><br>
				<input type="text" size="73" id="upload_title"><br> <input type="text" size="73" id="upload_member"><br>
				<textarea cols="75" rows="11" name=text id="upload_detail"></textarea>
				<button onclick="modify_data()">삭제하기</button>

				<button onclick="add()">추가하기</button>
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