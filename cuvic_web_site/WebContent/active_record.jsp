<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<jsp:useBean id="active_record_list" scope="request" class="java.util.ArrayList" />

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">

<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
<script src="https://cdn.jsdelivr.net/bxslider/4.2.12/jquery.bxslider.min.js"></script>
<script	src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>

<link rel="stylesheet" type="text/css" href="css/main.css">
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
	$(document).ready(function() {
		var nick_name = "<%= (String)session.getAttribute("nick_name") %>"
		if(nick_name != "null")
		{
	        document.getElementById("login_before").style.display="none";
	        document.getElementById("login_before").style.visibility="hidden";
	
	        document.getElementById("login_after").style.display="inline-block";
	        document.getElementById("login_after").style.visibility="visible";
		}
		if(nick_name == "cuvic_web_master")
			{
	        document.getElementById("_hidden").style.display="inline-block";
	        document.getElementById("_hidden").style.visibility="visible";
			for(var i = 0 ; $("input:checkbox[name=select_element]").length ; i++)
				{
				document.getElementsByName("select_element")[i].display="inline-block";
				}
			}
	});
	$(function() {
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
	var count = 0;
    function load_list(){
    	<%
	    	int count = 0;
			for(String[] list : (ArrayList<String[]>)active_record_list)
			{
		%>
		count = <%=count%>;
		 $('#active').append("<div class='detail' id='select_<%=count%>' style='margin-right:5px;'>&nbsp"
					+"<%=list[1]%>&nbsp <span id='title'><%=list[0]%></span>"
					+"<span class='datail_text' ><%=list[3]%></sapn>"
					+"<input type='checkbox' style='display:none;' name='select_element' value='<%=count++%>'></div>");
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
	function add(){
		var title = document.getElementById("upload_title").value;
		var member = document.getElementById("upload_member").value;
		var date = document.getElementById("upload_date").value;
		var detail = document.getElementById("upload_detail").value;

		document.getElementsByName("title")[0].value = title
		document.getElementsByName("member")[0].value = member;
		document.getElementsByName("date")[0].value = date;
		document.getElementsByName("detail")[0].value = detail;
		
		alert(title);
		$('#active').append("<div class='detail' id='select_"+(++count)+"' style='margin-right:5px;'>&nbsp"
							+date+"&nbsp<span id='title'>"+title+"</span><span class='datail_text'></sapn> <input type='checkbox' name='select_element' value='"+count+++"'></div>");	

		document.getElementById("upload_title").value = "";
		document.getElementById("upload_member").value = "";
		document.getElementById("upload_date").value = "";
		document.getElementById("upload_detail").value = "";
		
		document.getElementById("form1").submit();
	}
    function modify_data(){
    	var select_element = document.getElementsByName("select_element");
		var list = "";
    	for(var i = 0 ; i < <%=count%> ; i++){
    		if(select_element[i].checked)
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
		<div id=user_info align="right">
			<table>
				<tr>
					<td style="padding-right: 20px;"><p>서민호</p></td>
					<td><button onclick="logout()"">로그아웃</button></td>
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
								<li><a href="controller.jsp?action=load_info">동아리 회원</a>
									<ul>
										<li><a href="#">1~5기</a></li>
										<li><a href="#">6~10기</a></li>
										<li><a href="#">11~15기</a></li>
										<li><a href="#">16~20기</a></li>
										<li><a href="#">21기~</a></li>
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
								<li><a href="controller.jsp?action=load_data_board&type=job">취업자료</a></li>
								<li><a href="controller.jsp?action=load_data_board&type=exam">시험자료</a></li>
								<li><a href="controller.jsp?action=load_data_board&type=homework">과제공유</a></li>
								<li><a href="controller.jsp?action=load_data_board&type=etc">기타</a></li>
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
				<input type="date" id="upload_date"><br>
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