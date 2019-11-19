<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
 %>
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
	display: none
}

.w3-left, .w3-right, .w3-badge {
	cursor: pointer
}

.w3-badge {
	height: 13px;
	width: 13px;
	padding: 0;
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
    
    function check(type){
		if(type=="pw")
		{
	    	var pw1 = document.getElementById("password1");
			var pw2 = document.getElementById("password2");
			
			if(pw1.value == pw2.value){
				alert("비밀번호가 일치합니다.");
			}
			else{
				pw1.value="";
				pw2.value="";
				alert("비밀번호가 일치하지 않습니다.");
			}
		}
		else if(type="nick")
		{
			var name = document.getElementById("name").value;
			var club_num = document.getElementById("club_num").value;
			var nick_name = document.getElementById("nick_name").value;
			if(nick_name != club_num+" "+name){
				alert("닉네임은 형식을 따라주세요");
				document.getElementById("nick_name").value="";
				location.href="#nick_name";
			}
		}
	}
   	function info_open_check(){
   		var check = document.getElementsByName("info_open");
   		var r = "";
   		for(var i = 0 ;i < check.length ; i++)
   		{
   			if(check[i].checked)	
   			{
   				r += check[i].value;	
   			}
   		}
   		document.getElementsByName("open_state")[0].value=r;
   		alert(document.getElementsByName("open_state")[0].value);
   	}
   	var id_state=false,pw_state=false;
	function id_check()
   	{
   		var id = document.getElementsByName("id")[0].value;
   		if(id.length < 5 || id.length > 10)
   		{
   			alert("아이디는 5 ~ 10 자리입니다");
 			return;
   		}
   		for(var i = 0 ; i < id.length ; i++){
	   		if( (id[i] < 'A' || id[i] > 'Z') && (id[i] < 'a' || id[i] > 'z') && (id[i] < '0' || id[i] > '9') )
				{
					alert("아이디는 알파벳과 숫자만 가능합니다.");
					return;
				}
   		}
   		if(id == null || id.length < 1)
		{
			alert("아이디를 입력하세요");
		}
		else
		{
			document.getElementById("if").src="controller.jsp?action=IdCheck&id="+id;
   	
		}
   		id_state=true;
   	}
   	function pw_check(){
 		var password = document.getElementsByName("password")[0].value;
 		if(password.length < 5 || password.length > 10)
   		{
   			alert("비밀번호는 5 ~ 10 자리입니다");
   			return;
 		}
 		for(var i = 0 ; i < password.length ; i++){
 			if( (password[i] < 'A' || password[i] > 'Z') && (password[i] < 'a' || password[i] > 'z') && (password[i] < '0' || password[i] > '9') )
 			{	
 				alert("비밀번호는 알파벳과 숫자만 가능합니다.");
 				return;
 			}
 		}
 		pw_state=tre=true;
   	}
   	function SB(){
   		var type=['id', 'password1', 'password2', 'name', 'phone', 'Email', 'birth', 'club_num', 'nick_name'];
   		var name=['아이디', '비밀번호', '비밀번호', '이름', '핸드폰 번호', '이메일', '생년월일', '동아리 기수', '닉네임'];
   		
   		if(id_state == false)
		{
			alert("아이디 중복체크를 하세요.");
			return;
		}
   		if(document.getElementById("comment").value.length > 100){
   			alert("100자까지 입력 가능합니다.");
   			return;
   		}

   		for(var i = 0 ; i < 9 ; i++)
   		{
   			if(document.getElementById(type[i]).value == '')
   			{
   				alert(name[i]+'를 입력하세요.');
				location.href='#'+type[i];
				return;
   			}
   		}
		document.getElementsByName("user_id")[0].value = document.getElementsByName("id")[0].value
		if(document.getElementsByName("gender").checked)
		{
			document.getElementsByName("user_gender")[0].value = "m";
		}
		else
		{
			document.getElementsByName("user_gender")[0].value = "w";
		}
		document.getElementById("email").value = document.getElementById("Email").value + "@" + document.getElementById("Addr").value;
   		document.getElementById("sign").submit();
   		document.getElementById("img").submit();
   	}
   	function direct_input()
   	{
   		document.getElementById("email_address").style.display="inline";
   	}
 </script>
<title>CUVIC</title>
</head>

<body>
	<div class="wrapper">
		<div id=user_info align="right">
			<table>
				<tr>
					<td style="padding-right: 20px;"><p>서민호</p></td>
					<td><button onclick="logout()">로그아웃</button></td>
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
			<div id="contents" style="height: 1100px;">
				<form method="post" action="controller.jsp" id="sign"  target="if" >
					<input type="hidden" name="action" value="sign_up">
					<span>
						<p>아이디</p>
						<input type="text" id="id" name="id" placeholder="아이디" required>
						<input type="button" value="중복체크" onclick="id_check()">
						<p>5~10자, 알파벳, 숫자 가능</p>
					</span>
					<span>
						<p>비밀번호</p>
						<input type="password" name="password" id="password1" placeholder="비밀번호" onchange="pw_check()" required>
						<p>비밀번호 확인</p>
						<input type="password" placeholder="비밀번호 확인" id="password2" onchange="check('pw')" required>
						<p>5~10자, 알파벳, 숫자 가능</p>
					</span>
					<p>이름</p>
					<input type="text" name="name" id="name" placeholder="이름"><br><br>
					<lable id="_gender" style="margin-left:30px;">남자</lable><input type="radio" name="gender" value="m" checked="checked">
					<lable style="margin-left:30px;">여자</lable><input type="radio" name="gender" value="w">
					<p>핸드폰 번호</p>
					<input id="phone" type="text"name="phone_num" placeholder="핸드폰 번호" required>
					<p>이메일</p>
					<input type="text" id="Email" placeholder="이메일" required>@
					<select id="Addr">
						<option value="hanmail.net">hanmail.net</option>
						<option value="naver.com">naver.com</option>
						<option value="gmail.com">gmail.com</option>
						<option onclick="direct_input()">직접 입력</option>
					</select>
					<input type="hidden" id="email" name="email" value="">
					<input id="email_address" type="text" style="display:none">				
					<p>생년월일</p>
					<input id="birth" type="date" name="birth" required>
					<p">동아리 기수</p>
					<input type="number" name="club_num" id="club_num" placeholder="동아리 기수" required><br><br>
					<p>닉네임</p>
					<input type="text" name="nick_name" id="nick_name" placeholder="닉네임" onchange="check('nick')" required><br><br>
					<p>동아리 기수 이름 형식으로 해주세요 (ex:20기 홍길동)</p>
					<p>근무지</p>
					<input type="text" name="work_place" placeholder="근무지" required><br><br>
					<textarea cols="60" rows="5" name="comment" id="comment" style="resize:none;"></textarea>
					<hr style="border:1px solid black;" required>
					<span>
						<p>정보 공개여부</p>
						<lable>핸드폰 번호</lable><input type="checkbox" name="info_open" value="1" onclick="info_open_check()">
						<lable>생년월일</lable><input type="checkbox" name="info_open" value="2" onclick="info_open_check()">
						<lable>근무지</lable><input type="checkbox" name="info_open" value="3" onclick="info_open_check()">
						<lable>사진</lable><input type="checkbox" name="info_open" value="4" onclick="info_open_check()">
					</span>
					<input type="hidden" name="open_state" value=""><br>
				</form>
			<form action="fileupload.jsp" method="post" enctype="Multipart/form-data" id="img">
				<input type="hidden" name="user_id" value="">
				<input type="hidden" name="user_gender" value="">
				파일명 : <input type="file" name="fileName1"  accept="image/*">
			</form>
					<input type="button" style="float: left; width:45%; margin-top:5px;" onclick="SB()" value="회원가입">
					<input type="button" onclick="location.href='main.jsp'" value="취소">
		</div>
	  		<iframe name="if" id="if" style="width: 0px;height: 0px;border: 0px;"></iframe>
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


