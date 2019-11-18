<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
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
</script>
<title>CUVIC</title>
</head>

<body>
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
								<li><a href="controller.jsp?&action=load_data_board&type=job">취업자료</a></li>
								<li><a href="controller.jsp?&action=load_data_board&type=exam">시험자료</a></li>
								<li><a href="controller.jsp?&action=load_data_board&type=homework">과제공유</a></li>
								<li><a href="controller.jsp?&action=load_data_board&type=etc">기타</a></li>
							</ul></li>
					</ul>
				</div>
			</div>
			<div id="contents" style="height: 880px;">
				<img src="img/logo.png" width="300px;" style="display: block; margin: auto; padding:50px 0 20px 0;">
				<p style="font-weight: bold; font-size:20px;">동아리 소개 글</p>
				<p>&nbspC/C++, JAVA 등의 프로그래밍 언어를 사용하여 PC 용 각종 응용프로그램이나 iOS, Android, Windows Mobile 기반의 스마트폰 어플리케이션을 개발하고, 다양한 대회에 참가하여 회원들의 전공 관련 능력 함량 및 대외 활동을 통하여 다양한 경험을 해보는 것을 목표로 하는 연구동아리</p>
				<p style="font-weight: bold; font-size:20px;">연구분야</p>
				<p>&nbspC/C++, Python, JAVA등 프로그래밍 언어, iOS, Android, Windows Mobile등 스마트폰 어플리케이션 개발,알고리즘 연구.</p>
				<img src="img/조직도.png" width="500px;" style="display: block; margin: auto;">
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


