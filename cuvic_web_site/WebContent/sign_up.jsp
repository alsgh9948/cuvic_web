<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.util.*"%><% request.setCharacterEncoding("UTF-8");
response.setContentType("text/html;charset=UTF-8");
 %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<jsp:useBean id="db" class="cuvic_web_site.db_control" />

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
	padding: 0;
}
</style>

<script>
	$(function() {
		$.datepicker.setDefaults({
		    dateFormat: 'yy-mm-dd' //Input Display Format 변경
		});

		$("#birthday").datepicker();
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
 		if(password.length < 5 || password.length > 15)
   		{
   			alert("비밀번호는 5 ~ 15 자리입니다");
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
   		var type=['id', 'password1', 'password2', 'name', 'phone', 'Email', 'birthday', 'club_num'];
   		var name=['아이디', '비밀번호', '비밀번호', '이름', '핸드폰 번호', '이메일', '생년월일', '동아리 기수'];
   		
   		if(id_state == false)
		{
			alert("아이디 중복체크를 하세요.");
			return;
		}
   		if(document.getElementById("comment").value.length > 100){
   			alert("100자까지 입력 가능합니다.");
   			return;
   		}

   		for(var i = 0 ; i < 8 ; i++)
   		{
   			if(document.getElementById(type[i]).value == '')
   			{
   				alert(name[i]+'를 입력하세요.');
				location.href='#'+type[i];
				return;
   			}
   		}
		document.getElementsByName("user_id")[0].value = document.getElementsByName("id")[0].value
		if(document.getElementsByName("gender")[0].checked)
		{
			document.getElementsByName("user_gender")[0].value = "m";
		}
		else
		{
			document.getElementsByName("user_gender")[0].value = "w";
		}
		document.getElementById("email").value = document.getElementById("Email").value + "@" + document.getElementById("Addr").value;
		document.getElementById("nick_name").value = document.getElementById("club_num").value+"기"+document.getElementById("name").value;
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
			<div id="contents" style="height: 880px;">
				<form method="post" action="controller.jsp" id="sign"  target="if" >
					<input type="hidden" name="action" value="sign_up">
					<input type="hidden" name="nick_name" id="nick_name" value="">
					<span>
						<p>아이디</p>
						<input type="text" id="id" name="id" placeholder="아이디" required>
						<input type="button" value="중복체크" onclick="id_check()">
						<p>5~15자, 알파벳, 숫자 가능</p>
					</span>
					<span>
						<span>비밀번호 : </span><input type="password" name="password" id="password1" placeholder="비밀번호" onchange="pw_check()" required>
						<span>비밀번호 확인 : </span><input type="password" placeholder="비밀번호 확인" id="password2" onchange="check('pw')" required></span>
						<p>5~15자, 알파벳, 숫자 가능</p>
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
					<input type="text" id="birthday" name="birth" required>
					<p>동아리 기수</p>
					<input type="number" name="club_num" id="club_num" placeholder="동아리 기수" required><br><br>
					<p>근무지</p>
					<input type="text" name="work_place" placeholder="근무지" required><br><br>
					<textarea cols="60" rows="5" name="comment" id="comment" style="resize:none;"></textarea>
					<hr style="border:1px solid black;" required><br>
				</form>
			<form action="fileupload.jsp" method="post" enctype="Multipart/form-data" id="img">
				<input type="hidden" name="user_id" value="">
				<input type="hidden" name="user_gender" value="">
				프로필 사진 : <input type="file" name="fileName1"  accept="image/*">
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


